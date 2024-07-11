import * as udt from '../userDefined/userDefinedTypes.bicep'

@description('The name of the Service Bus namespace to create')
param serviceBusNamespaceName string

@description('The Azure region where the Service Bus namespace will be deployed')
param location string

@description('The SKU of the Service Bus namespace')
param serviceBusNamespaceSku udt.serviceBusSkuType

@description('The number of messaging units to allocate to the Service Bus namespace, only used for Premium SKU')
param capacityUnits int = 1

@description('The resource ID of the Log Analytics Workspace to send diagnostic logs to')
param logAnalyticsWorkspaceResourceId string

@description('The tags to apply to the Service Bus namespace')
param tags object = {}

resource sbns 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' = {
  name: serviceBusNamespaceName
  location: location
  tags: tags
  sku: {
    name: serviceBusNamespaceSku
    capacity: serviceBusNamespaceSku == 'Premium' ? capacityUnits : 0
  }
  properties: {
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Disabled'
    zoneRedundant: true
    disableLocalAuth: true
  }
}

resource laws 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'laws'
  scope: sbns
  properties: {
    logs: [
      {
        categoryGroup: 'allLogs'
        enabled: true
      }
      {
        categoryGroup: 'audit'
        enabled: true
      }
    ]
    workspaceId: logAnalyticsWorkspaceResourceId
  }
}

output name string = sbns.name
output id string = sbns.id
