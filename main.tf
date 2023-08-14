terraform {

  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
  }

  backend "s3" {
    bucket  = "bucket-s3-tfstate"
    key     = "aws/us-east-1/ec2/terraform.tfstate"
    region  = "us-east-1"
    #profile = "default"
  }
}

provider "aws" {
  region  = "us-east-1"
  #profile = "default"

  default_tags {
    tags = {
      owner      = "DevOps"
      managed-by = "terraform"
    }
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket  = "bucket-s3-tfstate"
    key     = "aws/us-east-1/network/terraform.tfstate"
    region  = "us-east-1"
    #profile = "default"
  }
}
