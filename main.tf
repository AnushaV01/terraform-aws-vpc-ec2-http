module "vpc" {
  source               = "./modules/network"
  project              = var.project
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = merge(var.tags, { Project = var.project })
}

module "ec2" {
source            = "./modules/compute"
vpc_id            = module.vpc.vpc_id
public_subnet_ids = module.vpc.public_subnet_ids
instance_type     = var.instance_type
tags              = merge(var.tags, { Project = var.project })
}