# AWS az datasources => Allows to the list of az
data "aws_availability_zones" "available" {
  state = "available"
  exclude_names = ["us-east-1b", "us-east-1c"]
}


# create a module VPC
module "vpc_dev" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "3.14.2"

    # ========= VPC Basics informations ===========
    name = "Vpc-Dev"
    cidr = var.vpc_cidr_block # 10.0.0.0/8 is reserved for EC2-Classic
    azs = data.aws_availability_zones.available.names
    private_subnets = var.vpc_private_subnets
    public_subnets = var.vpc_public_subnets


    # ========== VPC Databases subnets =============
    database_subnets = var.vpc_database_subnets
    create_database_subnet_group = false
    create_database_subnet_route_table= true
    # create_database_nat_gateway_route = true
    # create_database_internet_gateway_route = true


    # =========== NAT GATEWAY --> Outbound comunication ===========
    enable_nat_gateway = true
    single_nat_gateway = true

    # ================= VPC DNS PARAMETERS ==========================
    enable_dns_hostnames = true
    enable_dns_support = true


    # ================ Associate Tags to ressources ===================
    tags = {
        Owner = "hans"
        Environment = "dev"
    }

    vpc_tags = {
        Name = "vpc-dev"
    }

    # TAGS
    private_subnet_tags = {
        Type = "private-subnets"
    }

    public_subnet_tags = {
        Type = "public-subnets"
    }

    database_subnet_tags = {
        Name = "database-subnets"
    }
}