module "vpc_network_np" {
  source = "./modules/vpc"

  vpc_name           = "vpc_network_np"
  vpc_cidr           = "10.0.0.0/16"
  enable_nat_gateway = false
  public_subnets = {
    public_np = {
      cidr = "10.0.1.0/24"
      az   = "us-east-1a"
    }
  }
}

module "vpc_network_prod" {
  source = "./modules/vpc"

  vpc_name           = "vpc_network_prod"
  vpc_cidr           = "10.1.0.0/16"
  enable_nat_gateway = false
  public_subnets = {
    public_prod = {
      cidr = "10.1.1.0/24"
      az   = "us-east-1a"
    }
  }
}

module "vpc_np_module_remote_aws" {
  source = "terraform-aws-modules/vpc/aws"
  

  name = "vpc-np-module-remote-aws-${var.environment}"
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