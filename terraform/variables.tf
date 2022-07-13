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

variable "proxmox_vm_pool" {
    type = string
}

variable "proxmox_vm_storage" {
    type = string
}


# Virtual bridge information
variable "proxmox_wsc2022kr_internal_bridge" {
    type = string
}

variable "proxmox_wsc2022kr_dmz_bridge" {
    type = string
}

variable "proxmox_wsc2022kr_edge_bridge" {
    type = string
}

variable "proxmox_wsc2024fr_internal_bridge" {
    type = string
}

variable "proxmox_internet_bridge" {
    type = string
}


# VM cloud-init related settings
variable "citemplate_debian" {
    type = string
}

variable "citemplate_winsrv19" {
    type = string
}

variable "citemplate_win10" {
    type = string
}

variable "ciuser" {
    type = string
}

variable "cipassword" {
    type = string
    sensitive = true
}