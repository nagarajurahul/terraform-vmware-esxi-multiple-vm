# terraform-vmware-esxi-multiple-vm

# Terraform VMware ESXi Multi-VM Automation

This project enables fully automated provisioning of **multiple virtual machines on a free VMware ESXi host** using [Terraform](https://www.terraform.io/) and the community [josenk/esxi](https://github.com/josenk/terraform-provider-esxi) provider. It supports VM deployment via OVA/OVF images, cloud-init-compatible bootstrapping, and generates a ready-to-use Ansible inventory for post-provision configuration.

## 🌟 Features

- 📦 Automates multiple VM provisioning from a single Terraform run
- 🔐 Supports SSH key injection and password setup
- 🧾 Outputs inventory for Ansible-based automation
- 🔄 Uses reusable, versioned VM module via Git
- ✅ Compatible with free ESXi (no vCenter required)
- 🔧 Generates IPs, hostnames, and inventory in both INI and JSON format

---


- 🔁 Refactor into reusable Terraform modules for multi-VM deployments
- 📦 Add support for additional disks, ISO-based installs, and resource pools
- 🔐 Secure secrets with tools like HashiCorp Vault or Mozilla SOPS
- 🧪 Integrate GitHub Actions for Terraform linting, formatting, and validation
- 📘 Split and manage `userdata.tpl` via template directories for better readability
- 🧱 Add post-provisioning steps using Ansible or remote-exec
- 🛰 Implement DHCP/static IP assignment and DNS registration
- 🧵 Add VM health checks and `cloud-init status` verification
- 🎨 Generate architecture diagrams with draw.io or Mermaid for documentation
- 🔁 Integrate with GitOps tools like ArgoCD or Flux for full lifecycle control
