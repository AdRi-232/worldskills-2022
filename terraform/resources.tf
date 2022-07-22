resource "tls_private_key" "wsc2022_ansible_keys" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "proxmox_lxc" "wsc2022_ansible" {
    target_node  = var.proxmox_node
    hostname     = "wsc2022-ansible"
    pool         = "WSC2022"
    vmid         = 201
    ostemplate   = "local:vztmpl/${var.lxctemplate}"
    password     = var.default_password
    unprivileged = true
    start        = true

    ssh_public_keys = <<EOF
    ${file("~/.ssh/id_rsa.pub")}
    EOF

    features {
        nesting = true
    }

    rootfs {
        storage = var.proxmox_storage
        size    = "4G"
    }

    network {
        name   = "eth0"
        bridge = var.proxmox_bridge.wan 
        ip     = "192.168.1.253/24"
        gw     = "192.168.1.1"
    }

    network {
        name   = "eth1"
        bridge = var.proxmox_bridge.wsc2022kr_internal
        ip     = "192.168.10.10/24"
    }

    network {
        name   = "eth2"
        bridge = var.proxmox_bridge.wsc2022kr_dmz
        ip     = "192.168.20.10/24"
    }

    network {
        name   = "eth3"
        bridge = var.proxmox_bridge.wsc2024fr_internal
        ip     = "172.16.1.10/24"
    }

    network {
        name   = "eth4"
        bridge = var.proxmox_bridge.internet
        ip     = "10.1.1.10/24"
    }

    network {
        name   = "eth5"
        bridge = var.proxmox_bridge.internet
        ip     = "10.2.2.10/24"
    }

    network {
        name   = "eth6"
        bridge = var.proxmox_bridge.internet
        ip     = "10.3.3.10/24"
    }

    provisioner "remote-exec" {

        connection {
            type = "ssh"
            host = var.wsc2022_ansible_ip
            user = "root"
            private_key = "${file("~/.ssh/id_rsa")}"
        }
        inline = [
            "tee -a /root/.ssh/id_rsa << END\n${tls_private_key.wsc2022_ansible_keys.private_key_pem}END",
            "chmod 600 /root/.ssh/id_rsa"
        ]
    }

}

resource "proxmox_vm_qemu" "kr-edge" {
    name        = "kr-edge"
    desc        = "Wordskills 2022 Korea Edge Router"
    vmid        = "221"
    target_node = var.proxmox_node
    pool        = var.proxmox_pool

    clone   = var.citemplate.debian
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_bridge.wsc2022kr_edge
        model  = "virtio"
    }

    network {
        bridge = var.proxmox_bridge.internet
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_storage
        type    = "scsi"
        size    = "2G"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=192.168.100.254/24"
    ipconfig1  = "ip=10.1.1.2/24"
    nameserver = "wsc2022.kr"
    ciuser     = var.default_user
    cipassword = var.default_password

    sshkeys = <<EOF
    ${tls_private_key.wsc2022_ansible_keys.public_key_openssh}
    EOF
}

resource "proxmox_vm_qemu" "fw" {
    name        = "fw"
    desc        = "Wordskills 2022 Korea Firewall"
    vmid        = "222"
    target_node = var.proxmox_node
    pool        = var.proxmox_pool
    
    clone   = var.citemplate.debian
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_bridge.wsc2022kr_internal
        model  = "virtio"
    }

    network {
        bridge = var.proxmox_bridge.wsc2022kr_dmz
        model  = "virtio"
    }

    network {
        bridge = var.proxmox_bridge.wsc2022kr_edge
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_storage
        type    = "scsi"
        size    = "2G"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=192.168.10.254/24"
    ipconfig1  = "ip=192.168.20.254/24"
    ipconfig2  = "ip=192.168.100.1,gw=192.168.100.254"
    nameserver = "wsc2022.kr"
    ciuser     = var.default_user
    cipassword = var.default_password

    
    sshkeys = <<EOF
    ${tls_private_key.wsc2022_ansible_keys.public_key_openssh}
    EOF

}

