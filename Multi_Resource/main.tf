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

locals {
  Name = "Project Multi-Resource"
  m = length(var.ec2_config)
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "${local.Name} -VPC"
    }
}

resource "aws_subnet" "mysubnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.${count.index}.0/24"
    count = 2
    tags = {
      Name = "Subnet-${count.index+1}-${local.Name}"
    }
}
#creting 4 ec2 in 2 diff. subnet
resource "aws_instance" "MyIncident1" {
  ami           = element(var.ec2_config[*].ami,count.index%2)
  instance_type = element(var.ec2_config[*].ec2_type,count.index%2)
  subnet_id = element(aws_subnet.mysubnet[*].id,count.index% length(aws_subnet.mysubnet))   #logic to set subnet id for 1 and 2
  count = 4

  tags = {
    Name = "EC2-${count.index+1}-${local.Name}"
  }
}


output "vpcName" {
    value = aws_vpc.myvpc.id
}
output "subnet1" {
    value = aws_subnet.mysubnet[0].id
}
output "subnet2" {
    value = aws_subnet.mysubnet[1].id
}
