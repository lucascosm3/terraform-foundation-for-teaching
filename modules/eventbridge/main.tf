locals {
  merged_tags = merge(
    {
      "Managed-By"    = "iac"
      "Environment"   = var.environment
      "Module-Source" = "modules/eventbridge"
    },
    var.tags,
  )
  effective_target_id = var.target_id != "" ? var.target_id : "${var.name}-target-${var.environment}"
  rule_description     = var.description != "" ? var.description : "Routes events to SQS queue for ${var.name}-${var.environment}"
}

resource "aws_cloudwatch_event_rule" "this" {
  name           = "${var.name}-rule-${var.environment}"
  description    = local.rule_description
  event_bus_name = var.event_bus_name
  event_pattern  = var.event_pattern

  tags = local.merged_tags
}

resource "aws_cloudwatch_event_target" "sqs" {
  rule           = aws_cloudwatch_event_rule.this.name
  target_id      = local.effective_target_id
  arn            = var.sqs_queue_arn
  event_bus_name = var.event_bus_name
}

data "aws_iam_policy_document" "eventbridge_to_sqs" {
  statement {
    sid    = "AllowEventBridgeSendMessages"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    actions   = ["sqs:SendMessage"]
    resources = [var.sqs_queue_arn]
    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudwatch_event_rule.this.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "eventbridge" {
  queue_url = var.sqs_queue_url
  policy    = data.aws_iam_policy_document.eventbridge_to_sqs.json
}