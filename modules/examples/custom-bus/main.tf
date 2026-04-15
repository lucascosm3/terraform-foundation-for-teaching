provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudwatch_event_bus" "custom" {
  name = "custom-bus-np"
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
  event_bus_name = aws_cloudwatch_event_bus.custom.name
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