output "cognito_user_pool_client_id" {
  value = aws_cognito_user_pool_client.client.id
}

output "cognito_user_pool_client_secret" {
  value     = aws_cognito_user_pool_client.client.client_secret
  sensitive = true
}

output "cognito_user_pool_domain" {
  value = aws_cognito_user_pool.user_pool.domain
}

output "cognito_user_pool_endpoint" {
  value = aws_cognito_user_pool.user_pool.endpoint
}