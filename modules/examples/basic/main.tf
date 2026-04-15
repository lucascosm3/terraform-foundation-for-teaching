provider "aws" {
  region = "us-east-1"
}

module "sqs" {
  source = "../../modules/sqs"

  name        = "order-events"
  environment = "np"

  tags = {
    Team = "platform"
  }
}

module "eventbridge" {
  source = "../../modules/eventbridge"

  name           = "order-events"
  environment    = "np"
  event_pattern  = jsonencode({
    source      = ["my.custom.source"]
    detail-type = ["Order Created"]
  })
  sqs_queue_arn = module.sqs.sqs_queue_arn
  sqs_queue_url = module.sqs.sqs_queue_url

  tags = {
    Team = "platform"
  }
}