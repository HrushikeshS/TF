ec2_config = [{
  ami      = "ami-0f918f7e67a3323f0"  #ubuntu
  ec2_type = "t3.micro"
  },
  {
    ami      = "ami-0861f4e788f5069dd" #amzLinux
    ec2_type = "t3.nano"
}]

ec2_mapping = {
  "ubuntu" = {
    ami      = "ami-0f918f7e67a3323f0"
    ec2_type = "t3.micro"
  },
  "amazonLinux" = {
    ami      = "ami-0861f4e788f5069dd"
    ec2_type = "t3.nano"
  }
}
