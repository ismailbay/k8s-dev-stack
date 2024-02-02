
## Netzwerk

* Linksys WRT3200ACM mit [OpenWrt](https://openwrt.org)
* Zyxel GS1200-8

## TrueNAS Scale

Dieser Server stellt Storage bereit und hostet einige [Truecharts](https://truecharts.org) Apps wie Gitea, MinIO und Paperless.

| Teil       | Modell                   |      € |
|------------|--------------------------|-------:|
| Mainboard  | Fujitsu D3644-B          |    200 |
| Cpu        | i3-8100 (used)           |     45 |
| Ram        | 2 x 32 GB ECC DDR4-3200  |    280 |
| Boot Disk  | 128 GB SSD               | reused |
| SSD Pool   | 2 x 256 GB SSD           | reused |
| Tank Pool  | 3 x 6TB Seagate IronWolf |    420 |
| Gehäuse    | RackMount 4HE (used)     |     30 |
| Netzteil   | Pico 150W + Leicke 160W  |     40 |
| Kleinteile | Kabel, etc.              |     60 |

## Proxmox Cluster

| Host         | Modell       | RAM   | Boot Disk  | Storage                   |     € |
|--------------|--------------|-------|------------|---------------------------|------:|
| pve-m720q-01 | Lenovo m720q | 32 GB | 256 GB SSD | 1 TB Samsung 980 NVMe     | ~ 120 |
| pve-m720q-02 | Lenovo m720q | 16 GB | 256 GB SSD | 1 TB Samsung 980 Pro NVMe | ~ 120 |
| pve-m720q-03 | Lenovo m720q | 16 GB | 256 GB SSD | 1 TB Samsung 980 NVMe     | ~ 120 |

## Ausbau in Zukunft

* UniFi Switch Pro 24 PoE (Layer 3)
* UniFi Access Points
