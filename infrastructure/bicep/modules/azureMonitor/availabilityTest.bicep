@description('The name of the availability test to create.')
param availabilityTestName string

@description('The display name of the availability test to create.')
param availabilityTestDisplayName string

@description('The region wherethe availability test will be created.')
param location string

@description('The App Insights resource the availability test will be linked to')
param appInsightsResourceId string

@description('The URL to ping')
param urlToPing string

@description('The tags to be added to the availability test')
param tags object

var tagsToApply = union(tags, {
  'hidden-link:${appInsightsResourceId}': 'Resource'
})

resource at 'Microsoft.Insights/webtests@2022-06-15' = {
  name: availabilityTestName
  location: location
  tags: tagsToApply
  properties: {
    SyntheticMonitorId: availabilityTestName
    Name: availabilityTestDisplayName
    Enabled: true
    Frequency: 300
    Timeout: 30
    Kind: 'standard'
    RetryEnabled: true
    Locations: [
      {
        Id: 'us-fl-mia-edge'
      }
      {
        Id: 'us-va-ash-azr'
      }
      {
        Id: 'us-tx-sn1-azr'
      }
      {
        Id: 'us-il-ch1-azr'
      }
      {
        Id: 'apac-jp-kaw-edge'
      }
    ]
    Request: {
      RequestUrl: urlToPing
      HttpVerb: 'GET'
      ParseDependentRequests: false
    }
    ValidationRules: {
      ExpectedHttpStatusCode: 200
      IgnoreHttpStatusCode: false
      SSLCheck: true
      SSLCertRemainingLifetimeCheck: 30
    }
  }
}
