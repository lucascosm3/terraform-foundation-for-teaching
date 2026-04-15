output "sqs_queue_arn" {
  value       = module.sqs.sqs_queue_arn
  description = "ARN of the main SQS queue"
}

output "sqs_queue_url" {
  value       = module.sqs.sqs_queue_url
  description = "URL of the main SQS queue"
}

output "sqs_queue_name" {
  value       = module.sqs.sqs_queue_name
  description = "Name of the main SQS queue"
}

output "dlq_queue_arn" {
  value       = module.sqs.dlq_queue_arn
  description = "ARN of the Dead Letter Queue"
}

output "dlq_queue_url" {
  value       = module.sqs.dlq_queue_url
  description = "URL of the Dead Letter Queue"
}

output "dlq_queue_name" {
  value       = module.sqs.dlq_queue_name
  description = "Name of the Dead Letter Queue"
}

output "eventbridge_rule_arn" {
  value       = module.eventbridge.eventbridge_rule_arn
  description = "ARN of the EventBridge Rule"
}

output "eventbridge_rule_name" {
  value       = module.eventbridge.eventbridge_rule_name
  description = "Name of the EventBridge Rule"
}