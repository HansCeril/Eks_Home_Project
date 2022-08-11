# Aws region
variable "aws_region" {
    description = "Define region in wich we will deploy our ressources"
    type = string
    default = "us-east-1"
}

# Profile Aws
variable "aws_profile" {
    description = "type of credential"
    type = string
    default = "default"
}

variable "environment" {
    description = "which environment we are working"
    type = string
    default = "dev"
}
