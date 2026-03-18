import {
  to = module.s3_bucket_state_2.aws_s3_bucket.this[0]
  id = "terraform-20260318140347320800000001"
}

moved {
    from = module.s3_bucket
    to   = module.s3_bucket_state
}



module "s3_bucket_state" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "terraform-state-for-teaching-${var.environment}"

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  versioning = {
    enabled = true
  }
}

module "s3_bucket_state_2" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "terraform-20260318140347320800000001"

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  versioning = {
    enabled = true
  }
}