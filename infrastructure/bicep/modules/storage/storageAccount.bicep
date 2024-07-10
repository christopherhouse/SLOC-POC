import * as udt from '../userDefined/userDefinedTypes.bicep'

@description('The name of the storage account to create')
param storageAccountName string

@description('The Azure region where the storage account will be deployed')
param location string

@description('The file shares to create')
param fileShares udt.fileSharesConfiguration = []

@description('The blob containers to create')
param blobContainerNames string[] = []

@description('The tables to create')
param tableNames string[] = []

@description('The name of the Key Vault secret to store the storage account connection string')
param storageConnectionStringSecretName string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
])
@description('The SKU of the storage account')
param storageAccountSku string

@description('The name of the Key Vault to store the storage account connection string')
param keyVaultName string

@description('The build ID, used to ensure unique deployment names')
param buildId string

@description('The tags to apply to the storage account')
param tags object

resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  tags: tags
  kind: 'StorageV2'
  sku: {
    name: storageAccountSku
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
    publicNetworkAccess: 'Disabled'
  }
}

resource blobSvc 'Microsoft.Storage/storageAccounts/blobServices@2023-04-01' = {
  name: 'default'
  parent: storage
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: 3
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 3
    }
  }
}

resource blobs 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-04-01' = [for blobContainerName in blobContainerNames : {
  name: blobContainerName
  parent: blobSvc
  properties: {
    publicAccess: 'None'
  }
}]

resource fileServices 'Microsoft.Storage/storageAccounts/fileServices@2023-01-01' = {
  name: 'default'
  parent: storage
}

resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-01-01' = [for fileShare in fileShares : {
  name: fileShare.shareName
  parent: fileServices
  properties: {
    shareQuota: fileShare.quota
  }
}]

resource tableServices 'Microsoft.Storage/storageAccounts/tableServices@2023-01-01' = {
  name: 'default'
  parent: storage
}

resource tables 'Microsoft.Storage/storageAccounts/tableServices/tables@2023-01-01' = [for tableName in tableNames : {
  name: tableName
  parent: tableServices
}]

module blobSecret '../keyVault/keyVaultSecret.bicep' = if (length(storageConnectionStringSecretName) > 0 && length(keyVaultName) > 0) {
  name: '${storageConnectionStringSecretName}-${buildId}'
  params: {
    keyVaultName: keyVaultName
    secretName: storageConnectionStringSecretName
    secretValue: 'DefaultEndpointsProtocol=https;AccountName=${storage.name};AccountKey=${storage.listKeys().keys[0].value};EndpointSuffix=core.windows.net'
  }
}

output id string = storage.id
output name string = storage.name
output connectionStringSecretUri string = blobSecret.outputs.secretUri
