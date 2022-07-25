resource "proxmox_vm_qemu" "fr-edge" {

    depends_on = [
    local_file.cloudbase_init_fr_edge_file
    ]

    name = "fr-edge"
    desc = "Worldskills 2024 France Edge Router"
    vmid = "241"
    target_node = var.proxmox_node
    pool = var.proxmox_pool

    clone = var.citemplate.winsrv19
    cores = 2
    sockets = 1
    cpu = "host"
    memory = 2048
    bios = "ovmf"
    

    network {
        bridge = var.proxmox_bridge.wsc2024fr_internal
        model  = "virtio"
    }

    network {
        bridge = var.proxmox_bridge.internet
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_storage
        type    = "virtio"
        size    = "32G"
    }

    os_type  = "cloud_init"
    cicustom = "user=local:snippets/cloudbase_init_fr_edge.yml" 

}

# resource "proxmox_vm_qemu" "fr-dc" {
#     name = "fr-dc"
#     desc = "Worldskills 2024 France DC Server"
#     vmid = "242"
#     target_node = var.proxmox_node
#     pool = var.proxmox_pool

#     clone = var.citemplate.winsrv19
#     cores = 2
#     sockets = 1
#     cpu = "host"
#     memory = 2048
#     bios = "ovmf"
    

#     network {
#         bridge = var.proxmox_bridge.wsc2024fr_internal
#         model  = "virtio"
#     }

#     disk {
#         storage = var.proxmox_storage
#         type    = "virtio"
#         size    = "32G"
#     }

#     os_type    = "cloud_init"
#     ipconfig0  = "ip=172.16.1.1/24,gw=172.16.1.254"
#     searchdomain = "wsc2024.fr"
#     ciuser     = var.default_user
#     cipassword = var.default_password

#     sshkeys = <<EOF
#     ${tls_private_key.wsc2022_ansible_keys.public_key_openssh}
#     EOF

# }

# resource "proxmox_vm_qemu" "fr-file" {
#     name = "fr-file"
#     desc = "Worldskills 2024 France File Server"
#     vmid = "243"
#     target_node = var.proxmox_node
#     pool = var.proxmox_pool

#     clone = var.citemplate.winsrv19
#     cores = 2
#     sockets = 1
#     cpu = "host"
#     memory = 2048
#     bios = "ovmf"
    

#     network {
#         bridge = var.proxmox_bridge.wsc2024fr_internal
#         model  = "virtio"
#     }

#     disk {
#         storage = var.proxmox_storage
#         type    = "virtio"
#         size    = "32G"
#     }

#     os_type    = "cloud_init"
#     ipconfig0  = "ip=172.16.1.2/24,gw=172.16.1.254"
#     searchdomain = "wsc2024.fr"
#     ciuser     = var.default_user
#     cipassword = var.default_password

#     sshkeys = <<EOF
#     ${tls_private_key.wsc2022_ansible_keys.public_key_openssh}
#     EOF

# }