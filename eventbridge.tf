module "eventbridge" {
  source = "./modules/eventbridge"

  name          = "order-events-${var.environment}"
  environment   = var.environment
  event_pattern = jsonencode({
    source      = ["com.myapp.orders"]
    detail-type = ["Order Created", "Order Updated"]
  })
  sqs_queue_arn = module.sqs.sqs_queue_arn
  sqs_queue_url = module.sqs.sqs_queue_url

  tags = local.common_tags
}