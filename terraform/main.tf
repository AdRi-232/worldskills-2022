terraform {
    required_version = ">=1.2.0"

    required_providers {
        proxmox = {
            source  = "telmate/proxmox"
            version = "2.9.10"
        }
        tls = {
            source  = "hashicorp/tls"
            version = "3.4.0"
        }
        cloudinit = {
            source  = "hashicorp/cloudinit"
            version = "2.2.0"
        }
        local = {
            source  = "hashicorp/local"
            version = "2.2.3"
        }
    }
}

# Documentation: https://registry.terraform.io/providers/Telmate/proxmox/latest/docs
provider "proxmox" {
    pm_api_url          = "https://${var.proxmox_node_ip}:8006/api2/json"
    pm_api_token_id     = var.proxmox_api_token_id
    pm_api_token_secret = var.proxmox_api_token_secret

    pm_tls_insecure = true

    pm_log_enable = true
    pm_log_file = "terraform-plugin-proxmox.log"
    pm_debug = true
    pm_log_levels = {
        _default = "debug"
        _capturelog = ""
    }
}

provider "tls" {}

provider "cloudinit" {}

provider "local" {}