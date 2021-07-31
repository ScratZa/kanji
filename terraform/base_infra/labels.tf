module "default-aks-rg-label" {
  source = "cloudposse/label/terraform"

  namespace  = var.namespace
  stage      = var.environment
  name       = "aks"
  attributes = ["rg"]
  delimiter  = "-"

  tags = {
    "APPLICATION" = upper(var.namespace)
    "TEARDOWN"    = "TRUE"
  }
}
module "default-aks-vnet-label" {
  source = "cloudposse/label/terraform"

  namespace  = var.namespace
  stage      = var.environment
  name       = "aks"
  attributes = ["vnet"]
  delimiter  = "-"

  tags = {
    "APPLICATION" = upper(var.namespace)
    "TEARDOWN"    = "TRUE"
  }
}

module "default-aks-snet-pods-label" {
  source = "cloudposse/label/terraform"

  namespace  = var.namespace
  stage      = var.environment
  name       = "aks"
  attributes = ["snet", "pods"]
  delimiter  = "-"

  tags = {
    "APPLICATION" = upper(var.namespace)
    "TEARDOWN"    = "TRUE"
  }
}