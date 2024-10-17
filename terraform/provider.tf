terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "backend-state-bucket-jalvz"
    key = "terraform.tfstate"
    region = "eu-west-3"
    encrypt = true
    dynamodb_table = "jalvarezresume_tf_lockid"
  }
}

provider "aws" {
  region = var.aws_region
}