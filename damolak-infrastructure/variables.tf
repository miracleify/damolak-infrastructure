variable "region" {
  type = string
}

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


variable "app_port" {
  description = "Application port"
  type        = number
}


variable "min_capacity" {
  type = number
}

variable "max_capacity" {
  type = number
}


variable "eip_allocation_id" {
  type = string
}