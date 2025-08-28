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