param sites_func_ext_srq_dev_name string = 'func-ext-srq-dev'
param vaults_kv_cjis_dev_name string = 'kv-cjis-dev'
param sites_func_core_srq_dev_name string = 'func-core-srq-dev'
param components_FuncAppInsight_name string = 'FuncAppInsight'
param namespaces_sbns_hub_dev_name string = 'sbns-hub-dev'
param sites_func_mni_rules_engine_dev_name string = 'func-mni-rules-engine-dev'
param serverfarms_ASP_rgcjishubdev_89d1_name string = 'ASP-rgcjishubdev-89d1'
param vaults_vault_lwtur9oo_name string = 'vault-lwtur9oo'
param storageAccounts_rgcjishubdev968e_name string = 'rgcjishubdev968e'
param storageAccounts_rgcjishubdev9e17_name string = 'rgcjishubdev9e17'
param namespaces_sbns_cjis_connection_dev_name string = 'sbns-cjis-connection-dev'
param privateEndpoints_pep_mni_rules_engine_name string = 'pep-mni-rules-engine'
param virtualNetworks_vnet_cjis_services_dev_name string = 'vnet-cjis-services-dev'
param privateDnsZones_privatelink_azurewebsites_net_name string = 'privatelink.azurewebsites.net'
param actionGroups_Application_Insights_Smart_Detection_name string = 'Application Insights Smart Detection'
param userAssignedIdentities_id_cjishub_dev_admin_name string = 'id-cjishub-dev-admin'
param workspaces_DefaultWorkspace_fc0d686b_0d69_4abf_86dc_c7c08b5d5061_WUS2_externalid string = '/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/DefaultResourceGroup-WUS2/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-fc0d686b-0d69-4abf-86dc-c7c08b5d5061-WUS2'

resource actionGroups_Application_Insights_Smart_Detection_name_resource 'microsoft.insights/actionGroups@2023-09-01-preview' = {
  name: actionGroups_Application_Insights_Smart_Detection_name
  location: 'Global'
  properties: {
    groupShortName: 'SmartDetect'
    enabled: true
    emailReceivers: []
    smsReceivers: []
    webhookReceivers: []
    eventHubReceivers: []
    itsmReceivers: []
    azureAppPushReceivers: []
    automationRunbookReceivers: []
    voiceReceivers: []
    logicAppReceivers: []
    azureFunctionReceivers: []
    armRoleReceivers: [
      {
        name: 'Monitoring Contributor'
        roleId: '749f88d5-cbae-40b8-bcfc-e573ddc772fa'
        useCommonAlertSchema: true
      }
      {
        name: 'Monitoring Reader'
        roleId: '43d0d8ad-25c7-4714-9337-8ba259a9fe05'
        useCommonAlertSchema: true
      }
    ]
  }
}

resource components_FuncAppInsight_name_resource 'microsoft.insights/components@2020-02-02' = {
  name: components_FuncAppInsight_name
  location: 'westus2'
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'IbizaWebAppExtensionCreate'
    RetentionInDays: 90
    WorkspaceResourceId: workspaces_DefaultWorkspace_fc0d686b_0d69_4abf_86dc_c7c08b5d5061_WUS2_externalid
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource vaults_kv_cjis_dev_name_resource 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: vaults_kv_cjis_dev_name
  location: 'westus2'
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: '84c3c774-7fdf-40e2-a590-27b2e70f8126'
    accessPolicies: []
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: true
    vaultUri: 'https://${vaults_kv_cjis_dev_name}.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

resource userAssignedIdentities_id_cjishub_dev_admin_name_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
  name: userAssignedIdentities_id_cjishub_dev_admin_name
  location: 'westus2'
}

resource privateDnsZones_privatelink_azurewebsites_net_name_resource 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZones_privatelink_azurewebsites_net_name
  location: 'global'
  properties: {}
}

