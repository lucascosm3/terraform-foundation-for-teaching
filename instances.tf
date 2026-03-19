# AMI to use for the instance
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# EC2 instance to test the script instance
resource "aws_instance" "web" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = <<EOF
#!/bin/bash
aws s3 cp s3://${module.s3_bucket_script_instance.s3_bucket_id}/setup-ec2.sh /tmp/setup-ec2.sh
chmod +x /tmp/setup-ec2.sh
/tmp/setup-ec2.sh
EOF

  depends_on = [aws_s3_object.setup-ec2-sh]

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "HelloWorld"
  }
}

# Security Group to allow HTTP traffic
resource "aws_security_group" "web_sg" {
  name        = "web-sg-${var.environment}"
  description = "Allow HTTP inbound traffic"

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Good practice to leave egress open to allow returning traffic / updates
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}