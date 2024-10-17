locals {
  lambda_table_path = var.is_github_actions ? var.lambda_table_path_ga : var.lambda_table_path_local
}