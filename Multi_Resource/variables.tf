#variable by list

variable "ec2_config" {
  type = list(object({
    ami      = string
    ec2_type = string
  }))
}

#variable by map

variable "ec2_mapping" {
  #it saves in key value pair not in form of list.
  type = map(object({
    ami      = string
    ec2_type = string
  }))

}

