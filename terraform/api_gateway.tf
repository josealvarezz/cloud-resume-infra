resource "aws_api_gateway_rest_api" "rest_api_tf" {
  name        = "TFRestAPI"
  description = "API Gateway REST"
}

resource "aws_api_gateway_resource" "visitor_resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_tf.id
  parent_id   = aws_api_gateway_rest_api.rest_api_tf.root_resource_id
  path_part   = "visitors"
}

resource "aws_api_gateway_method" "visitor_get" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api_tf.id
  resource_id   = aws_api_gateway_resource.visitor_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api_tf.id
  resource_id             = aws_api_gateway_resource.visitor_resource.id
  http_method             = aws_api_gateway_method.visitor_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_table_test_tf.invoke_arn
}

resource "aws_api_gateway_method_response" "method_response" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_tf.id
  resource_id = aws_api_gateway_resource.visitor_resource.id
  http_method = aws_api_gateway_method.visitor_get.http_method
  status_code = "200"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_tf.id
  stage_name  = "prod"

  depends_on = [
    aws_api_gateway_method.visitor_get,
    aws_api_gateway_integration.lambda_integration
  ]
}

module "cors" {
  source  = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"

  api_id          = aws_api_gateway_rest_api.rest_api_tf.id
  api_resource_id = aws_api_gateway_resource.visitor_resource.id
}

output "api_gateway_url" {
  value       = "${aws_api_gateway_deployment.api_deployment.invoke_url}/visitors"
  description = "The URL of the API Gateway to invoke the Lambda"
}
