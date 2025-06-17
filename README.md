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

## 🧱 Prerequisites

- **Terraform ≥ 0.12**
- **ESXi (Free or Paid)**
- **OVA file** (example: Ubuntu 24.04 cloud image)
- **ovftool** installed (optional, for inspecting .ova)

---

## 🔧 Provider Setup
This project uses the josenk/esxi Terraform provider, which supports deploying directly to free ESXi without vCenter.

---

## 📥 Input Variables
The vms variable defines all VM configurations in one structured map

Example terraform.tfvars

```bash
vms = {
  "vm1" = {
    esxi_hostname   = "<your-esxi-hostname>"
    esxi_username   = "<your-esxi-username>"
    esxi_password   = "<your-esxi-password>"
    
    virtual_network = "VM Network"
    disk_store      = "datastore1"
    vm_hostname     = "rahul-linux-1"
    vm_password     = "<your-vm-password>"
    ovf_file        = "noble-server-cloudimg-amd64.ova"
    ssh_public_key  = "ssh-ed25519 AAAAC3...your-key...user@host"
  },
  "vm2" = {
    ...
  }
}
```

---

## 🚀 Usage

Initialize and apply the configuration:

```bash
terraform init

terraform plan
or
terraform plan --var-file="custom.tfvars"

terraform apply
or
terraform apply --var-file="custom.tfvars"
```

---

## 📤 Outputs

| Output Name              | Description                             |
| ------------------------ | --------------------------------------- |
| `vm_ips`                 | Map of VM names to IP addresses         |
| `vm_hostnames`           | Map of VM names to hostnames            |
| `ansible_inventory`      | INI-style inventory block for Ansible   |
| `ansible_inventory_json` | JSON-formatted Ansible inventory object |

---

## 📡 Ansible Integration
You can directly use the generated inventory output in an Ansible playbook like so:

```bash
terraform output -raw ansible_inventory > inventory.ini
ansible -i inventory.ini all -m ping
```

---

## 🔒 Security Notes

- Ensure your OVF/OVA images are trusted and signed.

- Avoid hardcoding secrets in *.tf files — use environment variables or a secret manager.

- Always use .gitignore to exclude .terraform/, terraform.tfstate, and sensitive var files.

---

## 📦 Module Reference
This project uses a reusable module stored in a remote Git repo:

```bash
module "vm" {
  source = "git::<https://github.com/nagarajurahul/terraform-vmware-esxi-vm-module.git?ref=v2.0.3>"
  ...
}
```

---

## 🧹 Cleanup
To destroy all VMs and resources:

```bash
terraform destroy -auto-approve
```
---

## ✨ Author
Rahul Nagaraju Cloud & DevOps Engineer

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
