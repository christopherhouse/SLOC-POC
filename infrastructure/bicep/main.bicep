@description('The name of the workload being deployed, combined with the environment suffix and resource type abbreviation to create the resource name.')
param workloadName string

@description('The environment suffix to be appended to the workload name to create the resource name.')
param environmentSuffix string

@description('The Azure region where resources will be deployed')
param location string
