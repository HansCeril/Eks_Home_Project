# Insert Module vpc
module "vpc_dev" {
    source = "../vpc_securities"

}


# We will get the latest AMI EC2 instance
data "aws_ami" "amzlinux2" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

module "ec2_bastion_security_group" {
    source = "terraform-aws-modules/security-group/aws"
    name        = "dev-public-bastion-sg"
    description = "Security group for bastion, open ssh port 22 for everybody (IPv4 CIDR) HTTP ports open within VPC"
    vpc_id = module.vpc_dev.vpc_id
    # Ingress Rules & CIDR Blocks
    ingress_rules = ["ssh-tcp"]
    ingress_cidr_blocks = ["0.0.0.0/0"]
    # Egress Rule - all-all open
    egress_rules = ["all-all"]
    tags = local.common_tags
    depends_on = [
      module.vpc_dev
    ]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  name = "ec2-bastionHost"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  subnet_id              = module.vpc_dev.public_subnets[0]
  vpc_security_group_ids = [module.ec2_bastion_security_group.security_group_id]
  tags = local.common_tags
  depends_on = [
    module.ec2_bastion_security_group,
    module.vpc_dev
  ]
}

resource "aws_eip" "lb" {
  depends_on = [
    module.vpc_dev,
    module.ec2_instance
  ]
  instance = module.ec2_instance.id 
  vpc      = true
  tags = local.common_tags
}

#Ressource for acces to the ec2_bastion and copy the key file
resource "null_resource" "copy_ec2_keys" {
    depends_on = [
      module.ec2_instance
    ]

    connection {
        type = "ssh"
        host = aws_eip.lb.public_ip
        user = "ec2-user"
        password = ""
        private_key = file("../private-key/terraform-eks.pem")
    }

    provisioner "file" {
      source = "../private-key/terraform-eks.pem"
      destination = "/tmp/terraform-eks.pem"
      
    }

    provisioner "remote-exec" {
      inline = [
        "sudo chmod 400 /tmp/terraform-eks.pem"
      ]
    }

    provisioner "local-exec" {
      command = "echo VPC created on `date` and VPC ID : ${module.vpc_dev.vpc_id} >> creation-time-vpc-id.txt"
      working_dir = "local-exec-output-files"
    }
}