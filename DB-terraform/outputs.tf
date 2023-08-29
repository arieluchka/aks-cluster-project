output "az_connect_command" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.aks_resource.name} --name ${azurerm_kubernetes_cluster.aks_cluster.name}"
}
