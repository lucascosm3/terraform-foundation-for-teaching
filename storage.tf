import {
  to = aws_s3_bucket.s3_bucket
  identity = {
    bucket = "terraform-state-for-teaching-${var.environment}"
  }
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "terraform-state-for-teaching-${var.environment}"

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  versioning = {
    enabled = true
  }
}