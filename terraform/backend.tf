terraform {
  backend "s3" {
    bucket = "bonny1203"
    key = "gitops-weather-app/${var.environment}/terraform.tfstate"
    region = "us-east-1"
  }
}
