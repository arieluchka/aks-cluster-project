output "client_certificate" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)
}

output "kube_config" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks_cluster.kube_config_raw)
}

output "az_connect_command" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.aks_resource.name} --name ${azurerm_kubernetes_cluster.aks_cluster.name}"
}