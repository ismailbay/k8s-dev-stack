terraform {
  required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.73.1"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.3.0"
    }
  }
}
