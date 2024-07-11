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

module rns './modules/serviceBus/relayNamespace.bicep' = {
  name: relayNamespaceDeploymentName
  params: {
    location: location
    relayNamespaceName: relayNamespaceName
  }
}
