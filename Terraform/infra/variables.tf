variable "vpc1_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet1_cidr_blocks" {
  description = "The list of CIDR blocks to use in building the subnets. List size needs to match availability zone count"
  type        = list
}

variable "vpc2_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet2_cidr_blocks" {
  description = "The list of CIDR blocks to use in building the subnets. List size needs to match availability zone count"
  type        = list
}

variable "availability_zones" {
  description = "The list of availability zone to utilize in a given region"
  type        = list
}

variable "environment" {
  description = "The environment type being created"
  type        = string
}
