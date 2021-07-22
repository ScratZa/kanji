terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

module "kanji-aks-rg-label" {
  source = "cloudposse/label/terraform"

  namespace  = "kanji"
  stage      = "dev"
  name       = "aks"
  attributes = ["rg"]
  delimiter  = "-"

  tags = {
    "Application" = "Kanji",
    "TearDown"     = "true"
  }
}
module "kanji-aks-vnet-label" {
  source = "cloudposse/label/terraform"

  namespace  = "kanji"
  stage      = "dev"
  name       = "aks"
  attributes = ["vnet"]
  delimiter  = "-"

  tags = {
    "Application" = "Kanji",
    "TearDown"     = "true"
  }
}

module "kanji-aks-snet-pods-label" {
  source = "cloudposse/label/terraform"

  namespace  = "kanji"
  stage      = "dev"
  name       = "aks"
  attributes = ["snet", "pods"]
  delimiter  = "-"

  tags = {
    "Application" = "Kanji",
    "TearDown"     = "true"
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "aks_rg" {
  name = module.kanji-aks-rg-label.id
  location = var.location
}

module "network" {
  source              = "Azure/network/azurerm"
  vnet_name           = module.kanji-aks-vnet-label.id
  resource_group_name = azurerm_resource_group.aks_rg.name
  address_space       = "12.0.0.0/16"
  subnet_prefixes     = ["12.0.0.0/21"]
  subnet_names        = [module.kanji-aks-snet-pods-label.id]
  depends_on          = [azurerm_resource_group.aks_rg]
}

data "azuread_group" "aks_cluster_admins" {
  display_name = "AKS-cluster-admins"
}

module "aks" {
  source                           = "Azure/aks/azurerm"
  resource_group_name              = azurerm_resource_group.aks_rg.name

  kubernetes_version               = "1.19.11"
  orchestrator_version             = "1.19.11"
  prefix                           = "kanji"
  cluster_name                     = "aks_cluster"
  network_plugin                   = "azure"
  vnet_subnet_id                   = module.network.vnet_subnets[0]
  os_disk_size_gb                  = 50
  sku_tier                         = "Free" # defaults to Free
  enable_role_based_access_control = true
  rbac_aad_admin_group_object_ids  = [data.azuread_group.aks_cluster_admins.id]
  rbac_aad_managed                 = true
  private_cluster_enabled          = false
  enable_http_application_routing  = true
  enable_azure_policy              = false
  enable_auto_scaling              = false
  enable_host_encryption           = false
  agents_min_count                 = 1
  agents_max_count                 = 2
  agents_count                     = 1 # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
  agents_max_pods                  = 100
  agents_pool_name                 = "nodepool"
  agents_type                      = "VirtualMachineScaleSets"

  agents_labels = {
    "nodepool" : "defaultnodepool"
  }

  agents_tags = {
    "Agent" : "defaultnodepoolagent"
  }

  network_policy                 = "azure"
  net_profile_dns_service_ip     = "12.0.8.10"
  net_profile_docker_bridge_cidr = "172.17.0.1/16"
  net_profile_service_cidr       = "12.0.8.0/21"

  depends_on = [module.network]
}