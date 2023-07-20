output "client_certificate" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks_test.kube_config.0.client_certificate)
}

output "kube_config" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks_test.kube_config_raw)
}