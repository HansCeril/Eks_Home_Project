# AWS EC2 instances type
variable "instance_type" {
    description = "type of the ec2 instance"
    type = string
    default = "t3.micro"
}

# AWS EC2 Instance keypair
variable "instance_keypair" {
    description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
    type = string
    default = "terraform-eks"
}


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

variable "business_division" {
    description = "Bisness Division this infractructure belongs"
    type = string
    default = "Home Practive"
}

