output "sqs_queue_arn" {
  value       = aws_sqs_queue.main.arn
  description = "ARN of the main SQS queue"
}

output "sqs_queue_url" {
  value       = aws_sqs_queue.main.id
  description = "URL of the main SQS queue"
}

output "sqs_queue_name" {
  value       = aws_sqs_queue.main.name
  description = "Name of the main SQS queue"
}

output "dlq_queue_arn" {
  value       = aws_sqs_queue.dlq.arn
  description = "ARN of the Dead Letter Queue"
}

output "dlq_queue_url" {
  value       = aws_sqs_queue.dlq.id
  description = "URL of the Dead Letter Queue"
}

output "dlq_queue_name" {
  value       = aws_sqs_queue.dlq.name
  description = "Name of the Dead Letter Queue"
}