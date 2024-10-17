resource "aws_iam_role" "LambdaDynamoDBRoleTF" {
  name = "LambdaDynamoDBRoleTF"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "BasicLambdaExecutionRoleAttachment" {
  role       = aws_iam_role.LambdaDynamoDBRoleTF.name
  policy_arn = var.lambda_basic_execution_role_arn
}

resource "aws_iam_policy" "LambdaDynamoDBPolicyTF" {
  name        = "LambdaDynamoDBPolicyTF"
  description = "Allows Lambda to access DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:PutItem"
        ],
        Resource = aws_dynamodb_table.cloud-resume-data-tf.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "LambdaDynamoDBPolicyAttachment" {
  role       = aws_iam_role.LambdaDynamoDBRoleTF.name
  policy_arn = aws_iam_policy.LambdaDynamoDBPolicyTF.arn
}

resource "aws_lambda_function" "lambda_table_test_tf" {
  function_name    = "LambdaTableTestTF"
  filename         = local.lambda_table_path
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  role             = aws_iam_role.LambdaDynamoDBRoleTF.arn
  source_code_hash = filebase64sha256(local.lambda_table_path)
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_table_test_tf.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.rest_api_tf.execution_arn}/*/*"
}
