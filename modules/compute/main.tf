data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_security_group" "web" {
name   = "web-sg"
vpc_id = var.vpc_id
tags   = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "http" {
security_group_id = aws_security_group.web.id
cidr_ipv4         = "0.0.0.0/0"
from_port         = 80
to_port           = 80
ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}