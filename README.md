# Eks_Home_Project

## Initialize Terraform
terraform init

## Terraform Validate
terraform validate

## Terraform Plan to verify what is going to create or update or delete
terraform plan

## Terraform Apply to execute the deployment
terraform apply




![Alt text](./images/aws%20document.png "Title")


Create VPC
Create private and public subnet
Create an internet gateway and associate to the VPC
Create the Nat Gateway into public subnet
Create Public route => then add public route via Internet Gateway and associate it to the public subnet
Create Private route => then add private route via Nat Gateway and associate it to the private subnet