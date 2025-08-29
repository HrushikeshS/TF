#this block has higher priority than terraform.tfvars file

root_block_config = {
  root_vol_size = 80
  root_vol_type = "gp3"
}

#instance method  highest priority
# terraform plan -var='root_block_config={root_vol_size=90,root_vol_type="gp3"}'