resource virtualNetworks_vnet_cjis_services_dev_name_resource 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: virtualNetworks_vnet_cjis_services_dev_name
  location: 'westus2'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: true
      enforcement: 'AllowUnencrypted'
    }
    subnets: [
      {
        name: 'default'
        id: virtualNetworks_vnet_cjis_services_dev_name_default.id
        properties: {
          addressPrefixes: [
            '10.0.0.0/24'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource vaults_vault_lwtur9oo_name_resource 'Microsoft.RecoveryServices/vaults@2024-04-30-preview' = {
  name: vaults_vault_lwtur9oo_name
  location: 'westus2'
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
    securitySettings: {
      softDeleteSettings: {
        softDeleteRetentionPeriodInDays: 14
        softDeleteState: 'Enabled'
        enhancedSecurityState: 'Enabled'
      }
    }
    redundancySettings: {
      standardTierStorageRedundancy: 'GeoRedundant'
      crossRegionRestore: 'Disabled'
    }
    publicNetworkAccess: 'Enabled'
    restoreSettings: {
      crossSubscriptionRestoreSettings: {
        crossSubscriptionRestoreState: 'Enabled'
      }
    }
  }
}

resource namespaces_sbns_cjis_connection_dev_name_resource 'Microsoft.Relay/namespaces@2021-11-01' = {
  name: namespaces_sbns_cjis_connection_dev_name
  location: 'westus2'
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource namespaces_sbns_hub_dev_name_resource 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' = {
  name: namespaces_sbns_hub_dev_name
  location: 'westus2'
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    premiumMessagingPartitions: 0
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    disableLocalAuth: false
    zoneRedundant: false
  }
}

resource storageAccounts_rgcjishubdev968e_name_resource 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccounts_rgcjishubdev968e_name
  location: 'westus2'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'Storage'
  properties: {
    defaultToOAuthAuthentication: true
    allowCrossTenantReplication: false
    azureFilesIdentityBasedAuthentication: {
      directoryServiceOptions: 'AADKERB'
      defaultSharePermission: 'StorageFileDataSmbShareContributor'
    }
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}

resource storageAccounts_rgcjishubdev9e17_name_resource 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccounts_rgcjishubdev9e17_name
  location: 'westus2'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'Storage'
  properties: {
    defaultToOAuthAuthentication: true
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}

resource serverfarms_ASP_rgcjishubdev_89d1_name_resource 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: serverfarms_ASP_rgcjishubdev_89d1_name
  location: 'West US 2'
  sku: {
    name: 'EP1'
    tier: 'ElasticPremium'
    size: 'EP1'
    family: 'EP'
    capacity: 1
  }
  kind: 'elastic'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: true
    maximumElasticWorkerCount: 20
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}

resource components_FuncAppInsight_name_degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'degradationindependencyduration'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'degradationindependencyduration'
      DisplayName: 'Degradation in dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_FuncAppInsight_name_degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'degradationinserverresponsetime'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'degradationinserverresponsetime'
      DisplayName: 'Degradation in server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_FuncAppInsight_name_digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'digestMailConfiguration'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'digestMailConfiguration'
      DisplayName: 'Digest Mail Configuration'
      Description: 'This rule describes the digest mail preferences'
      HelpUrl: 'www.homail.com'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_FuncAppInsight_name_extension_billingdatavolumedailyspikeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'extension_billingdatavolumedailyspikeextension'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_billingdatavolumedailyspikeextension'
      DisplayName: 'Abnormal rise in daily data volume (preview)'
      Description: 'This detection rule automatically analyzes the billing data generated by your application, and can warn you about an unusual increase in your application\'s billing costs'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/billing-data-volume-daily-spike.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_FuncAppInsight_name_extension_canaryextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'extension_canaryextension'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_canaryextension'
      DisplayName: 'Canary extension'
      Description: 'Canary extension'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_FuncAppInsight_name_extension_exceptionchangeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'extension_exceptionchangeextension'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_exceptionchangeextension'
      DisplayName: 'Abnormal rise in exception volume (preview)'
      Description: 'This detection rule automatically analyzes the exceptions thrown in your application, and can warn you about unusual patterns in your exception telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/abnormal-rise-in-exception-volume.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_FuncAppInsight_name_extension_memoryleakextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'extension_memoryleakextension'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_memoryleakextension'
      DisplayName: 'Potential memory leak detected (preview)'
      Description: 'This detection rule automatically analyzes the memory consumption of each process in your application, and can warn you about potential memory leaks or increased memory consumption.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/memory-leak.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_FuncAppInsight_name_extension_securityextensionspackage 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'extension_securityextensionspackage'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_securityextensionspackage'
      DisplayName: 'Potential security issue detected (preview)'
      Description: 'This detection rule automatically analyzes the telemetry generated by your application and detects potential security issues.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/application-security-detection-pack.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_FuncAppInsight_name_extension_traceseveritydetector 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'extension_traceseveritydetector'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'extension_traceseveritydetector'
      DisplayName: 'Degradation in trace severity ratio (preview)'
      Description: 'This detection rule automatically analyzes the trace logs emitted from your application, and can warn you about unusual patterns in the severity of your trace telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/degradation-in-trace-severity-ratio.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_FuncAppInsight_name_longdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'longdependencyduration'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'longdependencyduration'
      DisplayName: 'Long dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_FuncAppInsight_name_migrationToAlertRulesCompleted 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'migrationToAlertRulesCompleted'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'migrationToAlertRulesCompleted'
      DisplayName: 'Migration To Alert Rules Completed'
      Description: 'A configuration that controls the migration state of Smart Detection to Smart Alerts'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: true
      IsEnabledByDefault: false
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: false
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_FuncAppInsight_name_slowpageloadtime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'slowpageloadtime'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'slowpageloadtime'
      DisplayName: 'Slow page load time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_FuncAppInsight_name_slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_FuncAppInsight_name_resource
  name: 'slowserverresponsetime'
  location: 'westus2'
  properties: {
    RuleDefinitions: {
      Name: 'slowserverresponsetime'
      DisplayName: 'Slow server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource vaults_kv_cjis_dev_name_CMKAuto2 'Microsoft.KeyVault/vaults/keys@2023-07-01' = {
  parent: vaults_kv_cjis_dev_name_resource
  name: 'CMKAuto2'
  location: 'westus2'
  properties: {
    attributes: {
      enabled: true
    }
  }
}

resource vaults_kv_cjis_dev_name_MNIDB_ConnectionString 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: vaults_kv_cjis_dev_name_resource
  name: 'MNIDB-ConnectionString'
  location: 'westus2'
  properties: {
    attributes: {
      enabled: true
    }
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_azurewebsites_net_name 'Microsoft.Network/privateDnsZones/SOA@2020-06-01' = {
  parent: privateDnsZones_privatelink_azurewebsites_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource virtualNetworks_vnet_cjis_services_dev_name_default 'Microsoft.Network/virtualNetworks/subnets@2023-11-01' = {
  name: '${virtualNetworks_vnet_cjis_services_dev_name}/default'
  properties: {
    addressPrefixes: [
      '10.0.0.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_cjis_services_dev_name_resource
  ]
}

resource vaults_vault_lwtur9oo_name_DailyPolicy_lwtur9uv 'Microsoft.RecoveryServices/vaults/backupPolicies@2024-04-30-preview' = {
  parent: vaults_vault_lwtur9oo_name_resource
  name: 'DailyPolicy-lwtur9uv'
  properties: {
    backupManagementType: 'AzureStorage'
    workLoadType: 'AzureFileShare'
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2024-05-30T19:30:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2024-05-30T19:30:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_vault_lwtur9oo_name_DefaultPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2024-04-30-preview' = {
  parent: vaults_vault_lwtur9oo_name_resource
  name: 'DefaultPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2024-05-31T08:30:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2024-05-31T08:30:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_vault_lwtur9oo_name_EnhancedPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2024-04-30-preview' = {
  parent: vaults_vault_lwtur9oo_name_resource
  name: 'EnhancedPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    policyType: 'V2'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicyV2'
      scheduleRunFrequency: 'Hourly'
      hourlySchedule: {
        interval: 4
        scheduleWindowStartTime: '2024-05-31T08:00:00Z'
        scheduleWindowDuration: 12
      }
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2024-05-31T08:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_vault_lwtur9oo_name_HourlyLogBackup 'Microsoft.RecoveryServices/vaults/backupPolicies@2024-04-30-preview' = {
  parent: vaults_vault_lwtur9oo_name_resource
  name: 'HourlyLogBackup'
  properties: {
    backupManagementType: 'AzureWorkload'
    workLoadType: 'SQLDataBase'
    settings: {
      timeZone: 'UTC'
      issqlcompression: false
      isCompression: false
    }
    subProtectionPolicy: [
      {
        policyType: 'Full'
        schedulePolicy: {
          schedulePolicyType: 'SimpleSchedulePolicy'
          scheduleRunFrequency: 'Daily'
          scheduleRunTimes: [
            '2024-05-31T08:30:00Z'
          ]
          scheduleWeeklyFrequency: 0
        }
        retentionPolicy: {
          retentionPolicyType: 'LongTermRetentionPolicy'
          dailySchedule: {
            retentionTimes: [
              '2024-05-31T08:30:00Z'
            ]
            retentionDuration: {
              count: 30
              durationType: 'Days'
            }
          }
        }
      }
      {
        policyType: 'Log'
        schedulePolicy: {
          schedulePolicyType: 'LogSchedulePolicy'
          scheduleFrequencyInMins: 60
        }
        retentionPolicy: {
          retentionPolicyType: 'SimpleRetentionPolicy'
          retentionDuration: {
            count: 30
            durationType: 'Days'
          }
        }
      }
    ]
    protectedItemsCount: 0
  }
}

resource vaults_vault_lwtur9oo_name_defaultAlertSetting 'Microsoft.RecoveryServices/vaults/replicationAlertSettings@2024-01-01' = {
  parent: vaults_vault_lwtur9oo_name_resource
  name: 'defaultAlertSetting'
  properties: {
    sendToOwners: 'DoNotSend'
    customEmailAddresses: []
  }
}

resource vaults_vault_lwtur9oo_name_default 'Microsoft.RecoveryServices/vaults/replicationVaultSettings@2024-01-01' = {
  parent: vaults_vault_lwtur9oo_name_resource
  name: 'default'
  properties: {}
}

resource namespaces_sbns_cjis_connection_dev_name_RootManageSharedAccessKey 'Microsoft.Relay/namespaces/authorizationrules@2021-11-01' = {
  parent: namespaces_sbns_cjis_connection_dev_name_resource
  name: 'RootManageSharedAccessKey'
  location: 'westus2'
  properties: {
    rights: [
      'Listen'
      'Manage'
      'Send'
    ]
  }
}

resource namespaces_sbns_cjis_connection_dev_name_hc_cjis_dev 'Microsoft.Relay/namespaces/hybridconnections@2021-11-01' = {
  parent: namespaces_sbns_cjis_connection_dev_name_resource
  name: 'hc-cjis-dev'
  location: 'westus2'
  properties: {
    requiresClientAuthorization: true
    userMetadata: '[{"key":"endpoint","value":"cjisdvsql1:1433"}]'
  }
}

resource namespaces_sbns_cjis_connection_dev_name_default 'Microsoft.Relay/namespaces/networkrulesets@2021-11-01' = {
  parent: namespaces_sbns_cjis_connection_dev_name_resource
  name: 'default'
  location: 'westus2'
  properties: {
    publicNetworkAccess: 'Enabled'
    defaultAction: 'Allow'
    ipRules: []
    trustedServiceAccessEnabled: false
  }
}

resource namespaces_sbns_hub_dev_name_RootManageSharedAccessKey 'Microsoft.ServiceBus/namespaces/authorizationrules@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_resource
  name: 'RootManageSharedAccessKey'
  location: 'westus2'
  properties: {
    rights: [
      'Listen'
      'Manage'
      'Send'
    ]
  }
}

resource namespaces_sbns_hub_dev_name_default 'Microsoft.ServiceBus/namespaces/networkrulesets@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_resource
  name: 'default'
  location: 'westus2'
  properties: {
    publicNetworkAccess: 'Enabled'
    defaultAction: 'Allow'
    virtualNetworkRules: []
    ipRules: []
    trustedServiceAccessEnabled: false
  }
}

resource namespaces_sbns_hub_dev_name_sbt_core_srq 'Microsoft.ServiceBus/namespaces/topics@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_resource
  name: 'sbt-core-srq'
  location: 'westus2'
  properties: {
    maxMessageSizeInKilobytes: 256
    defaultMessageTimeToLive: 'P14D'
    maxSizeInMegabytes: 1024
    requiresDuplicateDetection: false
    duplicateDetectionHistoryTimeWindow: 'PT10M'
    enableBatchedOperations: true
    status: 'Active'
    supportOrdering: false
    autoDeleteOnIdle: 'P10675199DT2H48M5.4775807S'
    enablePartitioning: false
    enableExpress: false
  }
}

resource namespaces_sbns_hub_dev_name_sbt_ext_srq 'Microsoft.ServiceBus/namespaces/topics@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_resource
  name: 'sbt-ext-srq'
  location: 'westus2'
  properties: {
    maxMessageSizeInKilobytes: 256
    defaultMessageTimeToLive: 'P1D'
    maxSizeInMegabytes: 1024
    requiresDuplicateDetection: false
    duplicateDetectionHistoryTimeWindow: 'PT10M'
    enableBatchedOperations: true
    status: 'Active'
    supportOrdering: false
    autoDeleteOnIdle: 'P10675199DT2H48M5.4775807S'
    enablePartitioning: false
    enableExpress: false
  }
}

resource namespaces_sbns_hub_dev_name_sbt_mni_caseinfo 'Microsoft.ServiceBus/namespaces/topics@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_resource
  name: 'sbt-mni-caseinfo'
  location: 'westus2'
  properties: {
    maxMessageSizeInKilobytes: 256
    defaultMessageTimeToLive: 'P1D'
    maxSizeInMegabytes: 1024
    requiresDuplicateDetection: false
    duplicateDetectionHistoryTimeWindow: 'PT10M'
    enableBatchedOperations: true
    status: 'Active'
    supportOrdering: false
    autoDeleteOnIdle: 'P10675199DT2H48M5.4775807S'
    enablePartitioning: false
    enableExpress: false
  }
}

resource storageAccounts_rgcjishubdev968e_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev968e_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource storageAccounts_rgcjishubdev9e17_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev9e17_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev968e_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev968e_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 14
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev9e17_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev9e17_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_rgcjishubdev968e_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev968e_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_rgcjishubdev9e17_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev9e17_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgcjishubdev968e_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev968e_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgcjishubdev9e17_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev9e17_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sites_func_core_srq_dev_name_resource 'Microsoft.Web/sites@2023-12-01' = {
  name: sites_func_core_srq_dev_name
  location: 'West US 2'
  tags: {
    'hidden-related:/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/rg-cjis-hub-dev/providers/Microsoft.Web/serverFarms/ASP-rgcjishubdev-89d1': 'empty'
  }
  kind: 'functionapp'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourcegroups/rg-cjis-hub-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-cjishub-dev-admin': {}
    }
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_func_core_srq_dev_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_func_core_srq_dev_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_ASP_rgcjishubdev_89d1_name_resource.id
    reserved: false
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 1
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: '5CA75E45D5AF4EDCB56E5C61D3321A2B7010EF2EA511BD6873B3CC937F14DBEC'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
    publicNetworkAccess: 'Disabled'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_func_ext_srq_dev_name_resource 'Microsoft.Web/sites@2023-12-01' = {
  name: sites_func_ext_srq_dev_name
  location: 'West US 2'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/rg-cjis-hub-dev/providers/Microsoft.Insights/components/func-ext-srq-dev'
  }
  kind: 'functionapp'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourcegroups/rg-cjis-hub-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-cjishub-dev-admin': {}
    }
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_func_ext_srq_dev_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_func_ext_srq_dev_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_ASP_rgcjishubdev_89d1_name_resource.id
    reserved: false
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 1
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: '5CA75E45D5AF4EDCB56E5C61D3321A2B7010EF2EA511BD6873B3CC937F14DBEC'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
    publicNetworkAccess: 'Disabled'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_func_mni_rules_engine_dev_name_resource 'Microsoft.Web/sites@2023-12-01' = {
  name: sites_func_mni_rules_engine_dev_name
  location: 'West US 2'
  tags: {
    'hidden-related:/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/rg-cjis-hub-dev/providers/Microsoft.Web/serverFarms/ASP-rgcjishubdev-89d1': 'empty'
  }
  kind: 'functionapp'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourcegroups/rg-cjis-hub-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-cjishub-dev-admin': {}
    }
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_func_mni_rules_engine_dev_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_func_mni_rules_engine_dev_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_ASP_rgcjishubdev_89d1_name_resource.id
    reserved: false
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 1
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: '5CA75E45D5AF4EDCB56E5C61D3321A2B7010EF2EA511BD6873B3CC937F14DBEC'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
    publicNetworkAccess: 'Enabled'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_func_core_srq_dev_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: 'ftp'
  location: 'West US 2'
  tags: {
    'hidden-related:/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/rg-cjis-hub-dev/providers/Microsoft.Web/serverFarms/ASP-rgcjishubdev-89d1': 'empty'
  }
  properties: {
    allow: true
  }
}

resource sites_func_ext_srq_dev_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: 'ftp'
  location: 'West US 2'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/rg-cjis-hub-dev/providers/Microsoft.Insights/components/func-ext-srq-dev'
  }
  properties: {
    allow: true
  }
}

