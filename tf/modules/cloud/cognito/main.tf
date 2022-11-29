resource "aws_cognito_user_pool" "user_pool" {
  name = "${var.project_name}-user-pool-${var.env}"

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
  password_policy {
    minimum_length = 12
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Account Confirmation"
    email_message        = "Your confirmation code is {####}"
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name = "${var.project_name}-vouch-client-${var.env}"

  user_pool_id                  = aws_cognito_user_pool.user_pool.id
  generate_secret               = true
  refresh_token_validity        = 90
  prevent_user_existence_errors = "ENABLED"
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  supported_identity_providers         = ["COGNITO"]
  callback_urls                        = ["https://vouch.${var.route53_domain_name}/auth"]
  logout_urls                          = ["https://vouch.${var.route53_domain_name}/logout"]
}

resource "aws_cognito_user_pool_domain" "cognito-domain" {
  domain       = "${lower(var.project_name)}-auth-${var.env}"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}


resource "aws_cognito_user_group" "admins" {
  name         = "admins"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  description  = "Kubernetes administrators"
  precedence   = 1
}