locals {
  name_suffix = var.fifo_queue ? "${var.name}-${var.environment}.fifo" : "${var.name}-${var.environment}"
  dlq_name    = var.fifo_queue ? "${var.name}-dlq-${var.environment}.fifo" : "${var.name}-dlq-${var.environment}"
  merged_tags = merge(
    {
      "Managed-By"    = "iac"
      "Environment"   = var.environment
      "Module-Source" = "modules/sqs"
    },
    var.tags,
  )
}

resource "aws_sqs_queue" "dlq" {
  name                      = local.dlq_name
  fifo_queue                = var.fifo_queue
  message_retention_seconds = var.dlq_message_retention_seconds
  sqs_managed_sse_enabled   = true

  tags = local.merged_tags
}

resource "aws_sqs_queue" "main" {
  name                        = local.name_suffix
  fifo_queue                  = var.fifo_queue
  content_based_deduplication = var.fifo_queue ? var.content_based_deduplication : false
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_receive_count
  })
  sqs_managed_sse_enabled = true

  tags = local.merged_tags
}