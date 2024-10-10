variable "pm_api_url" {
  default = "https://192.168.20.100:8006/api2/json"
}

variable "common" {
  type = map(string)
  default = {
    cores       = 4
    pv_lvm      = "local-lvm"
    disk0       = "130"
  }
}

variable "nodes" {
  type = map(map(string))
  default = {
    k8s-01 = {
      id              = 110
      macaddr         = "02:DE:4D:48:28:10"
      ip4_addr        = "192.168.20.110/24"
      node_name       = "m720q-01"
      memory          = 24576
      clone_vm_id     = "9000"
      clone_node_name = "m720q-01"
    },
    k8s-02 = {
      id              = 111
      macaddr         = "02:DE:4D:48:28:11"
      ip4_addr        = "192.168.20.111/24"
      node_name       = "m720q-02"
      memory          = 12288
      clone_vm_id     = "9001"
      clone_node_name = "m720q-02"
    },
    k8s-03 = {
      id              = 112
      macaddr         = "02:DE:4D:48:28:12"
      ip4_addr        = "192.168.20.112/24"
      node_name       = "m720q-03"
      memory          = 12288
      clone_vm_id     = "9002"
      clone_node_name = "m720q-03"
    }
  }
}