resource sites_func_mni_rules_engine_dev_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_func_mni_rules_engine_dev_name_resource
  name: 'ftp'
  location: 'West US 2'
  tags: {
    'hidden-related:/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/rg-cjis-hub-dev/providers/Microsoft.Web/serverFarms/ASP-rgcjishubdev-89d1': 'empty'
  }
  properties: {
    allow: true
  }
}

resource sites_func_core_srq_dev_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: 'scm'
  location: 'West US 2'
  tags: {
    'hidden-related:/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/rg-cjis-hub-dev/providers/Microsoft.Web/serverFarms/ASP-rgcjishubdev-89d1': 'empty'
  }
  properties: {
    allow: true
  }
}

resource sites_func_ext_srq_dev_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: 'scm'
  location: 'West US 2'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/rg-cjis-hub-dev/providers/Microsoft.Insights/components/func-ext-srq-dev'
  }
  properties: {
    allow: true
  }
}

resource sites_func_mni_rules_engine_dev_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_func_mni_rules_engine_dev_name_resource
  name: 'scm'
  location: 'West US 2'
  tags: {
    'hidden-related:/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/rg-cjis-hub-dev/providers/Microsoft.Web/serverFarms/ASP-rgcjishubdev-89d1': 'empty'
  }
  properties: {
    allow: true
  }
}

