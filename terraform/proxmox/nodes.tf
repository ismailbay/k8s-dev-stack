resource "proxmox_virtual_environment_vm" "talos_vm" {
  for_each = var.nodes

  name        = each.key
  description = "managed by Terraform"
  tags        = ["k8s", "debian"]

  node_name = each.value.node_name
  vm_id     = each.value.id
  started   = true
  on_boot   = true

  machine = "q35"

  initialization {
    ip_config {
      ipv4 {
        address = each.value.ip4_addr
        gateway = "192.168.20.1"
      }
    }
  }

  cpu {
    cores = var.common.cores
    type = "x86-64-v2-AES"
  }

  memory {
    dedicated = each.value.memory
  }

  operating_system {
    type = "l26"
  }

  agent {
    enabled = true
  }

  scsi_hardware = "virtio-scsi-single"

  boot_order = ["ide3", "scsi0"]

  disk {
    datastore_id = "local-lvm"
    size         = var.common.disk0
    interface    = "scsi0"
    ssd          = true
    discard      = "on"
    cache        = "writeback"
    iothread     = true
    file_format  = "raw"
  }

  cdrom {
    enabled = true
    file_id = "nfs-iso:iso/talos.nocloud.1.8.1-amd64.iso"
  }

  network_device {
    model       = "virtio"
    mac_address = each.value.macaddr
    bridge      = "vmbr0"
  }

  tpm_state {
    version = "v2.0"
  }

  # nvme
  hostpci {
    device = "hostpci0"
    id     = "0000:01:00.0"
    rombar = true
    pcie   = true
  }

  # iGPU
  hostpci {
    device = "hostpci1"
    id     = "0000:00:02"
    rombar = true
    pcie   = true
  }

  # clone {
  #   vm_id     = each.value.clone_vm_id
  #   node_name = each.value.clone_node_name
  # }

  tablet_device = false

}
