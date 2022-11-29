config:
  vouch:
    logLevel: info
    testing: false
    domains: ["${route53_domain_name}", "${user_email_domain}"]
    headers:
      idtoken: X-Vouch-IdP-IdToken
    jwt:
      maxAge: 60
    cookie:
      maxAge: 60
      sameSite: strict
  oauth:
    auth_url: "https://${cognito_user_pool_domain}.auth.${region}.amazoncognito.com/oauth2/authorize"
    callback_url: "https://vouch.${route53_domain_name}/auth"
    client_id: "${cognito_user_pool_client_id}"
    client_secret: "${cognito_user_pool_client_secret}"
    provider: "oidc"
    scopes:
    - "openid"
    - "email"
    - "profile"
    token_url: "https://${cognito_user_pool_domain}.auth.${region}.amazoncognito.com/oauth2/token"
    user_info_url: "https://${cognito_user_pool_domain}.auth.${region}.amazoncognito.com/oauth2/userInfo"
ingress:
  enabled: true
  ingressClassName: "nginx"
  hosts:
  - "vouch.${route53_domain_name}"
  paths:
  - "/"