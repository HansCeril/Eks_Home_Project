data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc_dev" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "3.14.2"

    # VPC INFORMATIONS
    name = "Vpc-Dev"
    cidr = var.vpc_cidr_block # 10.0.0.0/8 is reserved for EC2-Classic
    
    # AZ
    azs = data.aws_availability_zones.available.names
    
    # SUBNETS
    private_subnets = var.vpc_private_subnets
    public_subnets = var.vpc_public_subnets
    database_subnets = var.vpc_database_subnets


    # create_database_subnet_group = false
    #create_database_internet_gateway_route = true
    #create_database_nat_gateway_route = true

    # NAT GATEWAY PARAMETERS
    enable_nat_gateway = true
    single_nat_gateway = true

    # VPC DNS PARAMETERS
    enable_dns_hostnames = true
    enable_dns_support = true

    # TAGS
    private_subnet_tags = {
        Name = "private-subnets"
    }

    public_subnet_tags = {
        Name = "public-subnets"
    }

    database_subnet_tags = {
        Name = "database-subnets"
    }
}