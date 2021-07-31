provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

# module "aks" {
#   source                           = "Azure/aks/azurerm"
#   resource_group_name              = azurerm_resource_group.aks_rg.name

#   kubernetes_version               = "1.19.11"
#   orchestrator_version             = "1.19.11"
#   prefix                           = "default"
#   cluster_name                     = "aks_cluster"
#   network_plugin                   = "azure"
#   vnet_subnet_id                   = module.network.vnet_subnets[0]
#   os_disk_size_gb                  = 50
#   sku_tier                         = "Free" # defaults to Free
#   enable_role_based_access_control = true
#   rbac_aad_admin_group_object_ids  = [data.azuread_group.aks_cluster_admins.id]
#   rbac_aad_managed                 = true
#   private_cluster_enabled          = false
#   enable_http_application_routing  = true
#   enable_azure_policy              = false
#   enable_auto_scaling              = false
#   enable_host_encryption           = false
#   agents_min_count                 = 1
#   agents_max_count                 = 3
#   agents_count                     = 1 # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
#   agents_max_pods                  = 100
#   agents_pool_name                 = "nodepool"
#   agents_type                      = "VirtualMachineScaleSets"

#   agents_labels = {
#     "nodepool" : "defaultnodepool"
#   }

#   agents_tags = {
#     "Agent" : "defaultnodepoolagent"
#   }

#   network_policy                 = "azure"
#   net_profile_dns_service_ip     = "12.0.8.10"
#   net_profile_docker_bridge_cidr = "172.17.0.1/16"
#   net_profile_service_cidr       = "12.0.8.0/21"

#   depends_on = [module.network]
# }