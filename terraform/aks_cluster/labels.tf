module "default_aks_cluster_label" {
  source   = "cloudposse/label/null"

  namespace  = var.namespace
  stage      = var.environment
  name       = "aks"
  attributes = ["clstr"]
  delimiter  = "-"

  tags = {
    "APPLICATION" = upper(var.namespace)
    "TEARDOWN"    = "TRUE"
  }
}
module "default_aks_default_nodepool_label" {
  source   = "cloudposse/label/null"
//max limit of 12 chars for node pools and no delimites
  namespace  = "default"
  stage      = "ndpl"
  delimiter  = ""
  id_length_limit = "12"

  tags = {
    "APPLICATION" = upper(var.namespace)
    "TEARDOWN"    = "TRUE"
  }
}