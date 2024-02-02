Der Fokus liegt auf Einfachheit. Da ich im Bereich Netzwerk noch ein Anfänger bin, ist die Segmentierung und die Sicherheit noch ziemlich schlecht.

## Topologie

192.168.20.1/24 Netzwerk überträgt bereits die VLAN Id 20. Der Zyxel Switch ist aber noch nicht für tagging/untagging konfiguriert.

```
     +------------+
     |            |
     |  Internet  |
     |            |
     +------|-----+
            |                        +------------------------------------------+
            |                        |                                          |
   +--------|--------+               |             Linksys Router + Switch      |
   |  Magenta Modem  |               |                                          |
   |   Bridge Mode   |               +--------+-----++-----++-----++-----++-----+
   +--------+-----+--+                        | WAN ||Port1||Port2||Port3||Port4|
               |Port1|                        +--|--++-----++-----++-----++-----+
               +--|--+               192.168.1.1 |      |      |      |
                  |                              |      |      |      --- TV 192.168.1.13
                  |                              |      |      --- pi-hole 192.168.1.2
                  |                              |      |
                  -------------------------------|      |  192.168.20.1/24
                                                        |
                                                        |
         ------------------------------------------------
         |
         |       +--------------------------------------------------------+
         |       |            Zyxel GS1200-8 Managed Switch               |
         |       |                   192.168.20.10                        |
         |       +-+-----++-----++-----++-----++-----++-----++-----++-----+
         |         |Port1||Port2||Port3||Port4||Port5||Port6||Port7||Port8|
         |         +-----++-----++-----++-----++-----++-----++-----++-----+
         |           |       |      |      |      |       |
         |           |       |      |      |      |       |
         -------------       |      |      |      |       |
                             |      |      |      |       |
                             |      |      |      |       --- PC     192.168.20.103
                             |      |      |      --- pve-m720q-03   192.168.20.102
                             |      |      ---  pve-m720q-02         192.168.20.101
  TrueNAS Scale ----------          --- pve-m720q-01                 192.168.20.100
  192.168.20.50
```

## IP Adressen

### PVE Cluster

| IP                 | Service                |
|--------------------|------------------------|
| 192.168.20.10      | Zyxel GS1200-8         |
| 192.168.20.50      | TrueNAS Scale          |
| 192.168.20.51-99   | TrueNAS apps reserved  |
| 192.168.20.100     | pve-m720q-01           |
| 192.168.20.101     | pve-m720q-02           |
| 192.168.20.102     | pve-m720q-03           |
| 192.168.20.103-109 | pve reserved           |
| 192.168.20.110     | k8s-01                 |
| 192.168.20.111     | k8s-02                 |
| 192.168.20.112     | k8s-03                 |
| 192.168.20.113-129 | k8s reserved           |
| 192.168.20.130     | k8s-gateway            |
| 192.168.20.131     | reserviert für pi-hole |
| 192.168.20.132     | nginx-external         |
| 192.168.20.133     | nginx-internal         |
| 192.168.20.131-253 | cilium LB pool         |
| 192.168.20.254     | kube_vip               |
