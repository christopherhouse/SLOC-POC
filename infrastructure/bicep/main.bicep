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

param coreSrqFunctionAppName string

param extSrqFunctionAppName string

param businessRulesEngineFunctionName string

var baseName = '${workloadName}-${environmentSuffix}'

// Log Analytics Workspace
var logAnalyticsWorkspaceName = '${workloadName}-${environmentSuffix}-laws'
var logAnalyticsWorkspaceDeploymentName = '${logAnalyticsWorkspaceName}-${deployment().name}'

// Key Vault
var keyVaultName = '${workloadName}-${environmentSuffix}-kv'
var keyVaultDeploymentName = '${keyVaultName}-${deployment().name}'

// Application Insights
var appInsightsName = '${workloadName}-${environmentSuffix}-ai'
var appInsightsDeploymentName = '${appInsightsName}-${deployment().name}'

// Service Bus Namespace
var serviceBusNamespaceName = '${workloadName}-${environmentSuffix}-sbns'
var serviceBusNamespaceDeploymentName = '${serviceBusNamespaceName}-${deployment().name}'

// Relay Namespace
var relayNamespaceName = '${workloadName}-${environmentSuffix}-rns'
var relayNamespaceDeploymentName = '${relayNamespaceName}-${deployment().name}'

var hyConnectionName = '${workloadName}-${environmentSuffix}-${hybridConnectionName}-hc'
var hyConnectionDeploymentName = '${hyConnectionName}-${deployment().name}'

// User-assigned managed identity
var userAssignedManagedIdentityName = '${workloadName}-${environmentSuffix}-uami'
var userAssignedManagedIdentityDeploymentName = '${userAssignedManagedIdentityName}-${deployment().name}'
var uamiKvSecretsUserDeploymentName = '${userAssignedManagedIdentityName}-kv-secrets-${deployment().name}'
// Functions
var appServicePlanName = '${baseName}-asp'
var appServicePlanDeploymentName = '${appServicePlanName}-${deployment().name}'

var coreSrqAppName = '${baseName}-${coreSrqFunctionAppName}-func'
var coreSrqFunctionAppDeploymentName = '${coreSrqAppName}-${deployment().name}'

var extSrqAppName = '${baseName}-${extSrqFunctionAppName}-func'
var extSrqFunctionAppDeploymentName = '${extSrqAppName}-${deployment().name}'

var breAppName = '${baseName}-${businessRulesEngineFunctionName}-func'
var breFunctionAppDeploymentName = '${breAppName}-${deployment().name}'

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
  }
  dependsOn: [
    kvRbac
  ]
}

module extSrq './modules/appService/functionApp.bicep' = {
  name: extSrqFunctionAppDeploymentName
  params: {
    location: location
    tags: tags
    appInsightsConnectionStringSecretUri: appInsights.outputs.connectionStringSecretUri
    appInsightsResourceId: appInsights.outputs.id
    appServicePlanResourceId: asp.outputs.id
    functionName: extSrqAppName
    logAnalyticsWorkspaceResourceId: laws.outputs.id
    userAssignedManagedIdentityResourceId: uami.outputs.id 
    functionStorageAccountType: functionAppStorageType
  }
}

module bre './modules/appService/functionApp.bicep' = {
  name: breFunctionAppDeploymentName
  params: {
    location: location
    tags: tags
    appInsightsConnectionStringSecretUri: appInsights.outputs.connectionStringSecretUri
    appInsightsResourceId: appInsights.outputs.id
    appServicePlanResourceId: asp.outputs.id
    functionName: breAppName
    logAnalyticsWorkspaceResourceId: laws.outputs.id
    userAssignedManagedIdentityResourceId: uami.outputs.id 
    functionStorageAccountType: functionAppStorageType
  }
}
