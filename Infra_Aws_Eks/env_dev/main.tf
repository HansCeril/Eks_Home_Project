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

module "ec2-bastion-security-group" {
    source = "../modules/ec2_bastion_elasticIP"
    vpc_id = module.vpc_dev.vpc_id

}

module "ec2_instance" {
    source = "../modules/ec2_bastion_elasticIP"
    vpc_id = module.vpc_dev.vpc_id
    vpc_security_group_ids = [module.ec2-bastion-security-group.security_group_id]


}