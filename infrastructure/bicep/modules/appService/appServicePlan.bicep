import * as udt from '../userDefined/userDefinedTypes.bicep'

@description('The name of the App Service Plan')
param appServicePlanName string

@description('The Azure region where the App Service Plan will be created')
param location string

@description('The SKU of the App Service Plan')
param sku udt.appServicePlanSkuType

@description('The number of instances to create for the App Service Plan')
param instanceCount int

@description('The tags to apply to the App Service Plan')
param tags object

var props = sku == 'Y1' ? {} : {
  perSiteScaling: false
  elasticScaleEnabled: true
  maximumElasticWorkerCount: 20
  isSpot: false
  reserved: false
}

resource asp 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  sku: {
    size: sku
    capacity: sku != 'Y1' ? instanceCount : null
    tier: sku == 'Y1' ? 'Dynamic' : 'ElasticPremium'
  }
  properties: props
}
