using '../main.bicep'

param workloadName = 'ch-sloc-poc'
param environmentSuffix = 'loc'
param location = 'eastus2'
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
param functionAppServicePlanInstanceCount = 1
param functionAppServicePlanSku = 'EP1'
param coreSrqFunctionAppName = 'core-srq'
param extSrqFunctionAppName = 'ext-srq'
param businessRulesEngineFunctionName = 'bre'
param functionAppStorageType = 'Standard_LRS'
