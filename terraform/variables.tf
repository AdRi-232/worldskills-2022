# Connection details for the API
variable "proxmox_api_token_id" {
    type = string
    sensitive = true
}

variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}

# Proxmox host information
variable "proxmox_node_ip" {
    type = string
}

variable "proxmox_node" {
    type = string
}

variable "proxmox_pool" {
    type = string
}

variable "proxmox_storage" {
    type = string
    default = "local-lvm"
}

# Virtual bridge information
variable "proxmox_bridge" {
    type = object({
        wan                = string
        wsc2022kr_internal = string
        wsc2022kr_dmz      = string
        wsc2022kr_edge     = string
        wsc2024fr_internal = string
        internet           = string
    })
}

# VM cloud-init related settings
variable "citemplate" {
    type = object({
        debian   = string
        winsrv19 = string
        win10    = string
    })
}

variable "default_user" {
    type = string
    default = "user"
}

variable "default_password" {
    type = string
    sensitive = true
    default = "Skill39"
}

variable "lxctemplate" {
    type = string
    default = "debian-11-standard_11.3-1_amd64.tar.zst"
}

variable "wsc2022_ansible_ip" {
    type = string
}