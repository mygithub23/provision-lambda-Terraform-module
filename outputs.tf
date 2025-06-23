# output "lambda_function_arn" {
#  value =  lambda_function.filename.arn
# }

output "role_name" {
  description = "function name"
  value = module.lambda_function.lambda_role_name
}

output "function_name" {
  description = "value"
  value = module.lambda_function.lambda_function_name
}

output "role_arn" {
  description = "value"
  value = module.lambda_function.lambda_role_arn
}

output "role_unique_id" {
  description = "value"
  value = module.lambda_function.lambda_role_unique_id
}

output "function_arn" {
  description = "value"
  value = module.lambda_function.lambda_function_arn
}