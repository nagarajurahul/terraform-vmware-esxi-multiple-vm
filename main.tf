module "vm"{
  source = "git::https://github.com/nagarajurahul/terraform-vmware-esxi-single-vm.git?ref=v1.2.0"

  for_each = var.vms

  esxi_hostname    = each.value.esxi_hostname
  esxi_hostport    = "22"
  esxi_hostssl     = "443"
  esxi_username    = each.value.esxi_username
  esxi_password    = each.value.esxi_password
  disk_store       = each.value.disk_store
  virtual_network  = each.value.virtual_network
  vm_hostname      = each.value.vm_hostname
  vm_password      = each.value.vm_password
  ovf_file         = each.value.ovf_file
  ssh_public_key   = each.value.ssh_public_key
}