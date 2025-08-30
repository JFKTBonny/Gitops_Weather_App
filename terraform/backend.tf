terraform {
  backend "s3" {
    bucket = "bonny1203"
    key    = "gitops-weather-app/dev/terraform.tfstate"
    region = "us-east-1"
    
  }
}


# aws dynamodb create-table \
#   --table-name terraform-locks \
#   --attribute-definitions AttributeName=LockID,AttributeType=S \
#   --key-schema AttributeName=LockID,KeyType=HASH \
#   --billing-mode PAY_PER_REQUEST