resource sites_func_core_srq_dev_name_web 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: 'web'
  location: 'West US 2'
  tags: {
    'hidden-related:/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/rg-cjis-hub-dev/providers/Microsoft.Web/serverFarms/ASP-rgcjishubdev-89d1': 'empty'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v8.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    remoteDebuggingVersion: 'VS2019'
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$func-core-srq-dev'
    scmType: 'None'
    use32BitWorkerProcess: false
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Disabled'
    localMySqlEnabled: false
    xManagedServiceIdentityId: 25045
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    ipSecurityRestrictionsDefaultAction: 'Allow'
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsDefaultAction: 'Allow'
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 1
    functionAppScaleLimit: 0
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 1
    azureStorageAccounts: {}
  }
}

resource sites_func_ext_srq_dev_name_web 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: 'web'
  location: 'West US 2'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/rg-cjis-hub-dev/providers/Microsoft.Insights/components/func-ext-srq-dev'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v8.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    remoteDebuggingVersion: 'VS2019'
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$func-ext-srq-dev'
    scmType: 'None'
    use32BitWorkerProcess: false
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Disabled'
    cors: {
      allowedOrigins: [
        'https://portal.azure.com'
      ]
      supportCredentials: false
    }
    localMySqlEnabled: false
    xManagedServiceIdentityId: 24723
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    ipSecurityRestrictionsDefaultAction: 'Allow'
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsDefaultAction: 'Allow'
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 1
    functionAppScaleLimit: 0
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 1
    azureStorageAccounts: {}
  }
}

resource sites_func_mni_rules_engine_dev_name_web 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: sites_func_mni_rules_engine_dev_name_resource
  name: 'web'
  location: 'West US 2'
  tags: {
    'hidden-related:/subscriptions/fc0d686b-0d69-4abf-86dc-c7c08b5d5061/resourceGroups/rg-cjis-hub-dev/providers/Microsoft.Web/serverFarms/ASP-rgcjishubdev-89d1': 'empty'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v6.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    remoteDebuggingVersion: 'VS2019'
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$func-mni-rules-engine-dev'
    scmType: 'None'
    use32BitWorkerProcess: false
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Enabled'
    localMySqlEnabled: false
    xManagedServiceIdentityId: 29510
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    ipSecurityRestrictionsDefaultAction: 'Allow'
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsDefaultAction: 'Allow'
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 1
    functionAppScaleLimit: 0
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 1
    azureStorageAccounts: {}
  }
}

resource sites_func_mni_rules_engine_dev_name_0ad84ba1ebe0435e9b3d5d17ad2d3503 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_mni_rules_engine_dev_name_resource
  name: '0ad84ba1ebe0435e9b3d5d17ad2d3503'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-06-20T18:53:41.6396931Z'
    end_time: '2024-06-20T18:53:43.0335383Z'
    active: true
  }
}

