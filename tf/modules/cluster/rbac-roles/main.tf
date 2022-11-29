resource "kubernetes_cluster_role" "admin_role" {
  metadata {
    name = "admin-role"
    annotations = {
      "rbac.authorization.kubernetes.io/autoupdate" = "true"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "admin_role_binding" {
  metadata {
    name = "admin-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "admin-role"
  }
  subject {
    kind      = "Group"
    name      = "gid:admins"
    api_group = "rbac.authorization.k8s.io"
  }
}