output "eventbridge_rule_arn" {
  value       = aws_cloudwatch_event_rule.this.arn
  description = "ARN of the EventBridge Rule"
}

output "eventbridge_rule_name" {
  value       = aws_cloudwatch_event_rule.this.name
  description = "Name of the EventBridge Rule"
}

output "eventbridge_target_id" {
  value       = aws_cloudwatch_event_target.sqs.target_id
  description = "ID of the EventBridge Target"
}

output "sqs_queue_policy_id" {
  value       = aws_sqs_queue_policy.eventbridge.id
  description = "ID of the SQS Queue Policy"
}