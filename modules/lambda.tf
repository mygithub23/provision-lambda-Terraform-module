
# CloudWatch Log Group with retention
resource "aws_cloudwatch_log_group" "lambda_cloudwatch" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 3

  tags = {
    Environment = "production"
    Function    = var.function_name
  }
}

# Lambda execution role
resource "aws_iam_role" "lambda_module_role" {
  name = "lambda_execution_module_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# CloudWatch Logs policy
resource "aws_iam_policy" "lambda_module_logging" {
  name        = "lambda_module_logging"
  path        = "/"
  description = "IAM policy for logging from Lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = ["arn:aws:logs:*:*:*"]
      }
    ]
  })
}

# Attach logging policy to Lambda role
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_module_role.name
  policy_arn = aws_iam_policy.lambda_module_logging.arn
}

# Lambda function with logging
resource "aws_lambda_function" "this" {
  filename      = var.filename
  function_name = var.function_name
  role          = aws_iam_role.lambda_module_role.arn
  handler       = var.handler
  runtime       = var.runtime

  # Advanced logging configuration
  logging_config {
    log_format            = "JSON"
    application_log_level = "INFO"
    system_log_level      = "WARN"
  }

  # Ensure IAM role and log group are ready
  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.lambda_cloudwatch
  ]
}

data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.root}/build/${var.handler}"
  output_path = "${path.root}/${var.filename}"
}

data "aws_lambda_function" "this" {
  # count = var.create && var.create_deployment ? 1 : 0

  function_name = var.function_name
  # qualifier     = data.aws_lambda_alias.this.function_version
}