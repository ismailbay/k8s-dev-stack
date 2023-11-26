terraform {
  cloud {
    organization = "ismailbay"

    workspaces {
      name = "pve-k8s-dev-stack"
    }
  }
}
