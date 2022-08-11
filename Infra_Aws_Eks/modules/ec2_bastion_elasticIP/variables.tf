# AWS EC2 instances type
variable "instance_type" {
    description = "type of the ec2 instance"
    type = string
    default = "t2.micro"
}

# AWS EC2 Instance keypair
variable "instance_keypair" {
    description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
    type = string
    default = "eks-terraform-key"
}
