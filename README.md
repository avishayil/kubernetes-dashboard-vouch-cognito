# Kubernetes Dashboard with Vouch Proxy to Cognito OAuth

# Description

Respository with example deploying Kubenretes cluster, with the Kubernetes Dashboard protected behind Cognito User Pool

# Usage

Populate the terraform variables with the correct info:
```
$ cp tf/environments/dev/terraform.tfvars.example tf/environments/dev/terraform.tfvars
# tf/environments/dev/terraform.tfvars

region                         = "${AWS_REGION}" # e.g us-east-1
project_name                   = "${PROJECT_NAME}" # e.g my-cluster
user_email_domain              = "${USER_EMAIL_DOMAIN}" # e.g yourcompany.com
route53_domain_name            = "${ROUTE53_DOMAIN_NAME}" # e.g yourcompany-dev.com
route53_hosted_zone_id         = "${ROUTE53_HOSTED_ZONE_ID}" # e.g A839917212RPTJDHFNBVF
route53_domain_certificate_arn = "${ROUTE53_DOMAIN_CERTIFICATE_ARN}" # certificate arn for *.yourcompany-dev.com
```

Deploying temporary review environment using Terraform workspaces:

```
$ tfenv install
$ tfenv use
$ cd tf/environments/dev
$ terraform init
$ terraform workspace new test-tf-workspace
$ terraform apply
$ terraform destroy
$ terraform workspace select default
$ terraform workspace delete test-tf-workspace
```