resource sites_func_mni_rules_engine_dev_name_0fd382fddbad43d2971f75542dd7fd9f 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_mni_rules_engine_dev_name_resource
  name: '0fd382fddbad43d2971f75542dd7fd9f'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-06-20T16:09:57.7932631Z'
    end_time: '2024-06-20T16:09:59.3622207Z'
    active: false
  }
}

resource sites_func_core_srq_dev_name_152ff5e0341a438f9c6778f84c2e7f32 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: '152ff5e0341a438f9c6778f84c2e7f32'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-05-22T19:39:57.3357561Z'
    end_time: '2024-05-22T19:39:58.8366563Z'
    active: false
  }
}

resource sites_func_ext_srq_dev_name_1fac3908de7446e494fdac3c3d002811 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: '1fac3908de7446e494fdac3c3d002811'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-05-19T17:38:39.9916652Z'
    end_time: '2024-05-19T17:38:41.5865685Z'
    active: false
  }
}

resource sites_func_ext_srq_dev_name_2768006558d84e7bb667c79cae83ddee 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: '2768006558d84e7bb667c79cae83ddee'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-06-18T23:38:54.7255493Z'
    end_time: '2024-06-18T23:38:56.6944296Z'
    active: false
  }
}

resource sites_func_core_srq_dev_name_443b9737aa104229b785d9a1fd0ba20e 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: '443b9737aa104229b785d9a1fd0ba20e'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-06-06T17:46:50.3654913Z'
    end_time: '2024-06-06T17:46:52.6189673Z'
    active: false
  }
}

resource sites_func_core_srq_dev_name_4ae18f8890a44db8b967efffd3cfad81 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: '4ae18f8890a44db8b967efffd3cfad81'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-05-22T19:00:06.0809933Z'
    end_time: '2024-05-22T19:00:07.6278738Z'
    active: false
  }
}

resource sites_func_ext_srq_dev_name_59c8a7a1b8844328a75fb12ab0f5ed12 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: '59c8a7a1b8844328a75fb12ab0f5ed12'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-05-20T18:41:06.379037Z'
    end_time: '2024-05-20T18:41:08.0271799Z'
    active: false
  }
}

resource sites_func_ext_srq_dev_name_7834e12ca9534e59924014faea5eba1c 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: '7834e12ca9534e59924014faea5eba1c'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-06-19T15:26:59.8539136Z'
    end_time: '2024-06-19T15:27:01.1664808Z'
    active: true
  }
}

resource sites_func_mni_rules_engine_dev_name_7e74399e0fa8418f9c1d1934c7b6577b 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_mni_rules_engine_dev_name_resource
  name: '7e74399e0fa8418f9c1d1934c7b6577b'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-06-20T18:08:47.9110938Z'
    end_time: '2024-06-20T18:08:49.4786434Z'
    active: false
  }
}

resource sites_func_core_srq_dev_name_82ecad8b46cd441ea63dc8078ad0abbb 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: '82ecad8b46cd441ea63dc8078ad0abbb'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-05-21T00:39:07.3994886Z'
    end_time: '2024-05-21T00:39:08.9620441Z'
    active: false
  }
}

resource sites_func_core_srq_dev_name_aed6dc0f0e344165806f232b006f42b0 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: 'aed6dc0f0e344165806f232b006f42b0'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-06-10T17:55:33.7509654Z'
    end_time: '2024-06-10T17:55:35.1417174Z'
    active: true
  }
}

resource sites_func_ext_srq_dev_name_af8f52c4657d431fbbdb482bcfdd67a9 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: 'af8f52c4657d431fbbdb482bcfdd67a9'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-06-18T23:18:01.5114228Z'
    end_time: '2024-06-18T23:18:02.7463971Z'
    active: false
  }
}

resource sites_func_mni_rules_engine_dev_name_b1d28fb5f1a645008d240892001832ab 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_mni_rules_engine_dev_name_resource
  name: 'b1d28fb5f1a645008d240892001832ab'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-06-20T18:47:38.9149911Z'
    end_time: '2024-06-20T18:47:40.2432583Z'
    active: false
  }
}

resource sites_func_ext_srq_dev_name_b2b40d08a6a94393876e4c035c7300da 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: 'b2b40d08a6a94393876e4c035c7300da'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-05-19T17:39:37.4247669Z'
    end_time: '2024-05-19T17:39:38.6935132Z'
    active: false
  }
}

resource sites_func_ext_srq_dev_name_bce5d7adf979425487ce164e6ad2bb51 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: 'bce5d7adf979425487ce164e6ad2bb51'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-06-18T23:44:03.2558916Z'
    end_time: '2024-06-18T23:44:04.7445849Z'
    active: false
  }
}

resource sites_func_ext_srq_dev_name_c2383c9e98d34f88a03530a10288c778 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: 'c2383c9e98d34f88a03530a10288c778'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-06-18T23:29:08.9217467Z'
    end_time: '2024-06-18T23:29:10.5624608Z'
    active: false
  }
}

resource sites_func_core_srq_dev_name_c5bc3d52b14f4ff6a972d4cbe6b2f0c0 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: 'c5bc3d52b14f4ff6a972d4cbe6b2f0c0'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-05-29T01:59:49.884944Z'
    end_time: '2024-05-29T01:59:51.1817915Z'
    active: false
  }
}

resource sites_func_ext_srq_dev_name_d236095bfb074cd6825afdedc1cb4bff 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: 'd236095bfb074cd6825afdedc1cb4bff'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-05-20T00:58:53.2727204Z'
    end_time: '2024-05-20T00:58:54.7277141Z'
    active: false
  }
}

resource sites_func_ext_srq_dev_name_da2a1797c18943d2a75a29c3f8afd572 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: 'da2a1797c18943d2a75a29c3f8afd572'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-05-20T02:38:29.5448335Z'
    end_time: '2024-05-20T02:38:30.8746175Z'
    active: false
  }
}

resource sites_func_core_srq_dev_name_dc780298b61f4ecb957599c32b5802b8 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: 'dc780298b61f4ecb957599c32b5802b8'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-06-06T17:14:34.190905Z'
    end_time: '2024-06-06T17:14:35.7603745Z'
    active: false
  }
}

resource sites_func_core_srq_dev_name_eb37dbc2143545ee8504a49ac2beee97 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: 'eb37dbc2143545ee8504a49ac2beee97'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-05-29T02:09:18.7872817Z'
    end_time: '2024-05-29T02:09:19.9747486Z'
    active: false
  }
}

