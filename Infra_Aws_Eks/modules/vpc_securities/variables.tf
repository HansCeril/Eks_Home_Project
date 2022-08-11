
variable "vpc_cidr_block" {
    description = "Ip adress range of our VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_private_subnets" {
    description = "VPC ip private subnet"
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "vpc_public_subnets" {
    description = "OwVPC ip public subnetner"
    type = list(string)
    default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_database_subnets" {
    description = "VPC ip database subnet"
    type = list(string)
    default = ["10.0.151.0/24", "10.0.152.0/24"]
}
