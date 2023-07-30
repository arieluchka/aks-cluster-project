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
  name     = "${var.cluster_name}-resource"
  location = var.location
}


resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${var.cluster_name}-cluster"
  location            = var.location
  resource_group_name = azurerm_resource_group.aks_resource.name
  dns_prefix          = "exampleaks1"
  # kubernetes_version = "1.18.5"
  # check if there is a way to downgrade to the version with docker runtime

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
