terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "myami" {
  most_recent = true
  owners = [ "amazon" ]  
}
output "ami_details" {
  value = data.aws_ami.myami.id
}


#security group from portal
data "aws_security_group" "name" {
  tags = {
    Name = "mywebserver"
  }
}
output "sg" {
  value = data.aws_security_group.name.id
}

#VPC
data "aws_vpc" "name" {
  tags = {
    Name="MyVPC"
  }
}
output "vpc" {
  value = data.aws_vpc.name
}

#AZ
data "aws_availability_zones" "name" {
  state = "available"
}
output "AZ" {
  value = data.aws_availability_zones.name
}

#get the account user details
data "aws_caller_identity" "name" {
}
output "userinfo" {
  value = data.aws_caller_identity.name
}

#get region
data "aws_region" "name" {
}
output "region" {
  value =  data.aws_region.name
}
# resource "aws_instance" "MyIncident" {
#   ami           = data.aws_ami.myami.id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "MyIncident"
#   }
# }