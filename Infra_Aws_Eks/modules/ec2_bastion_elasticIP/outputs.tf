output "ec2_bastion_public_instances_ids" {
    description = "List of IDs of instances"
    value = module.ec2_instance.id
}

output "ec2_bastion_eip" {
    description = "Elastic IP associated to the bation Host"
    value = aws_eip.lb.public_ip
}