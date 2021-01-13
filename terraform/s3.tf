##########
#   S3   #
##########
resource "aws_s3_bucket" "gadget-s3-bucket" {
  bucket = "gadget-s3-bucket-for-images"
  acl = "public-read"
  
  cors_rule {
    allowed_origins = ["*"]
    allowed_methods = ["GET"]
    allowed_headers = ["*"]
  }

  tags = {
    Name = "gadget-s3-bucket-for-images"
  }
}
resource "aws_s3_bucket" "artifact" {
  bucket = "artifact-pragmatic-terraform-for-gadget"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}