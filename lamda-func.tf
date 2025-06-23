# data "archive_file" "lambda_code" {
#   type        = "zip"
#   source_file = "${path.root}/build/lambda_handler.py"
#   output_path = "${path.root}/lambda_function.zip"
# }

data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.root}/build/${var.handler}"
  output_path = "${path.root}/${var.filename}"
}


module "lambda_function" {
  source        = "./modules"
  # publish = true

  # function_name = "${random_pet.this.id}-lambda-simple"
  # handler       = "index.lambda_handler"
  # runtime       = "python3.12"
  filename      = var.filename
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime

  tags = {
    "lambda-console:blueprint" = "hello-world"
    "CreatedBy" = "Ali Alaoui"
  }  

}

# module "lambda" {
#  source        = "./modules"
#   filename = var.filename
#   function_name = var.function_name
#   handler       = var.handler
#   runtime       = var.runtime
#   depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]

#   tags = {
#     "lambda-console:blueprint" = "hello-world"
#     "CreatedBy" = "Ali Alaoui"
#   }

# #   logging_config {
# #     log_format = "Text"
# #     log_group  = aws_cloudwatch_log_group.lambda.name
# #   }

# }



  # filename = var.filename
  # function_name = "list_s3_buckets"
  # handler       = "lambda_handler.py"
  # runtime       = "python3.12"
  # depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]

# provider "aws" {
#  region = "eu-west-1"
# }

# module "lambda" {
#  source        = "terraform-aws-modules/lambda/aws"
#  version       = "7.8.1"
#  function_name = "hello"
#  description   = "My awesome lambda function"
#  handler       = "hello.lambda_handler"
#  runtime       = "python3.8"

#  source_path = "./hello.py"
# }