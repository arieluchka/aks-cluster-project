variable "location" {
  type = string
  default = "westeurope"
}

variable "cluster_name" {
  type = string
  default = "helm-aks-project"
}

variable "k8s_config_path" {
  type = string
  default = "C:/Users/Study Space/.kube/config"
}

variable "helm_path" {
  type = string
  default = "C:/Users/Study Space/Desktop/DevOps course/aks-cluster-project/infrastructure deployment/helm-charts"
}