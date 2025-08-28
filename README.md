# Terraform — AWS VPC + EC2 (HTTP-ready)

Provisions a VPC (`10.0.0.0/16`) with **three public** and **three private** subnets across **three AZs**, plus one EC2 instance in a **public** subnet. The instance is reachable on **TCP/80** by IP when a web server is running. No third-party modules.

## What’s included
- VPC `10.0.0.0/16`
- 3 public subnets (public IPs on launch) across 3 AZs
- 3 private subnets across the same 3 AZs
- Internet Gateway and a public route table (`0.0.0.0/0 → IGW`) associated to public subnets
- Security group: inbound **tcp/80** from the internet, all egress
- One EC2 instance in a public subnet (Amazon Linux AMI), attached to the web SG

> Private subnets have **no direct internet route**. This repo does **not** create a NAT Gateway.

## Requirements
- Terraform ≥ **1.6**
- AWS provider ≥ **5.x**
- AWS credentials configured (profile)

## Usage
- terraform init
- terraform plan -out tf.plan
- terraform apply tf.plan

## Inputs (root)
- region (string, default ca-central-1)
- project (string, default interview-challenge)
- tags (map(string), default {})
- vpc_cidr (string, default 10.0.0.0/16)
- public_subnet_cidrs (list(string), default ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24"])
- private_subnet_cidrs (list(string), default ["10.0.100.0/24","10.0.101.0/24","10.0.102.0/24"])
- instance_type (string, default t3.micro)

## Outputs
- vpc_id
- public_subnet_ids
- private_subnet_ids
- instance_public_ip

## Verifying HTTP on port 80
- Network path is open by default:
- Instance has a public IPv4 in a public subnet
- Public route table sends 0.0.0.0/0 → IGW
- Security group allows inbound tcp/80 from 0.0.0.0/0

To see a response in the browser, start any HTTP server on the instance (e.g., install nginx manually). 
The challenge does not require installing nginx in Terraform. But, if at all wanna check add this inside resource aws_instace, web:
- user_data = <<EOF
- #!/bin/bash
- dnf -y update
- dnf -y install nginx
- systemctl enable nginx
- systemctl start nginx
- echo OK > /usr/share/nginx/html/index.html
- EOF

Then, open http://<instance_public_ip> to cross-check.

## Clean up
terraform destroy

## Notes
- Code contains no comments, per the prompt.
- .terraform.lock.hcl is committed to pin provider versions.
- Local state (*.tfstate) and .terraform/ are git-ignored.