resource sites_func_core_srq_dev_name_f2a907166b514e0b9b620b02746b4564 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: 'f2a907166b514e0b9b620b02746b4564'
  location: 'West US 2'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-05-22T19:03:48.9467206Z'
    end_time: '2024-05-22T19:03:50.6255202Z'
    active: false
  }
}

resource sites_func_core_srq_dev_name_CjisCoreSrqTriggerFunction 'Microsoft.Web/sites/functions@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: 'CjisCoreSrqTriggerFunction'
  location: 'West US 2'
  properties: {
    script_href: 'https://func-core-srq-dev.azurewebsites.net/admin/vfs/site/wwwroot/func.cjis.core.srq.dll'
    test_data_href: 'https://func-core-srq-dev.azurewebsites.net/admin/vfs/data/Functions/sampledata/CjisCoreSrqTriggerFunction.dat'
    href: 'https://func-core-srq-dev.azurewebsites.net/admin/functions/CjisCoreSrqTriggerFunction'
    config: {
      name: 'CjisCoreSrqTriggerFunction'
      entryPoint: 'func_cjis_ext_seq_dev.CjisCoreSrqTriggerFunction.CjisExtSrqTriggerFunctionAndSend'
      scriptFile: 'func.cjis.core.srq.dll'
      language: 'dotnet-isolated'
      functionDirectory: ''
      bindings: [
        {
          name: '$return'
          type: 'serviceBus'
          direction: 'Out'
          queueOrTopicName: 'sbt-mni-caseinfo'
          entityType: 'Topic'
          connection: 'ServiceConnection'
        }
        {
          name: 'message'
          type: 'serviceBusTrigger'
          direction: 'In'
          properties: {
            supportsDeferredBinding: 'True'
          }
          topicName: 'sbt-core-srq'
          subscriptionName: 'func-core-srq'
          connection: 'ServiceConnection'
          cardinality: 'One'
        }
      ]
    }
    language: 'dotnet-isolated'
    isDisabled: false
  }
}

resource sites_func_ext_srq_dev_name_CjisExtSrqTriggerFunction 'Microsoft.Web/sites/functions@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: 'CjisExtSrqTriggerFunction'
  location: 'West US 2'
  properties: {
    script_href: 'https://func-ext-srq-dev.azurewebsites.net/admin/vfs/site/wwwroot/func-cjis-ext-srq.dll'
    test_data_href: 'https://func-ext-srq-dev.azurewebsites.net/admin/vfs/data/Functions/sampledata/CjisExtSrqTriggerFunction.dat'
    href: 'https://func-ext-srq-dev.azurewebsites.net/admin/functions/CjisExtSrqTriggerFunction'
    config: {
      name: 'CjisExtSrqTriggerFunction'
      entryPoint: 'func_cjis_ext_seq_dev.CjisExtSrqTriggerFunction.CjisExtSrqTriggerFunctionAndSend'
      scriptFile: 'func-cjis-ext-srq.dll'
      language: 'dotnet-isolated'
      functionDirectory: ''
      bindings: [
        {
          name: 'message'
          type: 'serviceBusTrigger'
          direction: 'In'
          properties: {
            supportsDeferredBinding: 'True'
          }
          topicName: 'sbt-ext-srq'
          subscriptionName: 'func-ext-srq'
          connection: 'ServiceConnection'
          cardinality: 'One'
        }
      ]
    }
    language: 'dotnet-isolated'
    isDisabled: false
  }
}

resource sites_func_mni_rules_engine_dev_name_ExecuteMNIRules 'Microsoft.Web/sites/functions@2023-12-01' = {
  parent: sites_func_mni_rules_engine_dev_name_resource
  name: 'ExecuteMNIRules'
  location: 'West US 2'
  properties: {
    script_href: 'https://func-mni-rules-engine-dev.azurewebsites.net/admin/vfs/site/wwwroot/func-mni-rules-engine.exe'
    test_data_href: 'https://func-mni-rules-engine-dev.azurewebsites.net/admin/vfs/data/Functions/sampledata/ExecuteMNIRules.dat'
    href: 'https://func-mni-rules-engine-dev.azurewebsites.net/admin/functions/ExecuteMNIRules'
    config: {
      name: 'ExecuteMNIRules'
      entryPoint: 'func_mni_rules_engine.MNIRuleFunction.RunExecuteMNIRules'
      scriptFile: 'func-mni-rules-engine.exe'
      language: 'dotnet-isolated'
      functionDirectory: ''
      bindings: [
        {
          name: 'req'
          type: 'httpTrigger'
          direction: 'In'
          authLevel: 'User'
          methods: [
            'post'
          ]
        }
        {
          name: '$return'
          type: 'http'
          direction: 'Out'
        }
      ]
    }
    invoke_url_template: 'https://func-mni-rules-engine-dev.azurewebsites.net/api/executemnirules'
    language: 'dotnet-isolated'
    isDisabled: false
  }
}

resource sites_func_mni_rules_engine_dev_name_SetIDValue 'Microsoft.Web/sites/functions@2023-12-01' = {
  parent: sites_func_mni_rules_engine_dev_name_resource
  name: 'SetIDValue'
  location: 'West US 2'
  properties: {
    script_href: 'https://func-mni-rules-engine-dev.azurewebsites.net/admin/vfs/site/wwwroot/func-mni-rules-engine.exe'
    test_data_href: 'https://func-mni-rules-engine-dev.azurewebsites.net/admin/vfs/data/Functions/sampledata/SetIDValue.dat'
    href: 'https://func-mni-rules-engine-dev.azurewebsites.net/admin/functions/SetIDValue'
    config: {
      name: 'SetIDValue'
      entryPoint: 'func_mni_rules_engine.MNIRuleFunction.RunSetIDValue'
      scriptFile: 'func-mni-rules-engine.exe'
      language: 'dotnet-isolated'
      functionDirectory: ''
      bindings: [
        {
          name: 'req'
          type: 'httpTrigger'
          direction: 'In'
          authLevel: 'User'
          methods: [
            'post'
          ]
        }
        {
          name: '$return'
          type: 'http'
          direction: 'Out'
        }
      ]
    }
    invoke_url_template: 'https://func-mni-rules-engine-dev.azurewebsites.net/api/setidvalue'
    language: 'dotnet-isolated'
    isDisabled: false
  }
}

resource sites_func_core_srq_dev_name_sites_func_core_srq_dev_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: '${sites_func_core_srq_dev_name}.azurewebsites.net'
  location: 'West US 2'
  properties: {
    siteName: 'func-core-srq-dev'
    hostNameType: 'Verified'
  }
}

