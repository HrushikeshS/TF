output "aws_instance_private_ip" {
    value = aws_instance.MyIncident.public_ip
}