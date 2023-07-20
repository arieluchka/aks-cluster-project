terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_resource" {
  name     = "aks_resource"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "aks_test" {
  name                = "aks_test"
  location            = azurerm_resource_group.aks_resource.location
  resource_group_name = azurerm_resource_group.aks_resource.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    enable_auto_scaling = true
    node_count = 2
    min_count = 2
    max_count = 5
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "client_certificate" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks_test.kube_config.0.client_certificate)
}

output "kube_config" {
  value = nonsensitive(azurerm_kubernetes_cluster.aks_test.kube_config_raw)
}