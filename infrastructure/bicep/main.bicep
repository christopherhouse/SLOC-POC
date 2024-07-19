import * as udt from './modules/userDefined/userDefinedTypes.bicep'

@description('The name of the workload being deployed, combined with the environment suffix and resource type abbreviation to create the resource name.')
param workloadName string

@description('The environment suffix to be appended to the workload name to create the resource name.')
param environmentSuffix string

@description('The Azure region where resources will be deployed')
param location string

@description('The tags to apply to all resources')
param tags object

@description('The retention period in days for Log Analytics data')
param logAnalyticsRetentionInDays int

@description('Whether to enable purge protection on the Key Vault')
param enableKeyVaultPurgeProtection bool

@description('The SKU of the Service Bus namespace')
param serviceBusSku udt.serviceBusSkuType

@description('The name that will be concatenated with workloadName and environmentSuffix to create the hybrid connection name.')
param hybridConnectionName string

@description('The endpoint (hostname:port #) of the hybrid connection destination.')
param hybridConnectionDestinationEndpoint string

@description('The number of instances to create for the App Service Plan for Function apps')
param functionAppServicePlanInstanceCount int

@description('The SKU of the App Service Plan for Function apps')
param functionAppServicePlanSku udt.appServicePlanSkuType

@description('The storage account type for the Function Apps')
param functionAppStorageType udt.storageAccountType

@description('The name of the core SRQ Function App')
param coreSrqFunctionAppName string

@description('The name of the external SRQ Function App')
param extSrqFunctionAppName string

@description('The name of the Business Rules Engine Function App')
param businessRulesEngineFunctionName string

var baseName = '${workloadName}-${environmentSuffix}'

// Log Analytics Workspace
var logAnalyticsWorkspaceName = '${baseName}-laws'
var logAnalyticsWorkspaceDeploymentName = '${logAnalyticsWorkspaceName}-${deployment().name}'

// Key Vault
var keyVaultName = '${baseName}-kv'
var keyVaultDeploymentName = '${keyVaultName}-${deployment().name}'

// Application Insights
var appInsightsName = '${baseName}-ai'
var appInsightsDeploymentName = '${appInsightsName}-${deployment().name}'

// Service Bus Namespace
var serviceBusNamespaceName = '${baseName}-sbns'
var serviceBusNamespaceDeploymentName = '${serviceBusNamespaceName}-${deployment().name}'

// Relay Namespace
var relayNamespaceName = '${baseName}-rns'
var relayNamespaceDeploymentName = '${relayNamespaceName}-${deployment().name}'

var hyConnectionName = '${baseName}-${hybridConnectionName}-hc'
var hyConnectionDeploymentName = '${hyConnectionName}-${deployment().name}'

// User-assigned managed identity
var userAssignedManagedIdentityName = '${baseName}-uami'
var userAssignedManagedIdentityDeploymentName = '${userAssignedManagedIdentityName}-${deployment().name}'
var uamiKvSecretsUserDeploymentName = '${userAssignedManagedIdentityName}-kv-secrets-${deployment().name}'
// Functions
var appServicePlanName = '${baseName}-asp'
var appServicePlanDeploymentName = '${appServicePlanName}-${deployment().name}'

var coreSrqAppName = '${baseName}-${coreSrqFunctionAppName}-func'
var coreSrqFunctionAppDeploymentName = '${coreSrqAppName}-${deployment().name}'

module laws './modules/azureMonitor/logAnalyticsWorkspace.bicep' = {
  name: logAnalyticsWorkspaceDeploymentName
  params: {
    location: location
    tags: tags
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
    retentionInDays: logAnalyticsRetentionInDays
  }
}

module keyVault './modules/keyVault/keyVault.bicep' = {
  name: keyVaultDeploymentName
  params: {
    location: location
    keyVaultName: keyVaultName
    logAnalyticsWorkspaceResourceId: laws.outputs.id
    tags: tags
    enablePurgeProtection: enableKeyVaultPurgeProtection
  }
}

