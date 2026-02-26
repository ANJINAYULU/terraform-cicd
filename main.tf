resource "aws_s3_bucket" "backend" {
  bucket = var.bucket_name

  tags = {
    Name        = "anji bucket"
    Environment = "test"
  }
}