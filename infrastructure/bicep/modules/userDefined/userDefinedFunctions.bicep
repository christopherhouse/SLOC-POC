@export()
func formatKeyVaultSecretUri(vaultName string, secretName string) string => 'https://${vaultName}${environment().suffixes.keyvaultDns}/secrets/${secretName}'

@export()
func formatAppServiceKeyVaultReference(secretUri string) string => '@Microsoft.KeyVault(SecretUri=${secretUri})'

@export()
func formatFullyQualifiedDomainName(hostName string, zoneName string) string => '${hostName}.${zoneName}'

@export()
func formatStorageConnectionString(storageAccountName string, storageAccountKey string) string => 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${storageAccountKey};EndpointSuffix=core.windows.net'
