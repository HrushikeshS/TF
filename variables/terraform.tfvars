aws_instance_type = "t3.micro"

root_block_config = {
  root_vol_size = 60
  root_vol_type = "gp3"
}

additional_tags = {
  "Server" = "Linux"
}