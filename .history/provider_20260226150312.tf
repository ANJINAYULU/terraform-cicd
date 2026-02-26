terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.34.0"
    }
  }
}

# provider "aws" {
#   # Configuration options  
#   region = "us-east-1"
# }

terraform {
  backend "s3" {
    bucket         = "terraform-state-anji"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

