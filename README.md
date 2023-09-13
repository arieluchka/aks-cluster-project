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

The K8S Cluster used in this project was deployed using AKS (Azure) and [**Terraform**](https://github.com/arieluchka/aks-cluster-project/blob/main/terraform%20file%20for%20cluster%20creation/main.tf).
The Cluster has Auto-Scaling capabilities and the Terraform state is saved remotely (Blob on Azure). 

The Terraform files have 




### [Back to the Project hub](https://github.com/arieluchka/DevOps-Portfolio#k8s-development-and-production-space)


> [!NOTE]
> The project is still under development and the readme files are still under construction. Feel free to contact me on 
[LinkedIn](https://www.linkedin.com/in/ariel-agranovich-990629264 "my linkedin porfile :)")
 for any question :) 


