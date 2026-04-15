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

variable "fifo_queue" {
  type        = bool
  default     = false
  description = "Whether to create a FIFO queue instead of Standard"
}

variable "content_based_deduplication" {
  type        = bool
  default     = false
  description = "Enable content-based deduplication (FIFO queues only)"

  validation {
    condition     = var.content_based_deduplication ? var.fifo_queue : true
    error_message = "content_based_deduplication can only be true when fifo_queue is true."
  }
}

variable "max_receive_count" {
  type        = number
  default     = 3
  description = "Times a message is received before going to DLQ"

  validation {
    condition     = var.max_receive_count >= 1 && var.max_receive_count <= 20
    error_message = "max_receive_count must be between 1 and 20."
  }
}

variable "visibility_timeout_seconds" {
  type        = number
  default     = 30
  description = "Visibility timeout for the main queue (seconds)"

  validation {
    condition     = var.visibility_timeout_seconds >= 0 && var.visibility_timeout_seconds <= 43200
    error_message = "Must be between 0 and 43200 (12h)."
  }
}

variable "message_retention_seconds" {
  type        = number
  default     = 345600
  description = "Message retention for the main queue in seconds (default 4 days)"

  validation {
    condition     = var.message_retention_seconds >= 60 && var.message_retention_seconds <= 1209600
    error_message = "Must be between 60 and 1209600 (14 days)."
  }
}

variable "dlq_message_retention_seconds" {
  type        = number
  default     = 1209600
  description = "Message retention for DLQ in seconds (default 14 days)"

  validation {
    condition     = var.dlq_message_retention_seconds >= 60 && var.dlq_message_retention_seconds <= 1209600
    error_message = "Must be between 60 and 1209600 (14 days)."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to merge into all resources"
}