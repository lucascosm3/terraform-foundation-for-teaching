# VPC with module remote AWS
module "vpc_np_module_remote_aws" {
  source = "terraform-aws-modules/vpc/aws"


  name = "vpc-np-${var.environment}"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    managed-by  = "${var.managed-by}"
    environment = "${var.environment}"
  }
}