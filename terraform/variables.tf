variable "aws_region" {
  description = "AWS Region where resources will be deployed"
  type        = string
  default     = "eu-west-3"
}

variable "aws_s3_bucket_name" {
  description = "Name for the S3 Bucket where dist files will be deployed"
  type        = string

  # Remove -tf in final version
  default = "jalvarez-resume-tf.com"
}


variable "source_files" {
  description = "Directory containing the files to be uploaded to S3"
  default     = "../../frontend/dist/frontend/browser"
}