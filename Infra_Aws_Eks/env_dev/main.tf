terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.22.0"
        } 
    }
}

provider "aws" {
    region = var.aws_region
    profile = var.aws_profile
}

module "vpc_dev" {
    source = "../modules/vpc_securities"

}

module "ec2_instance" {
    source = "../modules/ec2_bastion_elasticIP"
}