resource "proxmox_vm_qemu" "intsrv" {
    name        = "intsrv"
    desc        = "Wordskills 2022 Korea Internal Server"
    vmid        = "223"
    target_node = var.proxmox_node
    pool        = var.proxmox_pool

    clone   = var.citemplate.debian
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_bridge.wsc2022kr_internal
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_storage
        type    = "scsi"
        size    = "2G"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=192.168.10.1/24,gw=192.168.10.254"
    nameserver = "wsc2022.kr"
    ciuser     = var.default_user
    cipassword = var.default_password

    sshkeys = <<EOF
    ${tls_private_key.wsc2022_ansible_keys.public_key_openssh}
    EOF

}

resource "proxmox_vm_qemu" "intclnt" {
    name        = "intclnt"
    desc        = "Wordskills 2022 Korea Internal Client"
    vmid        = "224"
    target_node = var.proxmox_node
    pool        = var.proxmox_pool

    clone   = var.citemplate.debian
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_bridge.wsc2022kr_internal
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_storage
        type    = "scsi"
        size    = "2G"
    }

    os_type = "cloud_init"
    ipconfig0 = "ip=dhcp"
    nameserver = "wsc2022.kr"
    ciuser = var.default_user
    cipassword = var.default_password
        
    sshkeys = <<EOF
    ${tls_private_key.wsc2022_ansible_keys.public_key_openssh}
    EOF
    
}

resource "proxmox_vm_qemu" "dmzsrv" {
    name        = "dmzsrv"
    desc        = "Wordskills 2022 Korea DMZ Server"
    vmid        = "225"
    target_node = var.proxmox_node
    pool        = var.proxmox_pool

    clone   = var.citemplate.debian
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_bridge.wsc2022kr_dmz
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_storage
        type    = "scsi"
        size    = "2G"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=192.168.20.1/24,gw=192.168.20.254"
    nameserver = "wsc2022.kr"
    ciuser     = var.default_user
    cipassword = var.default_password
        
    sshkeys = <<EOF
    ${tls_private_key.wsc2022_ansible_keys.public_key_openssh}
    EOF
    
}

resource "proxmox_vm_qemu" "fr-srv" {
    name        = "fr-srv"
    desc        = "Wordskills 2024 France Server"
    vmid        = "241"
    target_node = var.proxmox_node
    pool        = var.proxmox_pool

    clone   = var.citemplate.debian
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_bridge.wsc2024fr_internal
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_storage
        type    = "scsi"
        size    = "2G"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=172.16.1.3/24,gw=172.16.1.254"
    nameserver = "wsc2024.fr"
    ciuser     = var.default_user
    cipassword = var.default_password
        
    sshkeys = <<EOF
    ${tls_private_key.wsc2022_ansible_keys.public_key_openssh}
    EOF
    
}

resource "proxmox_vm_qemu" "inet" {
    name        = "inet"
    desc        = "Internet"
    vmid        = "232"
    target_node = var.proxmox_node
    pool        = var.proxmox_pool

    clone   = var.citemplate.debian
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_bridge.internet
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_storage
        type    = "scsi"
        size    = "2G"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=10.3.3.2/24"
    ciuser     = var.default_user
    cipassword = var.default_password

    sshkeys = <<EOF
    ${tls_private_key.wsc2022_ansible_keys.public_key_openssh}
    EOF
    
}

resource "proxmox_vm_qemu" "isp" {
    name        = "isp"
    desc        = "ISP"
    vmid        = "231"
    target_node = var.proxmox_node
    pool        = var.proxmox_pool

    clone   = var.citemplate.debian
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_bridge.internet
        model  = "virtio"
    }

    network {
        bridge = var.proxmox_bridge.internet
        model  = "virtio"
    }

    network {
        bridge = var.proxmox_bridge.internet
        model  = "virtio"
    }

    network {
        bridge = var.proxmox_bridge.wan
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_storage
        type    = "scsi"
        size    = "2G"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=10.1.1.1/24"
    ipconfig1  = "ip=10.2.2.1/24"
    ipconfig2  = "ip=10.3.3.1/24"
    ipconfig3  = "ip=dhcp"
    ciuser     = var.default_user
    cipassword = var.default_password
    
    sshkeys = <<EOF
    ${tls_private_key.wsc2022_ansible_keys.public_key_openssh}
    EOF
    
}