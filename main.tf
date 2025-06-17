locals {
  first = keys(var.vms)[0]
}

provider "esxi" {
  esxi_hostname = var.vms[local.first].esxi_hostname
  esxi_username = var.vms[local.first].esxi_username
  esxi_password = var.vms[local.first].esxi_password
}

module "vm"{
  source = "git::https://github.com/nagarajurahul/terraform-vmware-esxi-vm-module.git?ref=v1.3.1"

  for_each = var.vms

  esxi_hostname    = each.value.esxi_hostname
  esxi_username    = each.value.esxi_username
  esxi_password    = each.value.esxi_password

  disk_store       = each.value.disk_store
  virtual_network  = each.value.virtual_network
  vm_hostname      = each.value.vm_hostname
  vm_password      = each.value.vm_password
  ovf_file         = each.value.ovf_file
  ssh_public_key   = each.value.ssh_public_key
}