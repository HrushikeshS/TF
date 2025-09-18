    # Configure the AWS Provider
    provider "aws" {
      region = "ap-south-1" # Replace with your desired AWS region
    }

    # Create a Security Group for SSH and HTTP access
    resource "aws_security_group" "jenkins_sg" {
      name        = "jenkins-security-group"
      description = "Allow SSH and HTTP traffic"
      ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Restrict this in production
      }
      ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Restrict this in production
      }
      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
      tags = {
        Name = "JenkinSecurityGroup"
      }
    }

    # Create an EC2 instance
    resource "aws_instance" "jenkins_server" {
      ami           = "ami-0861f4e788f5069dd" # Example: Amazon Linux 2 AMI in us-east-1
      instance_type = "t2.medium"
      key_name      = "JenkinServer" # Replace with your existing EC2 key pair name
      vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

      # User data to install and start Nginx
      user_data = <<-EOF
                  #!/bin/bash
                  sudo yum update -y
                  sudo wget -O /etc/yum.repos.d/jenkins.repo \
                  https://pkg.jenkins.io/redhat-stable/jenkins.repo
                  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
                  sudo dnf upgrade -y
                  # Add required dependencies for the jenkins package
                  sudo dnf install fontconfig java-21* -y
                  sudo dnf install jenkins -y
                  sudo systemctl daemon-reload
                  systemctl start jenkins
                  systemctl enable jenkins
                  EOF

      tags = {
        Name = "JenkinServer"
      }
    }

    # Output the public IP address of the EC2 instance
    output "public_ip" {
      value = aws_instance.jenkins_server.public_ip
    }
    output "website_url" {
      value = join("",["http://",aws_instance.jenkins_server.public_dns,":8080"])
    }
  