variable "alert_email" {
  type = string
}

variable "enable_slack" {
  type    = bool
  default = true
}

variable "slack_webhook_url" {
  type      = string
  sensitive = true
}

variable "environment" {
  type = string
}