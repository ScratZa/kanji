
resource "azurerm_resource_group" "aks_rg" {
  count    = local.create_resource_group == 1 ? 1 : 0
  name     = module.default-aks-rg-label.id
  location = var.location
  tags = {
    "APPLICATION" = upper(var.namespace)
    "TEARDOWN"    = "TRUE"
  }
}

data "azurerm_resource_group" "example" {
  count = local.create_resource_group == 1 ? 0 : 1
  name  = var.provided_resource_group_name
}