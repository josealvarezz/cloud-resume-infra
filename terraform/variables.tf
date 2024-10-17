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

variable "table_name" {
  description = "Name for the DynamoDB table"
  default     = "cloud-resume-data-tf"
  # To change in final ver
}

variable "lambda_table_path_local" {
  description = "Path to Lambda Table Function"
  default     = "../../backend/lambda/lambda_function.zip"
}

variable "lambda_table_path_ga" {
  description = "Path to Lambda Table Function when called through Github Actions"
  default = "lambda_function.zip"
}

variable "lambda_basic_execution_role_arn" {
  description = "ARN for Lambda basic execution role"
  default     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

variable "is_github_actions" {
  description = "Flag to identify if running from GitHub Actions"
  type        = bool
  default     = false
}
