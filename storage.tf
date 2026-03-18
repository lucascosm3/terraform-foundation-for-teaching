resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "terraform-state-for-teaching-${var.environment}"

  tags = {
    Name        = "terraform-state-${var.environment}"
    Environment = var.environment
    AccountID   = var.account-id
    Managed-by  = var.managed-by
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

module "s3_bucket_state" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "terraform-state-for-teaching-${var.environment}"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

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