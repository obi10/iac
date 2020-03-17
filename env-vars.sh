### Authentication details
### export TF_VAR_tenancy_ocid=ocid1.tenancy.oc1..aaaaaaaatbtjah3ht6up5waoi52wiyde5gdxbdvofjzok4ruo6k4tvlnl4ia
### export TF_VAR_user_ocid=ocid1.user.oc1..aaaaaaaadzczsphbzlvsqymx6kbllrfybp6wpkx6hubfbxwyfjabg7ufm5zq
export TF_VAR_fingerprint=52:fe:22:47:f0:a9:9e:15:2d:ca:36:b6:da:ad:8f:fd
export TF_VAR_private_key_path=./api_keys/private.pem
export TF_VAR_private_key_password=private

### Region
export TF_VAR_region=us-ashburn-1

### Compartment
export TF_VAR_compartment_ocid=ocid1.compartment.oc1..aaaaaaaalxo7zindcffskunoclqhfxnvmblgpjs4r7s7li7cvx2l3p2mfniq

### Public/private keys used on the compute instance
export TF_VAR_host_user_name=opc
export TF_VAR_ssh_public_key=$(cat ./ssh/test_key.pub)
export TF_VAR_ssh_private_key=$(cat ./ssh/test_key)
