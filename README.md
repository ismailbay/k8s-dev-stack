## 📖 &nbsp; Overview

Just a learning project for setting up a Kubernetes Cluster with Talos Linux and tools like Terraform, Flux CD, and so on.

## 🔧 &nbsp; Hardware

![pve-cluster](docs/assets/pve-cluster.png)

| Device                        | OS Disk Size | Data Disk Size            | CPU      | Ram  | Purpose             |
| ----------------------------- | ------------ | ------------------------- | -------- | ---- | ------------------- |
| Lenovo M720q                  | 256 GB SSD   | 1 TB Samsung 980 NVMe     | i3-8100T | 32GB | k3s master & worker |
| Lenovo M720q                  | 256 GB SSD   | 1 TB Samsung 980 Pro NVMe | i3-8100T | 16GB | k3s master & worker |
| Lenovo M720q                  | 256 GB SSD   | 1 TB Samsung 980 NVMe     | i3-8100T | 16GB | k3s master & worker |
| Custom Server Fujitsu D3644-B | 128 GB SSD   | 2 x 256 SSD, 3 x 6 TB HDD | i3-8100  | 64GB | TrueNAS Scale       |

## 🤝 &nbsp; Credits

[Cluster Template by onedr0p](https://github.com/onedr0p/cluster-template)