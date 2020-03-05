
variable "tenancy_ocid" {}
variable "user_ocid" {} 
variable "compartment_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {} 
variable "region" {}
variable "ssh_private_key" {}
variable "ssh_public_key" {default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbM/d+Y84sxxLHynDMr4dlgFMmcshdGY2OzCHogXjK14v23JUioVzX2577+pSmfa8OCmENatOoFvGYGjhNmUJ7NTk692KE+kWpqOkop+9EM2EMKEH9dFSpJ4iMRD+dFgmVqsyrKLxqKJgsdE8lO8aMmMmE/eCundvlcBr88XLkIzW7vcosxp3KdeSuWKhj1rykAxItQqb+nQcAlSqB+k01nMO6VKb8gIyXQoB1OkgoHtq7CoeCuWnELMuou2SOIXkIqHDlGSDsdQFY+KblnsXsJll1dG++t+plctohsyaBuZqjuKpS2NtbL8yY+uu+AYB3MND6ETJfipXcT0kDmzpZ raphaelcampelo@dhcp-10-159-36-107.vpn.oracle.com"}
variable "InstanceImageOCID" {
  type = "map"
  default = {
          // Oracle-provided image "Oracle-Linux-7.4-2018.01.20-0"
          // See https://docs.us-phoenix-1.oraclecloud.com/Content/Resources/Assets/OracleProvidedImageOCIDs.pdf
                      us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaav4gjc4l232wx5g5drypbuiu375lemgdgnc7zg2wrdfmmtbtyrc5q"
                      us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaautkmgjebjmwym5i6lvlpqfzlzagvg5szedggdrbp6rcjcso3e4kq"
                      eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa7d3fsb6272srnftyi4dphdgfjf6gurxqhmv6ileds7ba3m2gltxq"    
          }
}


provider "oci" {
        version = ">=3.19.0"
	region = "us-asburn-1"
        tenancy_ocid     = "${var.tenancy_ocid}"
        user_ocid        = "${var.user_ocid}"
        fingerprint      = "${var.fingerprint}"
        private_key_path = "${var.private_key_path}"
        region           = "${var.region}"
}





