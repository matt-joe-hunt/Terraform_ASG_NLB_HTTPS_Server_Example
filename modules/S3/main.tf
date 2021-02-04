resource "aws_s3_bucket" "bucket" {
  bucket   = var.bucket-name
  acl      = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://s3-website-test.hashicorp.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_object" "nginx-config" {
  bucket       = aws_s3_bucket.bucket.bucket
  key          = "nginx.conf"
  source       = "${path.module}/data/nginx.conf"
}