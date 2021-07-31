provider "azurerm" {
  features {}
}

module "base_infrastructure" {
  source = "./base_infra"

  location    = "southafricanorth"
  namespace   = "test"
  environment = "sbox"
}

module "base_aks" {
  source      = "./aks_cluster"
  location    = "southafricanorth"
  namespace   = "test"
  environment = "sbox"

  aks_resource_group_name = module.base_infrastructure.resource_group
  aks_default_node_pool_subnet_id = module.base_infrastructure.vpc_subnet_aks
  ad_admin_group_name = "AKS-cluster-admins"
}