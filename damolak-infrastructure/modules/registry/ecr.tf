resource "aws_ecr_repository" "app" {
  name                 = "${var.environment}-${var.repository_name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.environment}-${var.repository_name}"
  }
}