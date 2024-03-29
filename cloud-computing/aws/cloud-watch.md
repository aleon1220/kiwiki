- [AWS CloudWatch](#aws-cloudwatch)
    - [CloudWatch Agent](#cloudwatch-agent)
      - [cloudwatch agent Logs Location](#cloudwatch-agent-logs-location)
      - [log config file](#log-config-file)
    - [Cloudwatch Logs](#cloudwatch-logs)
      - [Exploring Log Streams JQ](#exploring-log-streams-jq)
      - [Get the first log stream JQ](#get-the-first-log-stream-jq)
      - [Loop through the groups and streams to get the last 10 messages since midnight JQ](#loop-through-the-groups-and-streams-to-get-the-last-10-messages-since-midnight-jq)
      - [AWS CloudWatch Logs set to 30 days](#aws-cloudwatch-logs-set-to-30-days)
    - [Logs Insights CloudTrail](#logs-insights-cloudtrail)
    - [Logs insights CloudTrail](#logs-insights-cloudtrail-1)
      - [Run the metric filter above in cloudwatch logs insights syntax](#run-the-metric-filter-above-in-cloudwatch-logs-insights-syntax)
    - [Logs Insights EC2](#logs-insights-ec2)
    - [Logs Insights RDS](#logs-insights-rds)
  - [References](#references)

[Kiwiki Home](/../../)
# AWS CloudWatch
Management & Governance
https://docs.aws.amazon.com/cloudwatch/
### CloudWatch Agent

gathers metadata in `AWS EC2` instances

#### cloudwatch agent Logs Location

```bash
/opt/aws/amazon-cloudwatch-agent/etc/
/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log
```

#### log config file

```bash
less /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.json
```

### Cloudwatch Logs

#### Exploring Log Streams JQ

```bash
logs=$(aws logs describe-log-groups | jq -r '.logGroups[].logGroupName')
```

#### Get the first log stream JQ

```bash
for each
for group in $logs; do echo $(aws logs describe-log-streams --log-group-name $group --order-by LastEventTime --descending --max-items 1 | \ 
 jq -r '.logStreams[0].logStreamName + " "'); done
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
- [What is CloudWatch Logs? - AWS CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html)
- [Filter and pattern syntax - AWS CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html)
- [Newest &#39;amazon-cloudwatchlogs&#39; Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/amazon-cloudwatchlogs)

[Back to top](#)

[Kiwiki Home](/../../)