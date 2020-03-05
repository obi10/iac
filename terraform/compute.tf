
data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

variable "OCI_AD" {
	description = "Available AD's in OCI"
	type	= "map"
	default  = {
		AD1 = "PqLC:US-ASHBURN-AD-1",
		AD2 = "PqLC:US-ASHBURN-AD-2",
		AD3 = "PqLC:US-ASHBURN-AD-3"
	}
}

resource "oci_core_instance" "instance1" {
  availability_domain = "${var.OCI_AD["AD3"]}" 
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "wrksp01"
  image               = "${var.InstanceImageOCID[var.region]}"
  shape               = "VM.Standard2.1"
  subnet_id           = "${oci_core_subnet.subnet3.id}"
  hostname_label      = "workshop1"	        
  metadata {ssh_authorized_keys = "${var.ssh_public_key}"}

  # Copia arquivos para dentro do servidor que acaba de ser criado
  connection {
      type        = "ssh"
      host        = "${self.public_ip}"
      user        = "opc"
      private_key = "${file(var.ssh_private_key)}"
    }
  provisioner "file" {
      content="../chave_cloud_01"
      destination="/home/opc/chave_cloud_01"
    }

  provisioner "local-exec" {
    command = "sleep 5"
  }

# Instalacao Apache, e execuca de instrucoes pos-criacao
  provisioner "remote-exec" {
      depend_on = ["oci_core_instance.instance1"]
      inline = ["touch /tmp/campelo_file.txt","sudo yum install httpd -y",
      "sudo echo 'This is Oracle webserver 1 running on Oracle Cloud Infrastructure, created by Terraform !!' > /var/www/html/index.html",
      "sudo apachectl start","sudo systemctl enable httpd",
      "sudo apachectl configtest","sudo firewall-cmd --permanent --zone=public --add-service=http",
      "sudo firewall-cmd --reload"]
  }

}

# Conecta os discos criados ...
/*
resource "oci_core_volume_attachment" "TFBlock0Attach" {
  attachment_type = "iscsi"
  compartment_id  = "${var.compartment_ocid}"
  instance_id     = "${oci_core_instance.instance1.id}"
  volume_id       = "${oci_core_volume.TFBlock0.id}"

  connection {
    type        = "ssh"
    host        = "${oci_core_instance.instance1.public_ip}"
    user        = "opc"
#    private_key = "${var.ssh_private_key}"
    private_key = "${file("../../chave_cloud_01")}"
  }

  provisioner "remote-exec" {
      inline = [
        "sudo iscsiadm -m node -o new -T ${self.iqn} -p ${self.ipv4}:${self.port}",
        "sudo iscsiadm -m node -o update -T ${self.iqn} -n node.startup -v automatic",
        "sudo iscsiadm -m node -T ${self.iqn} -p ${self.ipv4}:${self.port} -l",
      ]
  }

  provisioner "remote-exec" {
      inline = [
        "set -x",
        "export DEVICE_ID=ip-${self.ipv4}:${self.port}-iscsi-${self.iqn}-lun-1",
        "export HAS_PARTITION=$(sudo partprobe -d -s /dev/disk/by-path/$${DEVICE_ID} | wc -l)",
        "if [ $HAS_PARTITION -eq 0 ] ; then",
        "  (echo g; echo n; echo ''; echo ''; echo ''; echo w) | sudo fdisk /dev/disk/by-path/$${DEVICE_ID}",
        "  while [[ ! -e /dev/disk/by-path/$${DEVICE_ID}-part1 ]] ; do sleep 1; done",
        "  sudo mkfs.xfs /dev/disk/by-path/$${DEVICE_ID}-part1",
        "fi",
      ]
  }

  provisioner "remote-exec" {
      inline = [
        "set -x",
        "export DEVICE_ID=ip-${self.ipv4}:${self.port}-iscsi-${self.iqn}-lun-1",
        "sudo mkdir -p /backup",
        "export UUID=$(sudo /usr/sbin/blkid -s UUID -o value /dev/disk/by-path/$${DEVICE_ID}-part1)",
        "echo 'UUID='$${UUID}' /backup xfs defaults,_netdev,nofail 0 2' | sudo tee -a /etc/fstab",
        "sudo mount -a",
      ]
  }
}
*/
output "Instancia_01" {
  value = ["${oci_core_instance.instance1.*.public_ip}"]
  value = ["${oci_core_instance.instance1.*.private_ip}"]
}

