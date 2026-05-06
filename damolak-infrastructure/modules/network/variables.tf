variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "environment" {
  type = string
}

variable "eip_allocation_id" {
  type        = string
  description = "Pre-created EIP allocation ID for NAT Gateway"
}