output "teacher_bucket_id" {
  value = aws_s3_bucket.teacher_bucket.id
}

output "teacher_bucket_arn" {
  value = aws_s3_bucket.teacher_bucket.arn
}

output "teacher_bucket_name" {
  value = aws_s3_bucket.teacher_bucket.bucket
}