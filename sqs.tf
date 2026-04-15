module "sqs" {
  source = "./modules/sqs"

  name        = "order-events-${var.environment}"
  environment = var.environment

  tags = local.common_tags
}