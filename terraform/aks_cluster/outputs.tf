output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.default_auto_scale.id
}
output "aks_cluster_fqdn" {
  value = azurerm_kubernetes_cluster.default_auto_scale.fqdn
}
output "aks_cluster_private_fqdn" {
  value = azurerm_kubernetes_cluster.default_auto_scale.private_fqdn
}
output "aks_cluster_identity" {
  value = azurerm_kubernetes_cluster.default_auto_scale.identity
}

output "aks_cluster_kube_config_admin" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.default_auto_scale.kube_admin_config
}

output "aks_cluster_kube_config" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.default_auto_scale.kube_config
}