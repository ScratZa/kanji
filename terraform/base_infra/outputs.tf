output "vpc_id" {
  value = local.create_network == 1 ? module.network[0].vnet_id : data.azurerm_virtual_network.vnet[0].id
}

output "vpc_name" {
  value = local.create_network == 1 ? module.network[0].vnet_name : data.azurerm_virtual_network.vnet[0].name
}

output "vpc_subnets" {
  value = local.create_network == 1 ? module.network[0].vnet_subnets : data.azurerm_virtual_network.vnet[0].subnets
}

output "vpc_subnet_aks"{
  value = local.create_network == 1 ? module.network[0].vnet_subnets[0]: data.azurerm_virtual_network.vnet[0].subnets[0]
}

output "resource_group"{
  value = local.resource_group_name
}