data "cloudinit_config" "cloudbase_init_fr_edge" {
    gzip          = false
    base64_encode = false
    boundary = "===============1598784645116016685=="

    part {
        content_type = "text/cloud-config"
        filename = "cloud-config"
        content = "${templatefile(
                               "${path.module}/files/cloud-config.tftpl",
                                 {
                                    hostname = "fr-edge"
                                 }
                     )
                  }"
    }

    part {
        content_type = "text/x-cfninitdata"
        filename = "cfn-userdata"
        content = "${templatefile(
                               "${path.module}/files/network-config.tftpl",
                                 {
                                    network = [
                                        {
                                            index = "4"
                                            ip = "172.16.1.254"
                                            gw = ""
                                        },
                                        {
                                            index = "5"
                                            ip = "10.2.2.2"
                                            gw = "10.2.2.1"
                                        }
                                    ]
                                 }
                     )
                  }"
    }
}

resource "local_file" "cloudbase_init_fr_edge_file" {
    content = data.cloudinit_config.cloudbase_init_fr_edge.rendered
    filename = "${path.module}/files/cloudbase_init_fr_edge.cfg"

    connection {
        type = "ssh"
        user = "root"
        host = var.proxmox_node_ip
        private_key = "${file("~/.ssh/id_rsa")}"
    }

    provisioner "file" {
        source = self.filename
        destination = "/var/lib/vz/snippets/cloudbase_init_fr_edge.yml"
    }
}