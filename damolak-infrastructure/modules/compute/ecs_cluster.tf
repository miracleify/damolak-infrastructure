resource "aws_ecs_cluster" "main" {
  name = "${var.environment}-${var.app_name}-cluster"
}