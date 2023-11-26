provider "proxmox" {
  insecure = true
  username = "root@pam"
  password = data.sops_file.secrets.data["pm_root_password"]
  endpoint = var.pm_api_url
}

provider "sops" {}
