### Authentication details
export TF_VAR_tenancy_ocid=ocid1.tenancy.oc1..aaaaaaaazw4rl2qtuoyxnug324qhehmj27dk4jn25seydsbzjld5xmeimdja
export TF_VAR_user_ocid=ocid1.user.oc1..aaaaaaaahg4kmcnlrg46cry7dd3ijatwdpcpz4pamuftmw6istsch5eoinvq
export TF_VAR_fingerprint=f6:31:a1:ec:65:36:09:f0:c5:02:26:e0:c2:13:fa:6a
export TF_VAR_private_key_path=/home/junicode/.oci/oci_api_key_public.pem

### Region
export TF_VAR_region=us-ashburn-1

### Compartment
export TF_VAR_compartment_ocid=ocid1.compartment.oc1..aaaaaaaaflfbrxxpetnkjsj7bpb4ujhdqrlqlctchmdknmy5f3jhbcsagjqq

### Subnet
export TF_VAR_subnet_ocid=ocid1.subnet.oc1.iad.aaaaaaaayyvqpg4mwlhgbjva6b3rsec5pke3m2slt24oqgfibbgffna2pfqa

### Public/private keys used on the compute instance
export TF_VAR_ssh_public_key=$(cat /home/junicode/.ssh/id_rsa.pub)
export TF_VAR_ssh_private_key=$(cat /home/junicode/.ssh/id_rsa)
