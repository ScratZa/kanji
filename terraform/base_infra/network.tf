
data "azurerm_virtual_network" "vnet" {
  count               = local.create_network == 1 ? 0 : 1
  name                = var.vpc_provided_name
  resource_group_name = var.vpc_provided_resource_group_name
}


module "network" {
  count               = local.create_network == 1 ? 1 : 0
  source              = "Azure/network/azurerm"
  vnet_name           = module.default-aks-vnet-label.id
  resource_group_name = local.resource_group_name
  address_space       = var.vpc_address_space
  subnet_prefixes     = var.vpc_subnet_prefixes
  subnet_names        = [module.default-aks-snet-pods-label.id]
  depends_on          = [azurerm_resource_group.aks_rg]
}