resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.aws_s3_bucket_name

  tags = {
    Name = var.aws_s3_bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public_access_configuration" {
  bucket = aws_s3_bucket.s3_bucket.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_website_configuration" "s3_website_config" {
  bucket = aws_s3_bucket.s3_bucket.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowCloudFrontAccess",
        Effect = "Allow",
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.s3_oai.iam_arn
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.s3_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "s3_provision_dist_files" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  for_each = fileset("${var.source_files}/", "**/*")

  key         = each.value
  source      = "${var.source_files}/${each.value}"
  
  content_type = lookup({
    "html" = "text/html",
    "css"  = "text/css",
    "js"   = "application/javascript",
  }, regex("\\.([a-zA-Z0-9]+)$", each.value)[0], "application/octet-stream")
}