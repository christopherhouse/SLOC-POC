@description('The name of the Log Analytics Workspace to create')
param logAnalyticsWorkspaceName string

@description('The Azure region where the Log Analytics Workspace will be deployed')
param location string

@description('The retention period in days for Log Analytics data')
param retentionInDays int

@description('The tags to apply to the Log Analytics Workspace')
param tags object

resource laws 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  tags: tags
  properties: {
    retentionInDays: retentionInDays
    sku: {
      name: 'PerGB2018'
    }
  }
}

output id string = laws.id
output name string = laws.name
