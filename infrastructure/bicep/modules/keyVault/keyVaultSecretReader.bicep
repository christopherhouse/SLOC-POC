param principalId string

param keyVaultName string

var keyVaultSecretsUserRoleId = '4633458b-17de-408a-b874-0445c86b69e6'

resource kv 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
  scope: resourceGroup()
}

resource kvSecretsUser 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' existing = {
  name: keyVaultSecretsUserRoleId
  scope: subscription()
}

resource ra 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(kv.id, principalId, kvSecretsUser.id)
  scope: kv
  properties: {
    principalId: principalId
    roleDefinitionId: kvSecretsUser.id
    principalType: 'ServicePrincipal'
  }
}
