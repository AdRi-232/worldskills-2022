data "cloudinit_config" "cloudbase_init_config" {
    for_each = var.windows_server_vms

    gzip          = false
    base64_encode = false
    boundary = "===============1598784645116016685=="

    part {
        content_type = "text/cloud-config"
        filename = "cloud-config"
        content = "${templatefile(
                               "${path.module}/files/cloud-config.tftpl",
                                 {
                                    hostname = each.key
                                    sshkeys = tls_private_key.wsc2022_ansible_keys.public_key_openssh
                                 }
                     )
                  }"
    }

    dynamic "part" {
        for_each = each.value.network
        iterator = network
        
        content {
            content_type = "text/x-cfninitdata"
            filename = "cfn-userdata"
            content = "${templatefile("${path.module}/files/network-config.tftpl", {
                id = sum([4, network.key])
                ip = network.value.ip
                gw = network.value.gw
            })}"
        }
    }
}

resource "local_file" "cloudbase_init_config_file" {
    for_each = data.cloudinit_config.cloudbase_init_config

    content = each.value.rendered
    filename = "${path.module}/files/cloudbase-init-${each.key}.cfg"

    connection {
        type = "ssh"
        user = "root"
        host = var.proxmox_node_ip
        private_key = "${file("~/.ssh/id_rsa")}"
    }

    provisioner "file" {
        source = self.filename
        destination = "/var/lib/vz/snippets/cloudbase-init-${each.key}.yml"
    }
}

resource "proxmox_vm_qemu" "windows_server_vm" {
    depends_on = [local_file.cloudbase_init_config_file]

    for_each = var.windows_server_vms

    name = each.key
    desc = each.value.description
    vmid = each.value.id
    target_node = var.proxmox_node
    pool = var.proxmox_pool

    clone = var.citemplate.winsrv19
    cores = 2
    sockets = 1
    cpu = "host"
    memory = 2048
    bios = "ovmf"

    dynamic "network" {
        for_each = each.value.network

        content {
            bridge = lookup(var.proxmox_bridge, network.value.interface, "vmbr0")
            model  = "virtio"
        }
    }

    disk {
        storage = var.proxmox_storage
        type    = "virtio"
        size    = "32G"
    }

    os_type  = "cloud_init"
    cicustom = "user=local:snippets/cloudbase-init-${each.key}.yml"

}