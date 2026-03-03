resource "aws_s3_bucket" "teacher_bucket" {
  bucket = "teacher-lucascosm3-bucket-dev"

  tags = {
    Name        = "teacher-lucascosm3-bucket"
    Environment = "Dev"
  }
}