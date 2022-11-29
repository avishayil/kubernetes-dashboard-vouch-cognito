resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "ingress_nginx" {
  chart      = "ingress-nginx"
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  namespace  = "ingress-nginx"
  version    = "4.4.0"

  depends_on = [kubernetes_namespace.ingress_nginx]
}

resource "null_resource" "wait_for_ingress_nginx" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for the nginx ingress controller...\n"
      aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name} --alias ${var.cluster_name}
      kubectl wait --namespace ${helm_release.ingress_nginx.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=controller \
        --timeout=90s \
        --context ${var.cluster_name}
    EOF
  }

  depends_on = [helm_release.ingress_nginx]
}

resource "kubernetes_ingress_v1" "alb_ingress" {
  metadata {
    name      = "alb-ingress"
    namespace = "ingress-nginx"
    annotations = {
      "kubernetes.io/ingress.class"                = "alb"
      "alb.ingress.kubernetes.io/scheme"           = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"      = "ip"
      "alb.ingress.kubernetes.io/certificate-arn"  = var.route53_domain_certificate_arn
      "alb.ingress.kubernetes.io/listen-ports"     = "[{\"HTTP\": 80}, {\"HTTPS\":443}]"
      "alb.ingress.kubernetes.io/healthcheck-path" = "/healthz"
      "alb.ingress.kubernetes.io/inbound-cidrs"    = "${chomp(data.http.myipaddress.response_body)}/32,${var.vpc_nat_eip}/32"
    }
  }
  spec {
    rule {
      http {
        path {
          backend {
            service {
              name = "ingress-nginx-controller"
              port {
                number = 80
              }
            }
          }
          path = "/*"
        }
      }
    }
  }

  depends_on = [helm_release.ingress_nginx]
}

resource "null_resource" "wait_for_alb_ingress" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for the nginx ingress controller...\n"
      aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name} --alias ${var.cluster_name}
      loadbalancer_dns_hostname="";
      while [ -z $loadbalancer_dns_hostname ]; do
        echo "Waiting for end point...";
        loadbalancer_dns_hostname=$(kubectl get ingress -n ${helm_release.ingress_nginx.namespace} alb-ingress --template="{{range .status.loadBalancer.ingress}}{{.hostname}}{{end}}");
        [ -z "$loadbalancer_dns_hostname" ] && sleep 10;
      done;
      echo "End point ready-" && echo $loadbalancer_dns_hostname;
    EOF
  }

  depends_on = [helm_release.ingress_nginx, kubernetes_ingress_v1.alb_ingress]
}