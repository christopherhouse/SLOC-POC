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

// Log Analytics Workspace
var logAnalyticsWorkspaceName = '${workloadName}-${environmentSuffix}-laws'
var logAnalyticsWorkspaceDeploymentName = '${logAnalyticsWorkspaceName}-${deployment().name}'

// Key Vault
var keyVaultName = '${workloadName}-${environmentSuffix}-kv'
var keyVaultDeploymentName = '${keyVaultName}-${deployment().name}'

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
  }
}
