@description('The name of the subscription to create')
param subscriptionName string

@description('The name of the Service Bus namespace to create the subscription in')
param serviceBusNamespaceName string

@description('The name of the topic to create the subscription for')
param topicName string

@description('The SQL filter expression to apply to the subscription')
param sqlFilterExpression string = ''

@description('The name of the topic to forward messages to.  Leave blank to disable forwarding.')
param forwardToTopicName string = ''

var fullSubscriptionName = '${serviceBusNamespaceName}/${topicName}/${subscriptionName}'

resource subscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2022-10-01-preview' = {
  name:fullSubscriptionName
  properties: {
    deadLetteringOnFilterEvaluationExceptions: true
    deadLetteringOnMessageExpiration: true
    defaultMessageTimeToLive: 'P7D'
    forwardTo: length(forwardToTopicName) > 0 ? forwardToTopicName : null
  }
}

resource rule 'Microsoft.ServiceBus/namespaces/topics/subscriptions/rules@2022-10-01-preview' = if(length(sqlFilterExpression) > 0) {
  name: 'default'
  parent: subscription
  properties: {
    filterType: 'SqlFilter'
    sqlFilter: {
      sqlExpression: sqlFilterExpression
    }
  }
}

output id string = subscription.id
output name string = subscription.name
