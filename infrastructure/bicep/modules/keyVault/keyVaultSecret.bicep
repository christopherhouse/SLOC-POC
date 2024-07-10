@description('The name of the secret to create')
param secretName string

@description('The name of the Key Vault to store the secret')
param keyVaultName string

@secure()
@description('The value of the secret')
param secretValue string

@description('The tags to apply to the secret')
param tags object = {}

resource kv 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: keyVaultName
  scope: resourceGroup()
}

resource secret 'Microsoft.keyvault/vaults/secrets@2021-11-01-preview' = {
  name: secretName
  tags: tags
  parent: kv
  properties: {
    value: secretValue
  }
}

output secretUri string = secret.properties.secretUri
