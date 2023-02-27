# resource "proxmox_vm_qemu" "debian_vm" {
#     for_each = var.debian_vms
#     name        = each.key
#     desc        = each.value.description
#     vmid        = each.value.id
#     target_node = var.proxmox_node
#     pool        = var.proxmox_pool

#     clone   = var.citemplate.debian
#     cores   = 2
#     sockets = 1
#     cpu     = "host"
#     memory  = 1024

#     dynamic "network" {
#         for_each = each.value.network

#         content {
#             bridge = lookup(var.proxmox_bridge, network.value.interface, "vmbr0")
#             model  = "virtio"
#         }
#     }

#     disk {
#         storage = var.proxmox_storage
#         type    = "scsi"
#         size    = "2G"
#     }

#     os_type    = "cloud_init"

#     [for n in each.value.network]
#     ipconfig${n} = "ip=${coalesce([n.ip, "dhcp"])}"
#     [endfor]

#     ciuser     = var.default_user
#     cipassword = var.default_password

#     sshkeys = <<EOF
#     ${tls_private_key.wsc2022_ansible_keys.public_key_openssh}
#     EOF
# }