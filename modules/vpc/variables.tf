variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

  # Validation of Variables
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "The value provided is not a valid CIDR block. Correct example: '10.0.0.0/16'."
  }
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
}

variable "public_subnets" {
  description = "Map of public subnets with CIDR and AZ"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnets with CIDR and AZ"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {} # If nothing is passed, no private subnets will be created
}