resource "kubernetes_namespace" "vouch" {
  metadata {
    name = "vouch"
  }
}

resource "helm_release" "vouch" {
  chart      = "vouch"
  name       = "vouch"
  repository = "https://vouch.github.io/helm-charts"
  namespace  = "vouch"
  version    = "3.1.0"

  values = [
    templatefile("${path.module}/templates/vouch-values.tpl", {
      replicas                        = 1
      region                          = var.region
      cognito_user_pool_client_id     = var.cognito_user_pool_client_id
      cognito_user_pool_client_secret = var.cognito_user_pool_client_secret
      cognito_user_pool_domain        = var.cognito_user_pool_domain
      route53_domain_name             = var.route53_domain_name
      user_email_domain               = var.user_email_domain
    })
  ]
}