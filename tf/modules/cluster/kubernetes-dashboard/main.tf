resource "kubernetes_namespace" "kubernetes_dashboard" {
  metadata {
    name = "kubernetes-dashboard"
  }
}

resource "helm_release" "kubernetes_dashboard" {
  chart      = "kubernetes-dashboard"
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard"
  namespace  = "kubernetes-dashboard"
  version    = "6.0.0"
}


resource "kubernetes_ingress_v1" "kubernetes_dashboard" {
  metadata {
    name      = "kubernetes-dashboard"
    namespace = "kubernetes-dashboard"
    annotations = {
      "kubernetes.io/ingress.class"                       = "nginx"
      "nginx.ingress.kubernetes.io/backend-protocol"      = "HTTPS"
      "nginx.ingress.kubernetes.io/auth-signin"           = "https://vouch.${var.route53_domain_name}/login?url=https://$http_host$request_uri&vouch-failcount=$auth_resp_failcount&X-Vouch-Idp-Idtoken=$auth_resp_jwt&error=$auth_resp_err"
      "nginx.ingress.kubernetes.io/auth-snippet"          = <<EOF
          auth_request_set $auth_resp_jwt $upstream_http_x_vouch_jwt;
          auth_request_set $auth_resp_err $upstream_http_x_vouch_err;
          auth_request_set $auth_resp_failcount $upstream_http_x_vouch_failcount;
          EOF
      "nginx.ingress.kubernetes.io/auth-url"              = "https://vouch.${var.route53_domain_name}/validate"
      "nginx.ingress.kubernetes.io/configuration-snippet" = <<EOF
          auth_request_set $auth_resp_x_vouch_idp_idtoken $upstream_http_x_vouch_idp_idtoken;
          proxy_set_header Authorization "Bearer $auth_resp_x_vouch_idp_idtoken";
          EOF
    }
  }
  spec {
    rule {
      host = "k8sdashboard.${var.route53_domain_name}"
      http {
        path {
          backend {
            service {
              name = "kubernetes-dashboard"
              port {
                number = 443
              }
            }
          }
          path      = "/"
          path_type = "Prefix"
        }
      }
    }
  }

  depends_on = [helm_release.kubernetes_dashboard]
}