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

