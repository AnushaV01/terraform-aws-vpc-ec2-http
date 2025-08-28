variable "region" {
  type    = string
  default = "ca-central-1"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "project" {
  type    = string
  default = "interview-challenge"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.100.0/24", "10.0.101.0/24", "10.0.102.0/24"]
}