@description('The name of the hybrid connection to create')
param hybridConnectionName string

@description('The name of the Relay namespace to create the hybrid connection in')
param relayNamespaceName string

@description('The endpoint of the destination service for the hybrid connection')
param hybridConnectionDestinationEndpoint string

var connectionName = '${relayNamespaceName}/${hybridConnectionName}'

resource hc 'Microsoft.Relay/namespaces/hybridConnections@2021-11-01' = {
  name: connectionName
  properties: {
    requiresClientAuthorization: true
    userMetadata: '[{"key": "endpoint", "value": "${hybridConnectionDestinationEndpoint}"}]'
  }
}
