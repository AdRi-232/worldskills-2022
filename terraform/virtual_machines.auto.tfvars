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