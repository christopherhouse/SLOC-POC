@description('The name of the Relay namespace to create')
param relayNamespaceName string

@description('The Azure region where the Relay namespace should be created')
param location string

@description('The resource ID of the Log Analytics workspace to send diagnostic logs to')
param logAnalyticsWorkspaceResourceId string

resource rel 'Microsoft.Relay/namespaces@2021-11-01' = {
  name: relayNamespaceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource diag 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'laws'
  scope: rel
  properties: {
    logs: [
      {
        categoryGroup: 'allLogs'
        enabled: true
      }
    ]
    workspaceId: logAnalyticsWorkspaceResourceId
  }
}

output id string = rel.id
output name string = rel.name
output endpoint string = split(replace(rel.properties.serviceBusEndpoint, '/', ''), ':')[1] // Return only hostname from https://<hostname>:<port>
