
variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type = string
    sensitive = true
}

variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}

variable "proxmox_node" {
    type = string
}

variable "proxmox_vm_pool" {
    type = string
}

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

variable "proxmox_vm_storage" {
    type = string
}

variable "vm_user" {
    type = string
}

variable "vm_password" {
    type = string
    sensitive = true
}