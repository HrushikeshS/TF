variable "ec2_config" {
    type = list(object({
      ami = string
      ec2_type = string 
    }))
}