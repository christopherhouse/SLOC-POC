using '../main.bicep'

param workloadName = 'c-sloc-poc'
param environmentSuffix = 'loc'
param location = 'westus2'
param logAnalyticsRetentionInDays = 90
param tags = {
  workload: workloadName
  environment: environmentSuffix
  costCenter: 'ABC-123-XYZ'
}
param enableKeyVaultPurgeProtection = false
param serviceBusSku = 'Standard'
param hybridConnectionDestinationEndpoint = 'SQL:1433'
param hybridConnectionName = 'sql'
