locals {
  create_network        = var.vpc_provided_name == null ? 1 : 0
  create_resource_group = var.provided_resource_group_name == null ? 1 : 0
  resource_group_name   = var.provided_resource_group_name == null ? azurerm_resource_group.aks_rg[0].name  : var.provided_resource_group_name
}
