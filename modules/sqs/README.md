# SQS Module

Terraform module that creates an Amazon SQS queue with a required Dead Letter Queue (DLQ).

## Features

- Standard or FIFO queue support
- Mandatory DLQ with configurable retention
- Configurable redrive policy (`max_receive_count`)
- SSE-SQS encryption enabled by default
- Input validation on all critical variables
- Consistent naming: uses `{name}` as provided (FIFO queues get `.fifo` suffix). Pass `name = "myqueue-{env}"` to include environment
- Tag propagation with `Environment` and `Module-Source` defaults

## Usage

### Standard Queue

```hcl
module "sqs" {
  source = "./modules/sqs"

  name        = "order-events-${var.environment}"
  environment = var.environment

  tags = local.common_tags
}
```

### FIFO Queue

```hcl
module "sqs" {
  source = "./modules/sqs"

  name                        = "order-events-${var.environment}"
  environment                 = var.environment
  fifo_queue                  = true
  content_based_deduplication = true

  tags = local.common_tags
}
```

### Remote Reference (for other squads)

```hcl
module "sqs" {
  source = "git::https://github.com/USER/terraform-foundation-for-teaching.git//modules/sqs?ref=v1.0.0"

  name        = "order-events-${var.environment}"
  environment = var.environment
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Base name for resources (2-63 chars, alphanumeric with hyphens) | `string` | - | yes |
| environment | Environment suffix (e.g. np, prod) | `string` | - | yes |
| fifo_queue | Create a FIFO queue instead of Standard | `bool` | `false` | no |
| content_based_deduplication | Enable content-based deduplication (FIFO only) | `bool` | `false` | no |
| max_receive_count | Deliveries before message goes to DLQ (1-20) | `number` | `3` | no |
| visibility_timeout_seconds | Visibility timeout in seconds (0-43200) | `number` | `30` | no |
| message_retention_seconds | Main queue retention (60-1209600) | `number` | `345600` | no |
| dlq_message_retention_seconds | DLQ retention (60-1209600) | `number` | `1209600` | no |
| tags | Additional tags to merge into all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| sqs_queue_arn | ARN of the main SQS queue |
| sqs_queue_url | URL of the main SQS queue |
| sqs_queue_name | Name of the main SQS queue |
| dlq_queue_arn | ARN of the Dead Letter Queue |
| dlq_queue_url | URL of the Dead Letter Queue |
| dlq_queue_name | Name of the Dead Letter Queue |