output "terraform_state_bucket_id" {
  value = aws_s3_bucket.terraform_state_bucket.id
}

output "terraform_state_bucket_arn" {
  value = aws_s3_bucket.terraform_state_bucket.arn
}

output "terraform_state_bucket_name" {
  value = aws_s3_bucket.terraform_state_bucket.bucket
}