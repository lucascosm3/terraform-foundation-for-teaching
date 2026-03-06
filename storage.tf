resource "aws_s3_bucket" "teacher_bucket" {
  bucket = "terraform-foundation-for-teaching-${var.environment}"

  tags = {
    Name        = "terraform-foundation-for-teaching-${var.environment}"
    Environment = var.environment
    AccountID   = var.account_id
  }
}