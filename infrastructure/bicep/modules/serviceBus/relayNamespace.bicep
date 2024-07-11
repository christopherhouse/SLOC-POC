@description('The name of the Relay namespace to create')
param relayNamespaceName string

@description('The Azure region where the Relay namespace should be created')
param location string

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
