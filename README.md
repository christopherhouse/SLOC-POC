# SLOC-POC Repository

This repository contains the source code and infrastructure as code (IaC) configurations for a proof of concept (POC) project. It leverages Azure resources and Bicep templates for infrastructure deployment, aiming to provide a scalable and manageable cloud environment.

## 📂 Repository Structure

```
📦sloc-poc
 ┣ 📂infrastructure
 ┃ ┣ 📂bicep
 ┃ ┃ ┣ 📜main.bicep
 ┃ ┃ ┣ 📂modules
 ┃ ┃ ┃ ┣ 📂appService
 ┃ ┃ ┃ ┣ 📂azureMonitor
 ┃ ┃ ┃ ┣ 📂keyVault
 ┃ ┃ ┃ ┣ 📂managedIdentity
 ┃ ┃ ┃ ┣ 📂relay
 ┃ ┃ ┃ ┣ 📂serviceBus
 ┃ ┃ ┃ ┣ 📂storage     
 ┃ ┃ ┃ ┗ 📂userDefined
 ┃ ┃ ┗ 📂parameters
 ┃ ┃ ┃ ┗ 📜main.<environmentName>.bicepparam
 ┃ ┗ 📂scripts
 ┃ ┃ ┗ 📜Deploy-Main.ps1
 ┣ 📂pipelines
 ┃ ┣  📂templates
 ┗ ┗  📜build-and-deploy-integration-environment.yaml
```

## 🚀 Azure Resources Deployed

The Bicep templates in this repository are designed to deploy and configure the following Azure resources:

- **Application Insights**: Monitors the live applications, automatically detecting performance anomalies.
- **Service Bus Namespace**: Provides messaging services between applications and services.
- **Relay Namespace**: Enables hosting of hybrid connections that support bi-directional communication between Azure services and on-premises services.
- **Hybrid Connections**: Facilitates secure and seamless connectivity between resources in Azure and on-premises networks.
- **User-assigned Managed Identity**: Allows Azure resources to authenticate to cloud services securely.
- **Key Vault**: Manages and protects cryptographic keys and other secrets used by cloud apps and services.
- **Log Analytics Workspace**: Provides a single workspace for monitoring Azure resources.
- **Function Apps**: Enables the execution of serverless functions, which can respond to events and triggers.
- **Storage Accounts**: Provides scalable cloud storage for data, apps, and workloads.

## 📜 Bicep Templates Overview

- **[`main.bicep`](/infrastructure/bicep/main.bicep)**: The primary template that orchestrates the deployment of all resources. It references modules for specific resources like Application Insights, Key Vault, and Log Analytics Workspace.
- **Modules**: Located under [`infrastructure/bicep/modules`](/infrastructure/bicep/modules), these Bicep files define the deployment of specific Azure resources. They are parameterized to allow customization based on the deployment environment.

## 🛠 Deployment Scripts

- **[`Deploy-Main.ps1`](command:_github.copilot.openRelativePath?%5B%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2Fc%3A%2FProjects%2Fsloc-poc%2Finfrastructure%2Fscripts%2FDeploy-Main.ps1%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%5D "c:\Projects\sloc-poc\infrastructure\scripts\Deploy-Main.ps1")**: A PowerShell script that facilitates the deployment of the [`main.bicep`](command:_github.copilot.openRelativePath?%5B%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2FC%3A%2FProjects%2Fsloc-poc%2Finfrastructure%2Fbicep%2Fmain.bicep%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%5D "c:\Projects\sloc-poc\infrastructure\bicep\main.bicep") template to Azure. It accepts parameters for environment name and resource group name.

## 🔄 CI/CD Pipelines

- **[`deploy.yaml`](command:_github.copilot.openRelativePath?%5B%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2Fc%3A%2FProjects%2Fsloc-poc%2Fpipelines%2Ftemplates%2Fdeploy.yaml%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%5D "c:\Projects\sloc-poc\pipelines\templates\deploy.yaml")**: A YAML pipeline template for Azure DevOps that automates the deployment of the Bicep templates. It includes stages for downloading artifacts, deploying the main Bicep template, and specifying deployment parameters based on the environment.

This repository is structured to support multiple environments and scalable deployments, leveraging Azure's cloud capabilities for a robust and efficient infrastructure setup.