resource "aws_s3_bucket" "terraform-example-bucket" {
  bucket = var.bucket_name
  region = var.aws_region

  tags = {
    Name        = "My Test Bucket from Terraform"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "hello-world-object" {
  bucket = aws_s3_bucket.terraform-example-bucket.bucket
  key = var.file_name
  content = var.file_contents
}