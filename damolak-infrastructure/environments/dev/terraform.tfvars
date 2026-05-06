region = "us-east-1"

app_port = 5050

min_capacity = 1
max_capacity = 2

vpc_cidr = "10.0.0.0/16"

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]

environment = "dev"

  #static ip whitelisting for vendors/payment
eip_allocation_id = "eipalloc-0d9c47ec84a568a92"

 #Alerting
alert_email      = "Miracleify10@gmail.com"

enable_slack     = true

slack_webhook_url = "https://hooks.slack.com/services/..."