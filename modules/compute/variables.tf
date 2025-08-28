variable "vpc_id" { 
    type = string 
}

variable "public_subnet_ids" { 
    type = list(string) 
}

variable "instance_type" { 
    type = string 
}

variable "tags" { 
    type = map(string)
}