resource sites_func_ext_srq_dev_name_sites_func_ext_srq_dev_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2023-12-01' = {
  parent: sites_func_ext_srq_dev_name_resource
  name: '${sites_func_ext_srq_dev_name}.azurewebsites.net'
  location: 'West US 2'
  properties: {
    siteName: 'func-ext-srq-dev'
    hostNameType: 'Verified'
  }
}

resource sites_func_mni_rules_engine_dev_name_sites_func_mni_rules_engine_dev_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2023-12-01' = {
  parent: sites_func_mni_rules_engine_dev_name_resource
  name: '${sites_func_mni_rules_engine_dev_name}.azurewebsites.net'
  location: 'West US 2'
  properties: {
    siteName: 'func-mni-rules-engine-dev'
    hostNameType: 'Verified'
  }
}

resource privateDnsZones_privatelink_azurewebsites_net_name_be570285b503c 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZones_privatelink_azurewebsites_net_name_resource
  name: 'be570285b503c'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworks_vnet_cjis_services_dev_name_resource.id
    }
  }
}

resource privateEndpoints_pep_mni_rules_engine_name_resource 'Microsoft.Network/privateEndpoints@2023-11-01' = {
  name: privateEndpoints_pep_mni_rules_engine_name
  location: 'westus2'
  properties: {
    privateLinkServiceConnections: [
      {
        name: '${privateEndpoints_pep_mni_rules_engine_name}-8045'
        id: '${privateEndpoints_pep_mni_rules_engine_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_pep_mni_rules_engine_name}-8045'
        properties: {
          privateLinkServiceId: sites_func_mni_rules_engine_dev_name_resource.id
          groupIds: [
            'sites'
          ]
          privateLinkServiceConnectionState: {
            status: 'Disconnected'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    subnet: {
      id: virtualNetworks_vnet_cjis_services_dev_name_default.id
    }
    ipConfigurations: []
    customDnsConfigs: []
  }
}

resource privateEndpoints_pep_mni_rules_engine_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-11-01' = {
  name: '${privateEndpoints_pep_mni_rules_engine_name}/default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-azurewebsites-net'
        properties: {
          privateDnsZoneId: privateDnsZones_privatelink_azurewebsites_net_name_resource.id
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoints_pep_mni_rules_engine_name_resource
  ]
}

resource namespaces_sbns_cjis_connection_dev_name_hc_cjis_dev_defaultListener 'Microsoft.Relay/namespaces/hybridconnections/authorizationrules@2021-11-01' = {
  parent: namespaces_sbns_cjis_connection_dev_name_hc_cjis_dev
  name: 'defaultListener'
  location: 'westus2'
  properties: {
    rights: [
      'Listen'
    ]
  }
  dependsOn: [
    namespaces_sbns_cjis_connection_dev_name_resource
  ]
}

resource namespaces_sbns_cjis_connection_dev_name_hc_cjis_dev_defaultSender 'Microsoft.Relay/namespaces/hybridconnections/authorizationrules@2021-11-01' = {
  parent: namespaces_sbns_cjis_connection_dev_name_hc_cjis_dev
  name: 'defaultSender'
  location: 'westus2'
  properties: {
    rights: [
      'Send'
    ]
  }
  dependsOn: [
    namespaces_sbns_cjis_connection_dev_name_resource
  ]
}

resource namespaces_sbns_hub_dev_name_sbt_ext_srq_sas_ext_srq_listen 'Microsoft.ServiceBus/namespaces/topics/authorizationrules@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_sbt_ext_srq
  name: 'sas-ext-srq-listen'
  location: 'westus2'
  properties: {
    rights: [
      'Listen'
    ]
  }
  dependsOn: [
    namespaces_sbns_hub_dev_name_resource
  ]
}

resource namespaces_sbns_hub_dev_name_sbt_core_srq_func_core_srq 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_sbt_core_srq
  name: 'func-core-srq'
  location: 'westus2'
  properties: {
    isClientAffine: false
    lockDuration: 'PT1M'
    requiresSession: false
    defaultMessageTimeToLive: 'P1D'
    deadLetteringOnMessageExpiration: false
    deadLetteringOnFilterEvaluationExceptions: false
    maxDeliveryCount: 10
    status: 'Active'
    enableBatchedOperations: true
    autoDeleteOnIdle: 'P14D'
  }
  dependsOn: [
    namespaces_sbns_hub_dev_name_resource
  ]
}

resource namespaces_sbns_hub_dev_name_sbt_ext_srq_func_ext_srq 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_sbt_ext_srq
  name: 'func-ext-srq'
  location: 'westus2'
  properties: {
    isClientAffine: false
    lockDuration: 'PT1M'
    requiresSession: false
    defaultMessageTimeToLive: 'PT1H'
    deadLetteringOnMessageExpiration: false
    deadLetteringOnFilterEvaluationExceptions: false
    maxDeliveryCount: 10
    status: 'Active'
    enableBatchedOperations: true
    autoDeleteOnIdle: 'P10675198DT2H48M5.477S'
  }
  dependsOn: [
    namespaces_sbns_hub_dev_name_resource
  ]
}

resource namespaces_sbns_hub_dev_name_sbt_mni_caseinfo_mni_caseinfo_worker 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_sbt_mni_caseinfo
  name: 'mni-caseinfo-worker'
  location: 'westus2'
  properties: {
    isClientAffine: false
    lockDuration: 'PT1M'
    requiresSession: false
    defaultMessageTimeToLive: 'PT1H'
    deadLetteringOnMessageExpiration: false
    deadLetteringOnFilterEvaluationExceptions: false
    maxDeliveryCount: 10
    status: 'Active'
    enableBatchedOperations: true
    autoDeleteOnIdle: 'P14D'
  }
  dependsOn: [
    namespaces_sbns_hub_dev_name_resource
  ]
}

