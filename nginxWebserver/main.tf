    # Configure the AWS Provider
    provider "aws" {
      region = "ap-south-1" # Replace with your desired AWS region
    }

    # Create a Security Group for SSH and HTTP access
    resource "aws_security_group" "nginx_sg" {
      name        = "nginx-security-group"
      description = "Allow SSH and HTTP traffic"
      ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Restrict this in production
      }
      ingress {
        from_port   = 80
        to_port     = 80
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
        Name = "NginxSecurityGroup"
      }
    }

    # Create an EC2 instance
    resource "aws_instance" "nginx_server" {
      ami           = "ami-0861f4e788f5069dd" # Example: Amazon Linux 2 AMI in us-east-1
      instance_type = "t2.micro"
      key_name      = "JenkinServer" # Replace with your existing EC2 key pair name
      vpc_security_group_ids = [aws_security_group.nginx_sg.id]

      # User data to install and start Nginx
      user_data = <<-EOF
                  #!/bin/bash
                  sudo yum update -y
                  sudo yum install nginx -y
                  sudo systemctl start nginx
                  sudo systemctl enable nginx
                  echo "<html><body><h1>Welcome to Hrushis Nginx page</h1></body></html>" > /usr/share/nginx/html/index.html
                  EOF

      tags = {
        Name = "NginxWebServer"
      }
    }

    # Output the public IP address of the EC2 instance
    output "public_ip" {
      value = aws_instance.nginx_server.public_ip
    }
 