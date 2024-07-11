@export()
@description('Supported language workers for Function Apps')
type functionWorkerRuntimes = 'dotnet' | 'node' | 'python' | 'java' | 'powershell'

@export()
@description('Defines file share configuration')
type filShareConfigurationType = {
  shareName: string
  quota: int
}

@export()
@description('Array of file share configurations')
type fileSharesConfiguration = filShareConfigurationType[]

@export()
@description('Supported service bus SKU types')
type serviceBusSkuType = ('Basic' | 'Standard' | 'Premium')

@export()
@description('Supported app service plan SKU types')
type appServicePlanSkuType = ('EP1' | 'EP2' | 'EP3' | 'Y1')

@export()
@description('Supported storage account types')
type storageAccountType = ( 'Standard_LRS' | 'Standard_GRS' | 'Standard_RAGRS' | 'Standard_ZRS' | 'Premium_LRS' | 'Premium_ZRS' | 'Standard_GZRS' | 'Standard_RAGZRS')
