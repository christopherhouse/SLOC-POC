@description('The name of the topic to create')
param topicName string

@description('The name of the Service Bus namespace to create the topic in')
param serviceBusNamespaceName string

@description('The maximum size of the topic in megabytes')
param maxTopicSize int = 1024

var topicFullName = '${serviceBusNamespaceName}/${topicName}'

resource topic 'Microsoft.ServiceBus/namespaces/topics@2022-10-01-preview' = {
  name: topicFullName
  properties: {
    maxSizeInMegabytes: maxTopicSize
  }
}

output id string = topic.id
output name string = topic.name
