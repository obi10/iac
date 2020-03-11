// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.


variable "host_user_name" {}
variable "ssh_private_key" {}


resource "null_resource" "remote-exec" {
    provisioner "file" {
        connection {
            agent = false
            timeout = "10m"
            host = "${data.oci_core_vnic.instance_vnic.public_ip_address}"
            user = "${var.host_user_name}"
            private_key = "${var.ssh_private_key}"
        }
        source = "./scripts/apache.sh"
        destination = "~/apache.sh"
    }    
    
    provisioner "remote-exec" {
        connection {
            agent = false
            timeout = "10m"
            host = "${data.oci_core_vnic.instance_vnic.public_ip_address}"
            user = "${var.host_user_name}"
            private_key = "${var.ssh_private_key}"
        }
        inline = [
            "chmod +x ~/apache.sh",
            "sudo ~/apache.sh",
        ]
    }
}