resource "oci_core_instance" "instance2" {
  availability_domain = "${var.OCI_AD["AD2"]}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "wrksp02"
  image               = "${var.InstanceImageOCID[var.region]}"
  shape               = "VM.Standard2.1"
  subnet_id           = "${oci_core_subnet.subnet2.id}"
  hostname_label      = "workshop2"	        
  metadata {ssh_authorized_keys = "${var.ssh_public_key}"}

provisioner "local-exec" {
    command = "sleep 5"
  }
#Copia arquivo de chave ...
  connection {
    type        = "ssh"
    host        = "${oci_core_instance.instance2.public_ip}"
    user        = "opc"
    private_key = "${file("../chave_cloud_01")}"
  }

  
  provisioner "file" {
      content="../../chave_cloud_01"
      destination="/home/opc/chave_cloud_01"
    }
 # Instala Apache
  provisioner "remote-exec" {
    depend_on = ["oci_core_instance.instance2"]
      inline = ["touch /tmp/campelo_file.txt","sudo yum install httpd -y",
      "sudo echo 'This is Oracle webserver 1 running on Oracle Cloud Infrastructure, created by Terraform !!' > /var/www/html/index.html",
      "sudo apachectl start","sudo systemctl enable httpd",
      "sudo apachectl configtest","sudo firewall-cmd --permanent --zone=public --add-service=http",
      "sudo firewall-cmd --reload"]
  }
}

output "Instancia_02" {
  value = ["${oci_core_instance.instance2.*.public_ip}"]
  value = ["${oci_core_instance.instance2.*.private_ip}"]
}


/*---------------------------------------------

resource "null_resource" "before" {
}
resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_volume_attachment" "TFBlock1Attach" {
  attachment_type = "iscsi"
  compartment_id  = "${var.compartment_ocid}"
  instance_id     = "${oci_core_instance.instance2.id}"
  volume_id       = "${oci_core_volume.TFBlock1.id}"

provisioner "remote-exec" {
    inline = [
      "sudo iscsiadm -m node -o new -T ${self.iqn} -p ${self.ipv4}:${self.port}",
      "sudo iscsiadm -m node -o update -T ${self.iqn} -n node.startup -v automatic",
      "sudo iscsiadm -m node -T ${self.iqn} -p ${self.ipv4}:${self.port} -l",
    ]
}

provisioner "remote-exec" {
    inline = [
      "set -x",
      "export DEVICE_ID=ip-${self.ipv4}:${self.port}-iscsi-${self.iqn}-lun-1",
      "export HAS_PARTITION=$(sudo partprobe -d -s /dev/disk/by-path/$${DEVICE_ID} | wc -l)",
      "if [ $HAS_PARTITION -eq 0 ] ; then",
      "  (echo g; echo n; echo ''; echo ''; echo ''; echo w) | sudo fdisk /dev/disk/by-path/$${DEVICE_ID}",
      "  while [[ ! -e /dev/disk/by-path/$${DEVICE_ID}-part1 ]] ; do sleep 1; done",
      "  sudo mkfs.xfs /dev/disk/by-path/$${DEVICE_ID}-part1",
      "fi",
    ]
  }

provisioner "remote-exec" {
    inline = [
      "set -x",
      "export DEVICE_ID=ip-${self.ipv4}:${self.port}-iscsi-${self.iqn}-lun-1",
      "sudo mkdir -p /backup",
      "export UUID=$(sudo /usr/sbin/blkid -s UUID -o value /dev/disk/by-path/$${DEVICE_ID}-part1)",
      "echo 'UUID='$${UUID}' /backup xfs defaults,_netdev,nofail 0 2' | sudo tee -a /etc/fstab",
      "sudo mount -a",
    ]
  }
}
--------------------------*/

