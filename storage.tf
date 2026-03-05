resource "aws_s3_bucket" "teacher_bucket" {
  bucket = "teacher-lucascosm3-bucket-${var.environment}"

  tags = {
    Name        = "teacher-lucascosm3-bucket-${var.environment}"
    Environment = var.environment
  }
}