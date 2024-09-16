resource "aws_dynamodb_table" "cloud-resume-data-tf" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "record_type"

  attribute {
    name = "record_type"
    type = "S"
  }
}