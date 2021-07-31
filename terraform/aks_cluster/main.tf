

resource "azurerm_kubernetes_cluster" "default_auto_scale" {
  name                = module.default_aks_cluster_label.id
  resource_group_name = var.aks_resource_group_name
  dns_prefix = var.namespace
  location = var.location


  network_profile {
      load_balancer_sku  = "standard"
      network_plugin     = "azure"
      network_policy     = "azure"
      outbound_type      = "loadBalancer"
      dns_service_ip     = "10.0.0.10"
      docker_bridge_cidr = "172.17.0.1/16"
      service_cidr       = "10.0.0.0/16"
    }

  dynamic "default_node_pool"{
    for_each = local.enable_auto_scaling == true ? ["autoscaled"] : []
      content {
        name                   = module.default_aks_default_nodepool_label.id
        node_count             = var.aks_default_node_pool_count
        vm_size                = var.aks_default_node_pool_vm_size
        availability_zones     = var.aks_default_node_pool_azs
        enable_auto_scaling    = local.enable_auto_scaling
        max_count              = var.aks_default_node_pool_max_node_count
        min_count              = var.aks_default_node_pool_min_node_count
        enable_host_encryption = var.aks_default_node_pool_enable_node_encryption
        enable_node_public_ip  = var.aks_default_node_pool_enable_node_public_ip
        max_pods               = var.aks_default_node_pool_max_pods
        orchestrator_version   = var.aks_kubernetes_version
        vnet_subnet_id         = var.aks_default_node_pool_subnet_id
        tags = merge(local.tags, { "NODEPOOL" = module.default_aks_default_nodepool_label.id })
      }
  }

  dynamic "default_node_pool"{
    for_each = local.enable_auto_scaling == true ? [] : ["manual"]
      content {
        name                   = module.default_aks_default_nodepool_label.id
        node_count             = var.aks_default_node_pool_count
        vm_size                = var.aks_default_node_pool_vm_size
        availability_zones     = var.aks_default_node_pool_azs
        enable_auto_scaling    = local.enable_auto_scaling
        max_count              = null
        min_count              = null
        enable_host_encryption = var.aks_default_node_pool_enable_node_encryption
        enable_node_public_ip  = var.aks_default_node_pool_enable_node_public_ip
        max_pods               = var.aks_default_node_pool_max_pods
        orchestrator_version   = var.aks_kubernetes_version
        vnet_subnet_id         = var.aks_default_node_pool_subnet_id
        tags = merge(local.tags, { "NODEPOOL" = module.default_aks_default_nodepool_label.id })
      }
  }


  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }
  private_cluster_enabled  = var.aks_private_cluster
  # private_dns_zone_id = var.aks_private_dns_zone_id
  api_server_authorized_ip_ranges = var.aks_private_cluster ? []: var.aks_authorized_management_ip_range
  kubernetes_version = var.aks_kubernetes_version
  identity {
    type = "SystemAssigned"
  }

  //default values for autoscaler profile - they are here incase changes need to be made
  // nothing fancy - heres the details https://docs.microsoft.com/en-us/azure/aks/cluster-autoscaler
  
  auto_scaler_profile{
    expander ="random"
    max_graceful_termination_sec = 600
    max_node_provisioning_time = "15m"
    max_unready_nodes = 3
    max_unready_percentage = 45
    new_pod_scale_up_delay = "0s"
    scale_down_delay_after_add="10m"
    scale_down_delay_after_failure = "3m"
   scan_interval = "10s"
    scale_down_unneeded ="10m"
    scale_down_unready = "10m"
    scale_down_utilization_threshold = 0.5
    empty_bulk_delete_max = 10
    skip_nodes_with_local_storage = true
    skip_nodes_with_system_pods = true
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      managed = true
      admin_group_object_ids = [
        local.admin_group_id
      ]
    }
  # addon_profile{
  #   //azure policy is not included for nows
  #   http_application_routing {
      
  #   }

  #   kube_dashboard {
      
  #   }
    
  #   oms_agent {
      
  #   }

  #   ingress_application_gateway {

  #   }
  # }

}
}
