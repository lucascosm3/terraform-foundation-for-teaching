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
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  user_data = <<EOF
#!/bin/bash
aws s3 cp s3://${module.s3_bucket_script_instance.s3_bucket_id}/setup-ec2.sh /tmp/setup-ec2.sh
chmod +x /tmp/setup-ec2.sh
/tmp/setup-ec2.sh
EOF

depends_on = [ aws_s3_object.setup-ec2-sh ]
  tags = {
    Name = "HelloWorld"
  }
}