Bevor wir die VMs per Terraform provisionieren, müssen noch einige Schritte manuell erledigt werden.

## Helper Scripts

[Proxmox Helper Scripts](https://tteck.github.io/Proxmox/) beinhalten nützliche Skripte, die man nach jeder Proxmox-Installation ausführen:

* Post Install
* Kernel Clean
* Processor Microcode
* CPU Scaling Governor

## Powertop

[Powertop](https://wiki.ubuntuusers.de/PowerTOP/) hilft dabei, dass der Server tiefere
Stromsparzustände erreichen kann und somit auch weniger Wärme produziert.

Per SSH am Proxmox Server anmelden:

   ```bash
   apt install powertop

   cat << EOF | tee /etc/systemd/system/powertop.service
   [Unit]
   Description=PowerTOP auto tune

   [Service]
   Type=oneshot
   Environment="TERM=dumb"
   RemainAfterExit=true
   ExecStart=/usr/sbin/powertop --auto-tune

   [Install]
   WantedBy=multi-user.target
   EOF

   systemctl daemon-reload
   systemctl enable powertop.service
   systemctl start powertop.service

   ```

## NVMe & iGPU Passthrough

### IOMMU aktivieren

Die Datei `/etc/default/grub` editieren:

  ```
  #
  GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt pcie_acs_override=downstream,multifunction initcall_blacklist=sysfb_init video=simplefb:off video=vesafb:off video=efifb:off video=vesa:off disable_vga=1 vfio_iommu_type1.allow_unsafe_interrupts=1 kvm.ignore_msrs=1 modprobe.blacklist=radeon,nouveau,nvidia,nvidiafb,nvidia-gpu,snd_hda_intel,snd_hda_codec_hdmi,i915"
  #
  ```

Zu `/etc/modules` hinzufügen:
```
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
```

Editieren bzw. Erstellen von `/etc/modprobe.d/vfio-pci.conf`
```bash
# richtige IDs ermitteln:
# lspci -nn | grep -i nvme
# in meinem Fall:
# 01:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd NVMe SSD Controller 980 [144d:a809]
options vfio-pci ids=144d:a809
softdep nvme pre: vfio-pci
```

```bash
update-grub && update-initramfs -u && reboot
```

Ob alles erfolgreich war, kann man nach einem SSH-Login mit `dmesg | grep 'IOMMU enabled'` überprüfen.

## cloud-init Template
Unter Datacenter -> Storage `local` um die Auswahl `Snippets` erweitern.

Auf jedem Node in Shell die Datei `var/lib/vz/snippets/cloudinit.yaml` erstellen:

```bash
#cloud-config
ssh_pwauth: true
disable_root: false
chpasswd:
  list: |
    root:password
  expire: false

write_files:
  - path: /etc/sudoers.d/cloud-init
    content: |
      Defaults !requiretty

package_update: true
package_upgrade: true
packages:
 - qemu-guest-agent
 - curl
 - wget

ssh_authorized_keys:
  - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKbJSmbCeDjS0o9ggGab+qvesi6zulkfwXv25pBIblT1

runcmd:
  - sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
  - sed -i -e 's/^GSSAPIAuthentication yes/GSSAPIAuthentication no/g' /etc/ssh/sshd_config
  - sed -i -e 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
  - systemctl restart sshd
  - systemctl enable qemu-guest-agent
  - systemctl start qemu-guest-agent
```

```bash
BASE_IMAGE=https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2
VM_ID=9000 # increase by 1 and repeat on the next node

cd /tmp
wget -O debian-cloudinit.qcow2 $BASE_IMAGE
qm create $VM_ID --memory 4096 --cores 4 --name debian-cloud --net0 virtio,bridge=vmbr0
qm importdisk $VM_ID debian-cloudinit.qcow2 local-lvm
qm set $VM_ID --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-$VM_ID-disk-0
qm resize $VM_ID scsi0 20G
qm set $VM_ID --ide2 local-lvm:cloudinit
qm set $VM_ID --boot c --bootdisk scsi0
qm set $VM_ID --serial0 socket --vga serial0
qm set $VM_ID --agent 1
qm set $VM_ID --tablet 0
qm set $VM_ID --ipconfig0 ip=dhcp

#cloudinit config
qm set $VM_ID --cicustom "user=local:snippets/cloudinit.yaml"
qm template $VM_ID
```
