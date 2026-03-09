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
