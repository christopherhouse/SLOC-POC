@description('The name of the queue to create')
param queueName string

@description('The name of the Service Bus namespace to create the queue in')
param serviceBusNamespaceName string

@description('The maximum size of the queue in megabytes')
param maxSizeInMegabytes int = 1024

@description('The maximum size of a message in kilobytes')
param maxMessageSizeInKilobytes int = 1024

@description('The maximum number of times a message can be delivered before being moved to the dead-letter queue')
param maxDeliveryCount int = 10

var fullQueueName = '${serviceBusNamespaceName}/${queueName}'

resource q 'Microsoft.ServiceBus/namespaces/queues@2022-10-01-preview' = {
  name: fullQueueName
  properties: {
    deadLetteringOnMessageExpiration: true
    maxSizeInMegabytes: maxSizeInMegabytes
    maxMessageSizeInKilobytes: maxMessageSizeInKilobytes
    maxDeliveryCount: maxDeliveryCount
  }
}
