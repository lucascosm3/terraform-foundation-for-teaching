terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.39"
    }
  }

  backend "s3" {}

}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = local.common_tags
  }
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.10.0"
}