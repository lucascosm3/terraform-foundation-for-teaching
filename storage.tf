module "s3_bucket_state" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "terraform-state-for-teaching-${var.environment}"

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  versioning = {
    enabled = true
  }
}

# # Bucket to store the script instance to test of EC2 user data with depends_on
# module "s3_bucket_script_instance" {
#   source = "terraform-aws-modules/s3-bucket/aws"

#   bucket = "terraform-script-instance-for-teaching-${var.environment}"

#   control_object_ownership = true
#   object_ownership         = "BucketOwnerEnforced"

#   versioning = {
#     enabled = true
#   }
# }

# # Object to store the script instance to test of EC2 user data with depends_on
# resource "aws_s3_object" "setup-ec2-sh" {
#   bucket     = "terraform-script-instance-for-teaching-${var.environment}"
#   key        = "setup-ec2.sh"
#   source     = "/home/lucas/Workplaces/Labs/scripts/setup-ec2.sh"
#   etag       = filemd5("/home/lucas/Workplaces/Labs/scripts/setup-ec2.sh")
#   depends_on = [module.s3_bucket_script_instance]
# }
