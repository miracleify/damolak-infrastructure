resource "aws_eip" "main" {
  domain = "vpc"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "persistent-eip"
  }
}