terraform {
  
}

variable "numberList" {
    type = list(number)
    default = [ 1,2,3,4,5 ]
}

variable "personList" {
    type = list(object({
      fname = string
      lname = string
    }))
  default = [{
    fname = "raju"
    lname = "rastogi"
  },
  {
    fname = "Ranchoddas"
    lname = "chanchad"
  }
]
}

#maplist
variable "mapList" {
    type = map(number)
    default = {
        "one"=1
        "two"=2
        "three"=3
    }
}

#Calculations

locals {
  mul = 2*2
  add = 2+2
  m = 2==2

  #double the list
  double = [for num in var.numberList: num*2]

  #odd number
  odd = [for n in var.numberList: n if n%2!=0]

  #only fname from list of object
  fnames = [for p in var.personList: p.fname]

  #working with map take key value info

  keys =[for key,value in var.mapList: key] 
}
output "calc" {
    value = local.mul  
}

output "calc2" {
    value = local.m 
}

output "doubles" {
    value = local.double
}

output "odds" {
    value = local.odd
}

output "fnames" {
    value = local.fnames
}

output "maps" {
    value = local.keys
}