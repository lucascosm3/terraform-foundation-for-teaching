variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment of the resources"
}

variable "account_id" {
  type        = string
  description = "AWS Account ID"
  default     = "091708608334"
}
