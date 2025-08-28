data "aws_availability_zones" "available" {}

locals {
azs = slice(data.aws_availability_zones.available.names, 0, 3)
}

resource "aws_vpc" "this" {
cidr_block = var.vpc_cidr
tags       = merge(var.tags, { Project = "${var.project}-vpc" })
}

resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.this.id
tags   = merge(var.tags, { Project = "${var.project}-igw" })
}

resource "aws_subnet" "public" {
for_each = { for i, cidr in var.public_subnet_cidrs : i => { cidr = cidr, az = local.azs[i] } }
vpc_id = aws_vpc.this.id
cidr_block = each.value.cidr
availability_zone = each.value.az
map_public_ip_on_launch = true
tags                    = merge(var.tags, { Project = var.project, Tier = "Public", Name = "${var.project}-public-${each.key}" })
}