### Authentication details
export TF_VAR_tenancy_ocid=ocid1.tenancy.oc1..aaaaaaaal7ryxbp2hgljainhn3xe67m3jec66exupxajvsjcd36y5sfot7kq
### no se necesita TF_VAR_user_ocid, TF_VAR_fingerprint y TF_VAR_private_key_path (si se usa Cloud Shell)
### export TF_VAR_user_ocid=ocid1.user.oc1..aaaaaaaas2ol4ddk6yzmhabecxetak6cnqejwc7whhb7r567iiqxe7nvmpza
### export TF_VAR_fingerprint=52:fe:22:47:f0:a9:9e:15:2d:ca:36:b6:da:ad:8f:fd
### export TF_VAR_private_key_path=./user_keys/private.pem
### export TF_VAR_private_key_password=private

### Region
export TF_VAR_region=us-ashburn-1

### Compartment
export TF_VAR_compartment_ocid=ocid1.compartment.oc1..aaaaaaaaf3iat7bckqiavo53ltmcbxqiuu5kfbu5ijbsgretwgxo6rczawpa

### Public/private keys used on the compute instance
export TF_VAR_host_user_name=opc
export TF_VAR_ssh_public_key=$(cat ./ssh/test_key.pub)
export TF_VAR_ssh_private_key=$(cat ./ssh/test_key)
