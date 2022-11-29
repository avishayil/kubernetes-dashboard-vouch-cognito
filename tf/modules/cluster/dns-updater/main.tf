resource "null_resource" "configure_route53" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name} --alias ${var.cluster_name}
      lb_hostname=$(kubectl get ingress -n ingress-nginx alb-ingress --template="{{range .status.loadBalancer.ingress}}{{.hostname}}{{end}}")
      change_batch="{\"Changes\":[{\"Action\":\"UPSERT\",\"ResourceRecordSet\":{\"Name\":\"vouch.${var.route53_domain_name}\",\"Type\":\"CNAME\",\"TTL\":60,\"ResourceRecords\":[{\"Value\":\"$lb_hostname\"}]}},{\"Action\":\"UPSERT\",\"ResourceRecordSet\":{\"Name\":\"k8sdashboard.${var.route53_domain_name}\",\"Type\":\"CNAME\",\"TTL\":60,\"ResourceRecords\":[{\"Value\":\"$lb_hostname\"}]}}]}"
      aws route53 change-resource-record-sets --hosted-zone-id ${var.route53_hosted_zone_id} --change-batch $change_batch
    EOF
  }
}