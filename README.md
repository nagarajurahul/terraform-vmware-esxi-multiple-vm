# terraform-vmware-esxi-multiple-vm

# Terraform VMware ESXi Multi-VM Automation

Provision multiple VMs on a free VMware ESXi host with a single Terraform run using this production-ready setup. It uses a reusable module, the community [josenk/esxi](https://github.com/josenk/terraform-provider-esxi) provider and supports dynamic cloud-init configuration, secure access, and Ansible-ready inventory generation.

## 🌟 Features

- 📦 Automates multiple VM provisioning using `for_each` and structured input
- 🔄 Modular architecture using a versioned Git-based Terraform module
- ☁️ Supports cloud-init for automatic user/password setup, SSH access, and config
- 🔐 Injects SSH public keys and optional plain-text passwords
- 🧾 Generates Ansible inventory in INI and JSON formats
- 🌐 Automatically collects IP addresses and hostnames
- ✅ Compatible with free ESXi (no vCenter required)

---

## 🧱 Prerequisites

- **Terraform ≥ 0.12**
- **ESXi host(Free or Licensed)**
- **josenk/esxi provider**
- **Cloud-ready OVA file** (example: Ubuntu 24.04 cloud image)
- **ovftool** installed

---

## 🔧 Provider Setup
This project uses josenk/esxi, a community Terraform provider supporting direct ESXi host automation.

```bash
provider "esxi"{
  esxi_hostname   = "<your-esxi-hostname>"
  esxi_username   = "<your-esxi-username>"
  esxi_password   = "<your-esxi-password>"
}
```  

---

## 📥 Input Variables
The vms variable defines all VM configurations in one structured map

Sample input in terraform.tfvars

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

## 📦 Module Usage

The project uses a remote, versioned Terraform module:

```bash
module "vm" {
  source = "git::https://github.com/nagarajurahul/terraform-vmware-esxi-vm-module.git?ref=v2.0.3"
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
```

---

## 🚀 Getting Started

### 1️⃣ Download a Cloud-Ready OVA

Get Ubuntu cloud images:

```bash
wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.ova
```

### 2️⃣ Define the provider (in parent project)

```bash
provider "esxi" {
  esxi_hostname   = "<your-esxi-hostname>"
  esxi_hostport   = "22"
  esxi_hostssl    = "443"
  esxi_username   = "<your-esxi-username>"
  esxi_password   = "<your-esxi-password>"
}
```

### 2️⃣ Run Terraform for your parent project

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

Or use JSON output with dynamic tooling:
```bash
terraform output -json ansible_inventory_json
```

---

## 🔒 Security Best Practices

- 🔐 Use terraform.tfvars and .tfvars.json files to inject secrets (never hardcode in .tf).

- ⚠️ Exclude .terraform/, *.tfstate, and secret files with .gitignore.

- 🔑 Prefer SSH key authentication over plain passwords.

- 🔐 Consider integrating Vault or SOPS for secret management.

---

## 🧹 Cleanup
To destroy all VMs and resources:

```bash
terraform destroy -auto-approve
```
---

## 🔮 Roadmap

- 🔁 Add support for VM tagging, resource pools

- 📦 Add ISO-based VM creation

- 🔐 Vault/SOPS integration for secure var injection

- 📘 CI workflows for validation and formatting

- 🛠 Post-deploy hooks via Ansible or remote-exec

- 🛰 Static IP/DNS support

- 🧵 Health checks and cloud-init validation

- 🎨 Add diagrams (Mermaid/draw.io) to explain architecture

- 🔄 GitOps integration via ArgoCD or Flux

---

## ✨ Author
**Rahul Nagaraju**
  - Cloud & DevOps Engineer

---

## 📄 License
This project is licensed under the MIT License


```
MIT License

Copyright (c) 2025 Rahul Nagaraju

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```