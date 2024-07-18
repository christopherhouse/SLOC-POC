using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;

namespace SbUamiPoc
{
    public class Function1
    {
        [FunctionName("Function1")]
        public void Run([ServiceBusTrigger("mytopic", "mysubscription", Connection = "sbConnection")]string mySbMsg, ILogger log)
        {
            log.LogWarning($"C# ServiceBus topic trigger function processed message: {mySbMsg}");
        }
    }
}
