windows_server_vms = {

    "fr-edge" = {
        description = "Worldskills 2024 France Edge Router"
        id          = "241"

        network = [
            {
                interface = "internet"
                ip        = "10.2.2.2"
                gw        = "10.2.2.1"
            },
            {
                interface = "wsc2024fr_internal"
                ip        = "172.16.1.254"
                gw        = ""
            }
        ]
    }

    "fr-dc" = {
        description = "Worldskills 2024 France DC Server"
        id          = "242"

        network = [
            {
                interface = "wsc2024fr_internal"
                ip        = "172.16.1.1"
                gw        = "172.16.1.254"
            }
        ]
    }

    "fr-file" = {
        description = "Worldskills 2024 France File Server"
        id          = "243"

        network = [
            {
                interface = "wsc2024fr_internal"
                ip        = "172.16.1.2"
                gw        = "172.16.1.254"
            }
        ]
    }
}

debian_vms = {

    "kr-edge" = {
        description = "Worldskills 2022 Korea Edge Router"
        id          = "221"

        network = [
            {
                interface = "wsc2022kr_edge"
                ip        = "192.168.100.254"
                gw        = ""
            },
            {
                interface = "internet"
                ip        = "10.1.1.2"
                gw        = "10.1.1.1"
            }
        ]
    }

    "fw" = {
        description = "Worldskills 2022 Korea Firewall"
        id          = "222"

        network = [
            {
                interface = "wsc2022kr_internal"
                ip        = "192.168.10.254"
                gw        = ""
            },
            {
                interface = "wsc2022kr_dmz"
                ip        = "192.168.20.254"
                gw        = ""
            },
            {
                interface = "wsc2022kr_edge"
                ip        = "192.168.100.1"
                gw        = "192.168.100.254"
            }
        ]
    }

    "intsrv" = {
        description = "Worldskills 2022 Korea Internal Server"
        id          = "223"

        network = [
            {
                interface = "wsc2022kr_internal"
                ip        = "192.168.10.1"
                gw        = "192.168.10.254"
            }
        ]
    }

    "intclnt" = {
        description = "Worldskills 2022 Korea Internal Client"
        id          = "224"

        network = [
            {
                interface = "wsc2022kr_internal"
                ip        = "192.168.10.100"
                gw        = "192.168.10.254"
            }
        ]
    }

    "dmzsrv" = {
        description = "Worldskills 2022 Korea DMZ Server"
        id          = "225"

        network = [
            {
                interface = "wsc2022kr_dmz"
                ip        = "192.168.20.1"
                gw        = "192.168.20.254"
            }
        ]
    }

    "fr-srv" = {
        description = "Worldskills 2024 France Internal Server"
        id          = "244"

        network = [
            {
                interface = "wsc2024fr_internal"
                ip        = "172.16.1.3"
                gw        = "172.16.1.254"
            }
        ]
    }

    "inet" = {
        description = "Internet Server"
        id          = "232"

        network = [
            {
                interface = "internet"
                ip        = "10.3.3.2"
                gw        = "10.3.3.1"
            }
        ]
    }

    "isp" = {
        description = "IPS Routing Server"
        id          = "231"

        network = [
            {
                interface = "internet"
                ip        = "10.1.1.1"
                gw        = ""
            },
            {
                interface = "internet"
                ip        = "10.2.2.1"
                gw        = ""
            },
            {
                interface = "internet"
                ip        = "10.3.3.1"
                gw        = ""
            },
            {
                interface = "internet"
                ip        = "192.168.1.252"
                gw        = ""
            }
        ]
    }
}