module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "terraform-state-for-teaching-${var.environment}"

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  versioning = {
    enabled = true
  }
  tags = {
    Name        = "terraform-state-${var.environment}"
    Environment = var.environment
    AccountID   = var.account-id
    Managed-by  = var.managed-by
  
}
}