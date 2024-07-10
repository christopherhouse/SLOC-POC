using '../main.bicep'

param workloadName = 'cmh-sloc-poc'
param environmentSuffix = 'loc'
param location = 'westus2'
param logAnalyticsRetentionInDays = 90
param tags = {
  workload: workloadName
  environment: environmentSuffix
  costCenter: 'ABC-123-XYZ'
}
