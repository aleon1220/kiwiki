# AWS CLI commands

Use cases for AWS CLI
obtained from This wonderful [Medium post by circuit People](https://medium.com/circuitpeople/aws-cli-with-jq-and-bash-9d54e2eabaf1)
## When was my AWS user account created?
`aws iam get-user | jq -r ".User.CreateDate[:4]"` 

## Which AWS Services am I using?
```
aws ce get-cost-and-usage --time-period Start=$(date "+%Y-%m-01" -d "-1 Month"),End=$(date --date="$(date +'%Y-%m-01') - 1 second" -I) --granularity MONTHLY --metrics UsageQuantity --group-by Type=DIMENSION,Key=SERVICE | jq '.ResultsByTime[].Groups[] | select(.Metrics.UsageQuantity.Amount > 0) | .Keys[0]'
```

## What is each service costing me?
```
aws ce get-cost-and-usage --time-period Start=$(date "+%Y-%m-01"),End=$(date --date="$(date +'%Y-%m-01') + 1 month  - 1 second" -I) --granularity MONTHLY --metrics USAGE_QUANTITY BLENDED_COST  --group-by Type=DIMENSION,Key=SERVICE | jq '[ .ResultsByTime[].Groups[] | select(.Metrics.BlendedCost.Amount > "0") | { (.Keys[0]): .Metrics.BlendedCost } ] | sort_by(.Amount) | add'
```

## How many instances of each type do I have, and in what states?
```
aws ec2 describe-instances | jq -r "[[.Reservations[].Instances[]|{ state: .State.Name, type: .InstanceType }]|group_by(.state)|.[]|{state: .[0].state, types: [.[].type]|[group_by(.)|.[]|{type: .[0], count: ([.[]]|length)}] }]"
```

## What CIDRs have Ingress Access to which Ports?
```
aws ec2 describe-security-groups | jq '[ .SecurityGroups[].IpPermissions[] as $a | { "ports": [($a.FromPort|tostring),($a.ToPort|tostring)]|unique, "cidr": $a.IpRanges[].CidrIp } ] | [group_by(.cidr)[] | { (.[0].cidr): [.[].ports|join("-")]|unique }] | add'
```

## How do I Create a CodeCommit Repository and Clone It?
```

export REPO_URL=$(aws codecommit create-repository --repository-name <name> | jq -r ".repositoryMetadata.cloneUrlHttp")

git clone $REPO_URL <name> && cd <name>

```

## Which Lambda Functions Runtimes am I Using?
```
aws lambda list-functions | jq ".Functions | group_by(.Runtime)|[.[]|{ runtime:.[0].Runtime, functions:[.[]|.FunctionName] }
]"
```

## Are you exposing secrets in variables? Have a typo in a key?
```
aws lambda list-functions | jq -r '[.Functions[]|{name: .FunctionName, env: .Environment.Variables}]|.[]|select(.env|length > 0)'
```

### Creating EC2 Instances…
Quickly create EC2 instances.

#### Step 1: Find the right AMI
```
export AMI_ID=$(aws ec2 describe-images --owners amazon | jq -r ".Images[] | { id: .ImageId, desc: .Description } | select(.desc?) | select(.desc | contains(\"Amazon Linux 2\")) | select(.desc | contains(\".NET Core 2.1\")) | .id")
```

#### Step 2: Create a key pair, and hold on to it in a file:
`aws ec2 create-key-pair --key-name aurora-test-keypair > keypair.pem`

#### Step 3: Create the instance using the AMI and the key pair, and hold onto the result in a file:
```
aws ec2 run-instances --instance-type t2.micro --image-id $AMI_ID --region us-east-1 --subnet-id <your_subnet_id> --key-name keypair --count 1 > instance.json
```

#### Step 4: Grab the instance Id from the file:
`export INSTANCE_ID=$(jq -r .Instances[].InstanceId instance.json)`

#### Step 5: Wait for the instance to spin-up, then grab it’s IP address and hold onto it in an environment variable:
```
export INSTANCE_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
```

#### Step 6: SSH and profit:
`ssh -i keypair.pem ec2-user@$INSTANCE_IP`

## What are my RDS Instance Endpoints?
```
aws rds describe-db-instances | jq -r '.DBInstances[] | { (.DBInstanceIdentifier):(.Endpoint.Address + ":" + (.Endpoint.Port|tostring))}'
```

## How Many Services does AWS Have?
```
curl -s https://raw.githubusercontent.com/boto/botocore/develop/botocore/data/endpoints.json | jq -r '.partitions[0].services | keys[]' | wc -l
```

## How Many CloudFormation Stacks do I have in each Status?
```
aws cloudformation list-stacks | jq  '.StackSummaries | [ group_by(.StackStatus)[] | { "status": .[0].StackStatus, "count": (. | length) }
]'
```

## Which EC2 Instances were created by Stacks?
```
for stack in $(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE | jq -r '.StackSummaries[].StackName'); do aws cloudformation describe-stack-resources --stack-name $stack | jq -r '.StackResources[] | select (.ResourceType=="AWS::EC2::Instance")|.PhysicalResourceId'; done;
```

## How Many Gigabytes of Volumes do I have, by Status?
`aws ec2 describe-volumes | jq -r '.Volumes | [ group_by(.State)[] | { (.[0].State): ([.[].Size] | add) } ] | add'`

## How many Snapshots do I have?
`aws ec2 describe-snapshots --owner-ids self | jq '.Snapshots | length'`

## how large are the snapshot in total?
`aws ec2 describe-snapshots --owner-ids self | jq '[.Snapshots[].VolumeSize] | add'`

### how do they breakdown by the volume used to create them?
```
aws ec2 describe-snapshots --owner-ids self | jq '.Snapshots | [ group_by(.VolumeId)[] | { (.[0].VolumeId): { "count": (.[] | length), "size": ([.[].VolumeSize] | add) } } ] | add'
```
# AWS CloudWatch
## What’s happening in my Log Streams?
`logs=$(aws logs describe-log-groups | jq -r '.logGroups[].logGroupName')`

##  The first log stream for each
for group in $logs; do echo $(aws logs describe-log-streams --log-group-name $group --order-by LastEventTime --descending --max-items 1 | jq -r '.logStreams[0].logStreamName + " "'); done

## loop through the groups and streams and get the last 10 messages since midnight
```
for group in $logs; do for stream in $(aws logs describe-log-streams --log-group-name $group --order-by LastEventTime --descending --max-items 1 | jq -r '[ .logStreams[0].logStreamName + " "] | add'); do echo ">>>"; echo GROUP: $group; echo STREAM: $stream; aws logs get-log-events --limit 10 --log-group-name $group --log-stream-name $stream --start-time $(date -d 'today 00:00:00' '+%s%N' | cut -b1-13) | jq -r ".events[].message"; done; done
```

## AWS CloudWatch Logs set to 30 days
```
for group in $(aws logs describe-log-groups --query "logGroups[].[logGroupName]" --output text --no-paginate); do aws logs put-retention-policy --log-group-name $group --retention-in-days 30; done;
```

## What logs does my Lambda Function generate when I run it?
```
aws lambda invoke --function-name <function name> --payload '{}' --log-type Tail - | jq -r '{ "StatusCode": .StatusCode, "LogResult": (.LogResult|@base64d)}'
```

## How Much Data is in Each of my Buckets?
```
for bucket in $(aws s3api list-buckets --query "Buckets[].Name" --output text); do aws cloudwatch get-metric-statistics --namespace AWS/S3 --metric-name BucketSizeBytes --dimensions Name=BucketName,Value=$bucket Name=StorageType,Value=StandardStorage --start-time $(date --iso-8601)T00:00 --end-time $(date --iso-8601)T23:59 --period 86400 --statistic Maximum | echo $bucket: $(numfmt --to si $(jq -r ".Datapoints[0].Maximum // 0")); done;
```

### Prefer to have that is dollars per month?
```
for bucket in $(aws s3api list-buckets --query "Buckets[].Name" --output text --profile eleven-prod); do aws cloudwatch get-metric-statistics --namespace AWS/S3 --metric-name BucketSizeBytes --dimensions Name=BucketName,Value=$bucket Name=StorageType,Value=StandardStorage --start-time $(date --iso-8601)T00:00 --end-time $(date --iso-8601)T23:59 --period 86400 --statistic Maximum --profile eleven-prod | echo $bucket: \$$(jq -r "(.Datapoints[0].Maximum //
 0) * .023 / (1024*1024*1024) * 100.0 | floor / 100.0"); done;
 ```