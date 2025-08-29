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
  region = var.region
}

locals {
  name = "MyIncident"
}

resource "aws_instance" "MyIncident" {
  ami           = "ami-0144277607031eca2"
  instance_type = var.aws_instance_type
  root_block_device {
    delete_on_termination = true
    volume_size = var.root_block_config.root_vol_size
    volume_type = var.root_block_config.root_vol_type
  }

  tags = merge(var.additional_tags,{
    Name = locals.name              #taking name from local variables
  })
}