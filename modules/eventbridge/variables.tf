variable "name" {
  type        = string
  description = "Base name for all resources. Must be alphanumeric with hyphens."

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{1,62}$", var.name))
    error_message = "Name must start with a letter, be 2-63 chars, alphanumeric with hyphens."
  }
}

variable "environment" {
  type        = string
  description = "Environment suffix (e.g. np, prod, staging)"

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{0,19}$", var.environment))
    error_message = "Environment must start with a letter, max 20 chars."
  }
}

variable "event_pattern" {
  type        = string
  description = "EventBridge Rule event pattern as JSON string"
}

variable "event_bus_name" {
  type        = string
  default     = "default"
  description = "Event Bus name. Use 'default' for the default bus."
}

variable "sqs_queue_arn" {
  type        = string
  description = "ARN of the target SQS queue (from the sqs module)"
}

variable "sqs_queue_url" {
  type        = string
  description = "URL of the target SQS queue (from the sqs module)"
}

variable "target_id" {
  type        = string
  default     = ""
  description = "Custom target ID. If empty, defaults to '{name}-target-{environment}'"
}

variable "description" {
  type        = string
  default     = ""
  description = "Description for the EventBridge Rule"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to merge into all resources"
}