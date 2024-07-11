import * as udf from '../userDefined/userDefinedFunctions.bicep'
import * as udt from '../userDefined/userDefinedTypes.bicep'

@description('The name of the Function App')
param functionName string

@description('The Azure region where the Function App will be created')
param location string

@description('The tags to apply to the Function App')
param tags object

@description('The resource ID of the Log Analytics Workspace')
param logAnalyticsWorkspaceResourceId string

@description('The resource ID of the App Service Plan for the Function App')
param appServicePlanResourceId string

@description('The resource ID of the user-assigned managed identity')
param userAssignedManagedIdentityResourceId string

@description('The resource ID of the Application Insights resource')
param appInsightsResourceId string

@description('The URI of the Key Vault secret containing the Application Insights Instrumentation Key')
param appInsightsConnectionStringSecretUri string

@description('The storage account type for the Function App')
param functionStorageAccountType udt.storageAccountType

var appInsightsTag = {
  'hidden-related:/${appInsightsResourceId}': 'empty'
}

var mergedTags = union(tags, appInsightsTag)

var storageBaseAccountName = toLower(replace(functionName, '-', ''))
var storageAccountName = length(storageBaseAccountName) > 24 ? '${substring(storageBaseAccountName, 0, 22)}sa' : storageBaseAccountName

var websiteConentShare = toLower(uniqueString(functionName, storageAccountName))

resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  tags: tags
  kind: 'StorageV2'
  sku: {
    name: functionStorageAccountType
  }
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource files 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  name: 'default'
  parent: storage
}

resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  name: websiteConentShare
  parent: files
  properties: {
    shareQuota: 1024
  }
}

resource func 'Microsoft.Web/sites@2023-12-01' = {
  name: functionName
  location: location
  tags: mergedTags
  kind: 'functionapp'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedManagedIdentityResourceId}': {}
    }
  }
  properties: {
    serverFarmId: appServicePlanResourceId
    keyVaultReferenceIdentity: userAssignedManagedIdentityResourceId
    siteConfig: {
      numberOfWorkers: 1
      alwaysOn: true
      http20Enabled: true
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 1
      keyVaultReferenceIdentity: userAssignedManagedIdentityResourceId
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: udf.formatStorageConnectionString(storageAccountName, storage.listKeys().keys[0].value)
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: udf.formatStorageConnectionString(storageAccountName, storage.listKeys().keys[0].value)
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: fileShare.name
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: udf.formatAppServiceKeyVaultReference(appInsightsConnectionStringSecretUri)
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '~20'
        }
      ]
    }
  }
}

resource diags 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'laws'
  scope: func
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
