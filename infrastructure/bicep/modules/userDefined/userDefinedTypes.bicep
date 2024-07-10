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
