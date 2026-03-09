# VPC
resource "aws_vpc" "vpc_network_np" {
  cidr_block = "10.0.0.0/16"
  tags       = local.common_tags
}

# Internet Gateway
resource "aws_internet_gateway" "igw_np" {
  vpc_id = aws_vpc.vpc_network_np.id

  tags = local.common_tags
}

# Internet Gateway Attachment
resource "aws_internet_gateway_attachment" "igw_np_attachment" {
  internet_gateway_id = aws_internet_gateway.igw_np.id
  vpc_id              = aws_vpc.vpc_network_np.id
}

# Subnet
resource "aws_subnet" "public_np" {
  vpc_id            = aws_vpc.vpc_network_np.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = local.common_tags
}

# Route Table
resource "aws_route_table" "public_np" {
  vpc_id = aws_vpc.vpc_network_np.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_np.id
  }

  tags = local.common_tags
}

# Security Group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_network_np.id

  tags = local.common_tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = aws_vpc.vpc_network_np.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
