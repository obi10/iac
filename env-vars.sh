### Authentication details
export TF_VAR_tenancy_ocid=ocid1.tenancy.oc1..aaaaaaaal7ryxbp2hgljainhn3xe67m3jec66exupxajvsjcd36y5sfot7kq
### no se necesita TF_VAR_user_ocid, TF_VAR_fingerprint y TF_VAR_private_key_path

### Region
export TF_VAR_region=us-ashburn-1

### Compartment
export TF_VAR_compartment_ocid=ocid1.compartment.oc1..aaaaaaaaf3iat7bckqiavo53ltmcbxqiuu5kfbu5ijbsgretwgxo6rczawpa

### Public/private keys used on the compute instance
export TF_VAR_host_user_name=opc
export TF_VAR_ssh_public_key=$(cat ./ssh/test_key.pub)
export TF_VAR_ssh_private_key=$(cat ./ssh/test_key)