module appInsights './modules/azureMonitor/applicationInsights.bicep' = {
  name: appInsightsDeploymentName
  params: {
    appInsightsName: appInsightsName
    location: location
    logAnalyticsWorkspaceId: laws.outputs.id
    keyVaultName: keyVaultName
    buildId: deployment().name
    tags: tags
  }
}

module sbns './modules/serviceBus/serviceBusNamespace.bicep' = {
  name: serviceBusNamespaceDeploymentName
  params: {
    serviceBusNamespaceName: serviceBusNamespaceName
    location: location
    serviceBusNamespaceSku: serviceBusSku
    logAnalyticsWorkspaceResourceId: laws.outputs.id
    tags: tags
  }
}

module rns './modules/relay/relayNamespace.bicep' = {
  name: relayNamespaceDeploymentName
  params: {
    location: location
    relayNamespaceName: relayNamespaceName
    logAnalyticsWorkspaceResourceId: laws.outputs.id
  }
}

module hc './modules/relay/hybridConnection.bicep' = {
  name: hyConnectionDeploymentName
  params: {
    hybridConnectionDestinationEndpoint: hybridConnectionDestinationEndpoint
    hybridConnectionName: hyConnectionName
    relayNamespaceName: rns.outputs.name
  }
}

module uami './modules/managedIdentity/userAssignedManagedIdentity.bicep' = {
  name: userAssignedManagedIdentityDeploymentName
  params: {
    location: location
    managedIdentityName: userAssignedManagedIdentityName
  }
}

module kvRbac './modules/keyVault/keyVaultSecretReader.bicep' = {
  name: uamiKvSecretsUserDeploymentName
  params: {
    keyVaultName: keyVaultName
    principalId: uami.outputs.principalId
  }
}

module asp './modules/appService/appServicePlan.bicep' = {
  name: appServicePlanDeploymentName
  params: {
    appServicePlanName: appServicePlanName
    location: location
    sku: functionAppServicePlanSku
    instanceCount: functionAppServicePlanInstanceCount
    tags: tags
  }
}

module coreSrq './modules/appService/functionApp.bicep' = {
  name: coreSrqFunctionAppDeploymentName
  params: {
    location: location
    tags: tags
    appInsightsConnectionStringSecretUri: appInsights.outputs.connectionStringSecretUri
    appInsightsResourceId: appInsights.outputs.id
    appServicePlanResourceId: asp.outputs.id
    functionName: coreSrqAppName
    logAnalyticsWorkspaceResourceId: laws.outputs.id
    userAssignedManagedIdentityResourceId: uami.outputs.id
    functionStorageAccountType: functionAppStorageType
    relayNamespaceName: rns.outputs.name
    relayNamespaceResourceId: rns.outputs.id
    hybridConnectionName: hc.outputs.name
    relayNamespaceEndpoint: rns.outputs.endpoint
  }
  dependsOn: [
    kvRbac  // Manual dependency because the Function needs Secrets User access to KV before it can deploy due to the App Insights secret being stored in KV
  ]
}

/*
Exercises:

1: Modify this template to deploy the two remaining Function apps
   ref: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/modules

2: Store Hybrid Connection secrets in Key Vault and reference them in the appropriate Function apps
   ref: https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults/secrets?pivots=deployment-language-bicep
   ref: keyVaultSecret module directory in this repo :D

3: Add a module for Service Bus Topic Subscriptions, deploy the necessary subscriptions
   ref: https://learn.microsoft.com/en-us/azure/templates/microsoft.servicebus/namespaces/topics/subscriptions?pivots=deployment-language-bicep
   ref: https://learn.microsoft.com/en-us/azure/templates/microsoft.servicebus/namespaces/topics/subscriptions/rules?pivots=deployment-language-bicep

4: Deploy the necessary access policies for the Subscriptions.
   ref: https://learn.microsoft.com/en-us/azure/templates/microsoft.servicebus/namespaces/topics/authorizationrules?pivots=deployment-language-bicep

5: Add a module for Function deployment slots
   ref: https://learn.microsoft.com/en-us/azure/templates/microsoft.web/sites/slots?pivots=deployment-language-bicep
*/
