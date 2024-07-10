@description('The name of the Application Insights instance to create')
param appInsightsName string

@description('The Azure region where the Application Insights instance will be deployed')
param location string

@description('The ID of the Log Analytics Workspace to link to the Application Insights instance')
param logAnalyticsWorkspaceId string

@description('The name of the Key Vault to store the Application Insights connection string')
param keyVaultName string

@description('The unique identifier for the deployment')
param buildId string

@description('The tags to apply to the Application Insights instance')
param tags object = {}

resource ai 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Bluefield'
    WorkspaceResourceId: logAnalyticsWorkspaceId
  }
}

module connectionString '../keyVault/keyVaultSecret.bicep' = {
  name: 'app-insights-connection-string-${buildId}'
  params: {
    keyVaultName: keyVaultName
    secretName: 'appInsightsConnectionString'
    secretValue: ai.properties.ConnectionString
    tags: tags
  }
}

module iKey '../keyVault/keyVaultSecret.bicep' = {
  name: 'app-insights-instrumentationkey-${buildId}'
  params: {
    keyVaultName: keyVaultName
    secretName: 'appInsightsInstrumentationKey'
    secretValue: ai.properties.InstrumentationKey
    tags: tags
  }
}

output id string = ai.id
output name string = ai.name
output instrumentationKeySecretUri string = iKey.outputs.secretUri
output connectionStringSecretUri string = connectionString.outputs.secretUri
