variable "vms" {
  type = map(object({
    esxi_hostname   = string
    esxi_username   = string
    esxi_password   = string
    disk_store      = string
    virtual_network = string
    vm_hostname     = string
    vm_password     = string
    ovf_file        = string
    default_user    = string
    users           = map(object({
      password = string
      ssh_keys = list(string)
    }))
  }))
}