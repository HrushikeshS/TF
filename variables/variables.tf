variable "region" {
    description = "Region value"
    default = "ap-south-1"
}

variable "aws_instance_type" {
    description = "Enter instance type you want: "
    type = string
    validation {
      condition = var.aws_instance_type=="t2.micro" || var.aws_instance_type=="t3.micro"     #put validation condition
      error_message = "Please select t2.micro or t3.micro only"                              #set error msg
    }
}
# env variable
#$ export TF_VAR_aws_instance_type="t2.micro"


# user diff properties of same block
# variable "root_volume_size" {
#     description = "root volume size : "
#     type = number
#     default = 20
# }
# variable "root_volume_type" {
#     description = "root volume type : "
#     type = string
#     default = "gp2"
# }

# create 2 diff variable in same block
variable "root_block_config" {
    type = object({
      root_vol_size = number
      root_vol_type = string 
    })
    default = {
      root_vol_size = 26
      root_vol_type = "gp3"
    }
}

#variable additional tags
variable "additional_tags" {
    type = map(string)
    default = {}  
}