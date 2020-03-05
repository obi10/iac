
resource "oci_core_virtual_network" "vcn1" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "vcn1"
  dns_label      = "vcn1"
}

resource "oci_core_subnet" "subnet1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "10.1.20.0/24"
  display_name        = "subnet1"
  dns_label           = "subnet1"
  security_list_ids   = ["${oci_core_security_list.securitylist1.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn1.id}"
  route_table_id      = "${oci_core_route_table.routetable1.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn1.default_dhcp_options_id}"
}


resource "oci_core_subnet" "subnet2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "10.1.21.0/24"
  display_name        = "subnet2"
  dns_label           = "subnet2"
  security_list_ids   = ["${oci_core_security_list.securitylist1.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn1.id}"
  route_table_id      = "${oci_core_route_table.routetable1.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn1.default_dhcp_options_id}"
}


resource "oci_core_subnet" "subnet3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block          = "10.1.19.0/24"
  display_name        = "subnet3"
  dns_label           = "subnet3"
  security_list_ids   = ["${oci_core_security_list.securitylist1.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn1.id}"
  route_table_id      = "${oci_core_route_table.routetable1.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn1.default_dhcp_options_id}"
}

resource "oci_core_internet_gateway" "internetgateway1" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "internetgateway1"
  vcn_id         = "${oci_core_virtual_network.vcn1.id}"
}

resource "oci_core_route_table" "routetable1" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.vcn1.id}"
  display_name   = "routetable1"

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.internetgateway1.id}"
  }
}

resource "oci_core_security_list" "securitylist1" {
  display_name   = "public"
  compartment_id = "${oci_core_virtual_network.vcn1.compartment_id}"
  vcn_id         = "${oci_core_virtual_network.vcn1.id}"

  egress_security_rules = [{
    protocol    = "all"
    destination = "0.0.0.0/0"
  }]

  ingress_security_rules = [
        {tcp_options {"max" = 22 "min" = 22}
        protocol = "6" source   = "0.0.0.0/0"},

        {icmp_options {"type" = 0}
        protocol = 1 source   = "0.0.0.0/0"},

        {icmp_options {"type" = 3 "code" = 4}
        protocol = 1 source   = "0.0.0.0/0" },

        {icmp_options {"type" = 8}
        protocol = 1 source   = "0.0.0.0/0"},

        {tcp_options {"max" = 80 "min" = 80}
        protocol = "6" source   = "0.0.0.0/0"},
]}

