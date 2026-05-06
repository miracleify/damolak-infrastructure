terraform {
  backend "s3" {
    bucket         = "damolak-terraform-state"
    key            = "persistence-eip/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "damlok"
  }
}