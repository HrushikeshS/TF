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
  region = var.main_Region
}

resource "aws_instance" "MyIncident1" {
  ami           = "ami-0d54604676873b4ec"
  instance_type = "t2.micro"

  tags = {
    Name = "MyIncident"
  }

}