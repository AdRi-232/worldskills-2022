resource "proxmox_vm_qemu" "kr-edge" {
    name        = "kr-edge"
    desc        = "Wordskills 2022 Korea Edge Router"
    vmid        = "221"
    target_node = var.proxmox_node
    pool        = var.proxmox_vm_pool

    agent = 1

    clone   = "debian_cloud"
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_wsc2022kr_edge_bridge
        model  = "virtio"
    }

    network {
        bridge = var.proxmox_internet_bridge
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_vm_storage
        type    = "scsi"
        size    = "2GB"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=10.1.1.2/30"
    ipconfig1  = "ip=210.103.5.1/26"
    nameserver = "wsc2022.kr"
    ciuser     = var.vm_user
    cipassword = var.vm_password
}

resource "proxmox_vm_qemu" "fw" {
    name        = "fw"
    desc        = "Wordskills 2022 Korea Firewall"
    vmid        = "222"
    target_node = var.proxmox_node
    pool        = var.proxmox_vm_pool

    agent = 1

    clone   = "debian_cloud"
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_wsc2022kr_internal_bridge
        model  = "virtio"
    }

    network {
        bridge = var.proxmox_wsc2022kr_dmz_bridge
        model  = "virtio"
    }

    network {
        bridge = var.proxmox_wsc2022kr_edge_bridge
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_vm_storage
        type    = "scsi"
        size    = "2GB"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=192.168.1.254/24"
    ipconfig1  = "ip=192.168.2.254/24"
    ipconfig2  = "ip=10.1.1.1/30,gw=10.1.1.2"
    nameserver = "wsc2022.kr"
    ciuser     = var.vm_user
    cipassword = var.vm_password
}

resource "proxmox_vm_qemu" "intsrv" {
    name        = "intsrv"
    desc        = "Wordskills 2022 Korea Internal Server"
    vmid        = "223"
    target_node = var.proxmox_node
    pool        = var.proxmox_vm_pool

    agent = 1

    clone   = "debian_cloud"
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_wsc2022kr_internal_bridge
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_vm_storage
        type    = "scsi"
        size    = "2GB"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=192.168.1.1/24,gw=192.168.1.254"
    nameserver = "wsc2022.kr"
    ciuser     = var.vm_user
    cipassword = var.vm_password
}

resource "proxmox_vm_qemu" "intclnt" {
    name        = "intclnt"
    desc        = "Wordskills 2022 Korea Internal Client"
    vmid        = "224"
    target_node = var.proxmox_node
    pool        = var.proxmox_vm_pool

    agent = 1

    clone   = "debian_cloud"
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_wsc2022kr_internal_bridge
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_vm_storage
        type    = "scsi"
        size    = "2GB"
    }

    os_type = "cloud_init"
    ipconfig0 = "ip=dhcp"
    nameserver = "wsc2022.kr"
    ciuser = var.vm_user
    cipassword = var.vm_password
}

resource "proxmox_vm_qemu" "dmzsrv" {
    name        = "dmzsrv"
    desc        = "Wordskills 2022 Korea DMZ Server"
    vmid        = "225"
    target_node = var.proxmox_node
    pool        = var.proxmox_vm_pool

    agent = 1

    clone   = "debian_cloud"
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_wsc2022kr_dmz_bridge
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_vm_storage
        type    = "scsi"
        size    = "2GB"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=192.168.2.1/24,gw=192.168.2.254"
    nameserver = "wsc2022.kr"
    ciuser     = var.vm_user
    cipassword = var.vm_password
}

resource "proxmox_vm_qemu" "fr-srv" {
    name        = "fr-srv"
    desc        = "Wordskills 2024 France Server"
    vmid        = "241"
    target_node = var.proxmox_node
    pool        = var.proxmox_vm_pool

    agent = 1

    clone   = "debian_cloud"
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_wsc2024fr_internal_bridge
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_vm_storage
        type    = "scsi"
        size    = "2GB"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=172.16.1.3/24,gw=172.16.1.254"
    nameserver = "wsc2024.fr"
    ciuser     = var.vm_user
    cipassword = var.vm_password
}

resource "proxmox_vm_qemu" "inet" {
    name        = "inet"
    desc        = "Internet"
    vmid        = "232"
    target_node = var.proxmox_node
    pool        = var.proxmox_vm_pool

    agent = 1

    clone   = "debian_cloud"
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_internet_bridge
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_vm_storage
        type    = "scsi"
        size    = "2GB"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=210.103.5.129/25"
    ciuser     = var.vm_user
    cipassword = var.vm_password
}

resource "proxmox_vm_qemu" "isp" {
    name        = "isp"
    desc        = "ISP"
    vmid        = "231"
    target_node = var.proxmox_node
    pool        = var.proxmox_vm_pool

    agent = 1

    clone   = "debian_cloud"
    cores   = 2
    sockets = 1
    cpu     = "host"
    memory  = 1024

    network {
        bridge = var.proxmox_internet_bridge
        model  = "virtio"
    }

    network {
        bridge = var.proxmox_internet_bridge
        model  = "virtio"
    }

    network {
        bridge = var.proxmox_internet_bridge
        model  = "virtio"
    }

    disk {
        storage = var.proxmox_vm_storage
        type    = "scsi"
        size    = "2GB"
    }

    os_type    = "cloud_init"
    ipconfig0  = "ip=210.103.5.254/25"
    ipconfig1  = "ip=210.103.5.62/25"
    ipconfig2  = "ip=210.103.5.126/25"
    ciuser     = var.vm_user
    cipassword = var.vm_password
}