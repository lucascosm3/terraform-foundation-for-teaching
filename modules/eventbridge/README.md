# EventBridge Module

Terraform module that creates an Amazon EventBridge Rule targeting an SQS queue, including the required IAM policy.

## Features

- Creates EventBridge Rule with configurable event pattern
- Creates EventBridge Target pointing to an SQS queue
- Creates SQS Queue Policy (least privilege: only `sqs:SendMessage` from the rule ARN)
- Supports default or custom Event Bus
- Designed to compose with the `sqs` module
- Tag propagation with `Environment` and `Module-Source` defaults

## Usage

### With default Event Bus

```hcl
module "sqs" {
  source = "./modules/sqs"

  name        = "order-events"
  environment = var.environment
}

module "eventbridge" {
  source = "./modules/eventbridge"

  name           = "order-events"
  environment    = var.environment
  event_pattern  = jsonencode({
    source      = ["my.custom.source"]
    detail-type = ["Order Created"]
  })
  sqs_queue_arn = module.sqs.sqs_queue_arn
  sqs_queue_url = module.sqs.sqs_queue_url
}
```

### With custom Event Bus

```hcl
resource "aws_cloudwatch_event_bus" "custom" {
  name = "custom-bus-${var.environment}"
}

module "sqs" {
  source = "./modules/sqs"

  name        = "order-events"
  environment = var.environment
}

module "eventbridge" {
  source = "./modules/eventbridge"

  name           = "order-events"
  environment    = var.environment
  event_bus_name = aws_cloudwatch_event_bus.custom.name
  event_pattern  = jsonencode({
    source      = ["my.custom.source"]
    detail-type = ["Order Created"]
  })
  sqs_queue_arn = module.sqs.sqs_queue_arn
  sqs_queue_url = module.sqs.sqs_queue_url
}
```

### Remote Reference (for other squads)

```hcl
module "eventbridge" {
  source = "git::https://github.com/USER/terraform-foundation-for-teaching.git//modules/eventbridge?ref=v1.0.0"

  name           = "order-events"
  environment    = var.environment
  event_pattern  = jsonencode({ ... })
  sqs_queue_arn  = module.sqs.sqs_queue_arn
  sqs_queue_url  = module.sqs.sqs_queue_url
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Base name for resources (2-63 chars, alphanumeric with hyphens) | `string` | - | yes |
| environment | Environment suffix (e.g. np, prod) | `string` | - | yes |
| event_pattern | EventBridge Rule event pattern as JSON string | `string` | - | yes |
| sqs_queue_arn | ARN of the target SQS queue (from the sqs module) | `string` | - | yes |
| sqs_queue_url | URL of the target SQS queue (from the sqs module) | `string` | - | yes |
| event_bus_name | Event Bus name (use 'default' for the default bus) | `string` | `"default"` | no |
| target_id | Custom target ID (defaults to '{name}-target-{environment}') | `string` | `""` | no |
| description | Description for the EventBridge Rule | `string` | `""` | no |
| tags | Additional tags to merge into all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| eventbridge_rule_arn | ARN of the EventBridge Rule |
| eventbridge_rule_name | Name of the EventBridge Rule |
| eventbridge_target_id | ID of the EventBridge Target |
| sqs_queue_policy_id | ID of the SQS Queue Policy |