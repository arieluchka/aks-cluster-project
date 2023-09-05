terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "kubernetes" {
    host = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].host
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)
    token = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.password
}

provider "helm" {
  kubernetes {
    host = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].host
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)
    token = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.password
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

resource "helm_release" "namespaces" {
  name = "namespaces"
  chart = "${var.helm_path}/namespaces"
  depends_on = [ azurerm_kubernetes_cluster.aks_cluster ]
}

resource "helm_release" "jenkins" {
  name = "jenkins"
  chart = "${var.helm_path}/my-jenkins"
  depends_on = [ helm_release.namespaces ]
}

resource "helm_release" "argocd" {
  depends_on = [ helm_release.namespaces ]
  name = "argocd"
  chart = "${var.helm_path}/my-argocd"
  namespace = "argocd"
}