resource namespaces_sbns_hub_dev_name_sbt_mni_caseinfo_testonly 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_sbt_mni_caseinfo
  name: 'testonly'
  location: 'westus2'
  properties: {
    isClientAffine: false
    lockDuration: 'PT1M'
    requiresSession: false
    defaultMessageTimeToLive: 'P14D'
    deadLetteringOnMessageExpiration: false
    deadLetteringOnFilterEvaluationExceptions: false
    maxDeliveryCount: 10
    status: 'Active'
    enableBatchedOperations: true
    autoDeleteOnIdle: 'P14D'
  }
  dependsOn: [
    namespaces_sbns_hub_dev_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev968e_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource storageAccounts_rgcjishubdev9e17_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev9e17_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev9e17_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev968e_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource storageAccounts_rgcjishubdev9e17_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev9e17_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev9e17_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_cjis_maps 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev968e_name_default
  name: 'cjis-maps'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_cjis_schemas 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_rgcjishubdev968e_name_default
  name: 'cjis-schemas'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_black1999bmwa72f93 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev968e_name_default
  name: 'black1999bmwa72f93'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource Microsoft_Storage_storageAccounts_fileServices_shares_storageAccounts_rgcjishubdev968e_name_default_cjis_maps 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev968e_name_default
  name: 'cjis-maps'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_cj_test_file_share 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev968e_name_default
  name: 'cj-test-file-share'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_funccjiscoresrq20240520164038 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev968e_name_default
  name: 'funccjiscoresrq20240520164038'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_func_core_srq_dev 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev968e_name_default
  name: 'func-core-srq-dev'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_func_core_srq_dev_f3def42 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev968e_name_default
  name: 'func-core-srq-dev-f3def42'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_func_core_srq_dev_f3def4217fc 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev968e_name_default
  name: 'func-core-srq-dev-f3def4217fc'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource storageAccounts_rgcjishubdev9e17_name_default_func_ext_srqb3ea 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev9e17_name_default
  name: 'func-ext-srqb3ea'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev9e17_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_func_ext_srq_deva298 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev968e_name_default
  name: 'func-ext-srq-deva298'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_func_mni_rules_engine 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev968e_name_default
  name: 'func-mni-rules-engine'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource storageAccounts_rgcjishubdev968e_name_default_func_mni_rules_engine_dev 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgcjishubdev968e_name_default
  name: 'func-mni-rules-engine-dev'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_rgcjishubdev968e_name_resource
  ]
}

resource sites_func_core_srq_dev_name_slot1 'Microsoft.Web/sites/slots@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_resource
  name: 'slot1'
  location: 'West US 2'
  kind: 'functionapp'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: 'func-core-srq-dev-slot1.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: 'func-core-srq-dev-slot1.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_ASP_rgcjishubdev_89d1_name_resource.id
    reserved: false
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 1
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: '5CA75E45D5AF4EDCB56E5C61D3321A2B7010EF2EA511BD6873B3CC937F14DBEC'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_func_core_srq_dev_name_slot1_ftp 'Microsoft.Web/sites/slots/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_slot1
  name: 'ftp'
  location: 'West US 2'
  properties: {
    allow: true
  }
  dependsOn: [
    sites_func_core_srq_dev_name_resource
  ]
}

resource sites_func_core_srq_dev_name_slot1_scm 'Microsoft.Web/sites/slots/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_slot1
  name: 'scm'
  location: 'West US 2'
  properties: {
    allow: true
  }
  dependsOn: [
    sites_func_core_srq_dev_name_resource
  ]
}

resource sites_func_core_srq_dev_name_slot1_web 'Microsoft.Web/sites/slots/config@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_slot1
  name: 'web'
  location: 'West US 2'
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    netFrameworkVersion: 'v8.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    remoteDebuggingVersion: 'VS2019'
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$func-core-srq-dev__slot1'
    scmType: 'None'
    use32BitWorkerProcess: false
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 1
    functionAppScaleLimit: 0
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 1
    azureStorageAccounts: {}
  }
  dependsOn: [
    sites_func_core_srq_dev_name_resource
  ]
}

resource sites_func_core_srq_dev_name_slot1_sites_func_core_srq_dev_name_slot1_azurewebsites_net 'Microsoft.Web/sites/slots/hostNameBindings@2023-12-01' = {
  parent: sites_func_core_srq_dev_name_slot1
  name: '${sites_func_core_srq_dev_name}-slot1.azurewebsites.net'
  location: 'West US 2'
  properties: {
    siteName: 'func-core-srq-dev(slot1)'
    hostNameType: 'Verified'
  }
  dependsOn: [
    sites_func_core_srq_dev_name_resource
  ]
}

resource namespaces_sbns_hub_dev_name_sbt_core_srq_func_core_srq_Default 'Microsoft.ServiceBus/namespaces/topics/subscriptions/rules@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_sbt_core_srq_func_core_srq
  name: '$Default'
  location: 'westus2'
  properties: {
    action: {}
    filterType: 'SqlFilter'
    sqlFilter: {
      sqlExpression: '1=1'
      compatibilityLevel: 20
    }
  }
  dependsOn: [
    namespaces_sbns_hub_dev_name_sbt_core_srq
    namespaces_sbns_hub_dev_name_resource
  ]
}

resource namespaces_sbns_hub_dev_name_sbt_ext_srq_func_ext_srq_Default 'Microsoft.ServiceBus/namespaces/topics/subscriptions/rules@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_sbt_ext_srq_func_ext_srq
  name: '$Default'
  location: 'westus2'
  properties: {
    action: {}
    filterType: 'SqlFilter'
    sqlFilter: {
      sqlExpression: '1=1'
      compatibilityLevel: 20
    }
  }
  dependsOn: [
    namespaces_sbns_hub_dev_name_sbt_ext_srq
    namespaces_sbns_hub_dev_name_resource
  ]
}

resource namespaces_sbns_hub_dev_name_sbt_mni_caseinfo_mni_caseinfo_worker_Default 'Microsoft.ServiceBus/namespaces/topics/subscriptions/rules@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_sbt_mni_caseinfo_mni_caseinfo_worker
  name: '$Default'
  location: 'westus2'
  properties: {
    action: {}
    filterType: 'SqlFilter'
    sqlFilter: {
      sqlExpression: '1=1'
      compatibilityLevel: 20
    }
  }
  dependsOn: [
    namespaces_sbns_hub_dev_name_sbt_mni_caseinfo
    namespaces_sbns_hub_dev_name_resource
  ]
}

resource namespaces_sbns_hub_dev_name_sbt_mni_caseinfo_testonly_Default 'Microsoft.ServiceBus/namespaces/topics/subscriptions/rules@2022-10-01-preview' = {
  parent: namespaces_sbns_hub_dev_name_sbt_mni_caseinfo_testonly
  name: '$Default'
  location: 'westus2'
  properties: {
    action: {}
    filterType: 'SqlFilter'
    sqlFilter: {
      sqlExpression: '1=1'
      compatibilityLevel: 20
    }
  }
  dependsOn: [
    namespaces_sbns_hub_dev_name_sbt_mni_caseinfo
    namespaces_sbns_hub_dev_name_resource
  ]
}
