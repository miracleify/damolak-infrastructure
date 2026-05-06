variable "environment" {
  type = string
}

variable "app_name" {
  type = string
}

variable "image_url" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "app_port" {
  type = number
}


variable "min_capacity" {
  type    = number
  default = 1
}

variable "max_capacity" {
  type    = number
  default = 3
}

variable "target_group_arn" {
  type = string
}