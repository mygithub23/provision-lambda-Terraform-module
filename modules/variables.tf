# Function name variable
variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "example_function"
}

variable "handler" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "filename" {
  type = string
}

variable "runtime" {
  type = string
}


