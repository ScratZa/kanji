locals {
  load_balancer_sku   = var.aks_default_node_pool_azs != null ? "Standard" : "Basic"
  enable_auto_scaling = var.aks_default_node_pool_node_type == "VirtualMachineScaleSets" || var.aks_default_node_pool_node_type == null ? true : false
  tags = {
    "CLUSTER"     = module.default_aks_cluster_label.id
    "APPLICATION" = upper(var.namespace)
    "TEARDOWN"    = "TRUE"
  }
  admin_group_id    = var.ad_admin_group_id != null ? var.ad_admin_group_id : data.azuread_group.aks_cluster_admins[0].id
}

data "azuread_group" "aks_cluster_admins" {
  count = (var.ad_admin_group_id == null) && (var.ad_admin_group_name != null) ? 1 : 0
  display_name = var.ad_admin_group_name
}