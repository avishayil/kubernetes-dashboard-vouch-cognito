variable "project_name" {
  description = "Name to be used on all the resources as identifier. e.g. Project name, Application name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "Vpc ID"
  type        = string
}

variable "vpc_private_subnet_ids" {
  description = "Private subnet ids"
  type        = list(string)
}

variable "cognito_user_pool_client_id" {
  description = "Cognito user pool client ID"
  type        = string
}

variable "cognito_user_pool_endpoint" {
  description = "Cognito user pool endpoint"
  type        = string
}