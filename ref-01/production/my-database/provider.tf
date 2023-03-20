terraform {
  required_version = ">= 0.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }

  backend "s3" {
    bucket = "my-bucket"
    key    = "my-product/production/database.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}