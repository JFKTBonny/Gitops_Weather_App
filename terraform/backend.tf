terraform {
  backend "s3" {
    bucket = "bonny1203"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
