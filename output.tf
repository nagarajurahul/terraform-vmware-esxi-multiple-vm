output "vm_ips" {
  value = {
    for name, mod in module.vm : name => mod.vm_ip
  }
  description = "IP addresses of all deployed VMs"
}

output "vm_hostnames" {
  value = {
    for name, mod in module.vm : name => mod.vm_hostname
  }
  description = "Hostnames of all deployed VMs"
}

output "ansible_inventory" {
  value = join("\n", concat(
    ["[vms]"],
    [
      for name, mod in module.vm :
      "${mod.vm_hostname} ansible_host=${mod.vm_ip} ansible_user=ubuntu"
    ]
  ))
  description = "Ansible inventory formatted for SSH access"
}

