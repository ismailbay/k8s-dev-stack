terraform {
  required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.66.1"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.1.1"
    }
  }
}
