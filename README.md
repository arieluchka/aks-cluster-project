# AKS and PostgreSQL (on a vm) deployment to Azure using Terraform, Internal Cluster setup with helm (This Repo Is Part of My [DevOps Project](https://github.com/arieluchka/DevOps-Portfolio#k8s-development-and-production-space))


> No AI tool was used during the work on these Porjects.

<!-- ## Python application, pipelines and image building -->
## Introduction 
This repo contains all necessary files to create a K8S cluster with all the tools pre-built and configured. 

All the Helm Charts contain custom configuration for "out of the box" automatic tool deployment for this specific [app project](https://github.com/arieluchka/aks-cluster-project-app/tree/main#python-application-pipelines-and-image-building-this-repo-is-part-of-my-devops-project).
> It is planned to make this deployment modular so it can be reused in other projects, as a dev environment.

The Idea to make it pre-configured came from the need of re-building the cluster every morning. The budget for this project was limited so the destruction of the workspace at the end of the day was necessary. 

Automating the creation and configuration of the infrastructure saved an enormous amount of time.

## Features
###  Cluster deployment using Terraform 

The [**K8S Cluster**](https://github.com/arieluchka/aks-cluster-project/blob/main/terraform%20file%20for%20cluster%20creation/main.tf) used in this project was deployed using AKS (Azure) and Terraform.
The Cluster has Auto-Scaling capabilities and the Terraform state is saved remotely (Blob on Azure). 

The Terraform files are configured in a way that if a new deployment is needed for testing a new infrastructure feature, the cluster will be created with one node only (cost savings + efficacy).

`node_count = terraform.workspace == "default" ? 2 : 1`

Currently, the cluster is configured through custom [Helm Charts](https://github.com/arieluchka/aks-cluster-project/tree/main/helm-charts) that are also deployed with Terraform. 

> Future plans are to switch to bootstrapping the cluster with ArgoCD. Terraform will deploy ArgoCD to the cluster and Argo will deploy everything else.

### 🚧 Database deployment using Terraform

The [**Database (PostgreSQL)**](https://github.com/arieluchka/aks-cluster-project/tree/main/DB-terraform) is created in a VM, which is deployed using Terraform. 

The configuration itself is done with a VM extension resource, that runs a [**script**](https://github.com/arieluchka/aks-cluster-project/blob/main/DB-terraform/testscript.sh) to download, install and configure PostgreSQL.

The decision to go with `azurerm_virtual_machine_extension` and not a provisioner, was made with the primary focus on enhancing security. To run the script in the VM, only the VM ID is required (capitalizing on Azure's inherent security features), which is far more secure than the Provisioner dependencies, such as IP, username and password/ssh key, thereby introducing potentially more security vulnerabilities.


> 🚧 The database is still in its **very** early stages. It is planned to be more secure with strict NSG rules, more resilient with cloning the database and more redundant using HA methods.

### Cluster configuration with Helm Charts
> todo

> add workspace config to num of nodes. add remote state config terraform.workspace. 

### [Back to the Project hub](https://github.com/arieluchka/DevOps-Portfolio#k8s-development-and-production-space)


> [!NOTE]
> The project is still under development and the readme files are still under construction. Feel free to contact me on 
[LinkedIn](https://www.linkedin.com/in/ariel-agranovich-990629264 "my linkedin porfile :)")
 for any question :) 


