terraform {
  
}

variable "message" {
    default = "Hello Word"
}

variable "List" {
    type = list(string)
    default = [ "server1","server2","server3","server1"]
}

#using function

output "output" {
    #value = lower(var.message)
    #value = upper(var.message)
    #value = startswith(var.message,"Hello")    #true
    #value = length(var.List)
    #value = split("-",var.message)
    #value = abs(-12)      # 12
    #value = join(":",var.List)
    #value = contains(var.List,"server1")              #true
    #value = toset(var.List)                            #wil show set from list
    value = max(1,2,3,55,44)
    }