[Kiwiki Home](/../../)
[Back to Main Page](./readme.md)

# AWS CloudWatch
Management & Governance
https://docs.aws.amazon.com/cloudwatch/

## CloudWatch Agent

gathers metadata in `AWS EC2` instances

### Cloudwatch agent Logs Location

```bash
/opt/aws/amazon-cloudwatch-agent/etc/
/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log
```

#### Agent log config file

```bash
less /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.json
```
## Cloudwatch Alarms
```bash
aws cloudwatch set-alarm-state --alarm-name "CriblDev-CPU-High" --state-reason "Testing AWS Cloudwatch alarm" --state-value ALARM
```

## Cloudwatch Logs

#### List Log groups
Exploring Log Streams JQ
```bash
aws logs describe-log-groups | jq -r '.logGroups[].logGroupName'
```

#### Get log streams

```bash
logs=$(aws logs describe-log-groups | jq -r '.logGroups[].logGroupName')
for group in $logs; do echo $(aws logs describe-log-streams --log-group-name $group --order-by LastEventTime --descending --max-items 1 | jq -r '.logStreams[0].logStreamName + " "'); done
```

#### Loop through the groups and streams to get the last 10 messages since midnight JQ

```bash
for group in $logs; do for stream in $(aws logs describe-log-streams --log-group-name $group --order-by LastEventTime --descending --max-items 1 | \
 jq -r '[ .logStreams[0].logStreamName + " "] | add'); do echo ">>>"; echo GROUP: $group; \ 
echo STREAM: $stream; aws logs get-log-events --limit 10 --log-group-name $group --log-stream-name $stream --start-time $(date -d 'today 00:00:00' '+%s%N' | \
 cut -b1-13) | jq -r ".events[].message"; done; done
```

#### AWS CloudWatch Logs set to 30 days

```bash
for group in $(aws logs describe-log-groups --query "logGroups[].[logGroupName]" --output text --no-paginate); do aws logs put-retention-policy --log-group-name $group --retention-in-days 30; done;
```

### Logs Insights CloudTrail

The process is similar. You select your log groups and then run queries with a specific cloudwatch logs insights query syntax

### Logs insights CloudTrail

2022 unfortunately AWS uses different syntax styles for AWS CloudWatch Filter metric, Log groups metric filters and AWS Cloudwatch Log
insight

```bash
{ ($.errorCode = "*UnauthorizedOperation") || ($.errorCode = "AccessDenied*") }
```

#### Run the metric filter above in cloudwatch logs insights syntax

```bash
filter errorCode LIKE /UnauthorizedOperation/ or errorCode LIKE /AccessDenied/
| fields eventTime, errorCode, userIdentity.sessionContext.sessionIssuer.userName, eventName, eventSource, 
userAgent, errorMessage, @message
| limit 5000
```

### Logs Insights EC2

### Logs Insights RDS

```bash
fields @timestamp, @message
| sort @timestamp desc
| limit 1000
```
## References
- [What is AWS CloudWatch Logs?](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html)
- [AWS CloudWatch Logs Filter pattern syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html)
- [Stack Overflow AWS CloudWatch Logs](https://stackoverflow.com/questions/tagged/amazon-cloudwatchlogs)

[Back to top](#)

[Kiwiki Home](/../../)
