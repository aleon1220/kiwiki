
# AWS CLI commands

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=3 orderedList=false} -->

<!-- code_chunk_output -->

- [AWS CLI commands](#aws-cli-commands)
    - [Use cases for AWS CLI](#use-cases-for-aws-cli)
  - [General AWS](#general-aws)
  - [AWS EC2 Elastic Compute Cloud](#aws-ec2-elastic-compute-cloud)
    - [AWS EC2 metadata API interactions](#aws-ec2-metadata-api-interactions)
    - [Creating EC2 Instances](#creating-ec2-instances)
    - [AWS EC2 Volumes](#aws-ec2-volumes)
    - [Inventory questions about EC2 instances](#inventory-questions-about-ec2-instances)
  - [AWS IAM](#aws-iam)
  - [AWS VPC](#aws-vpc)
  - [AWS Lambda](#aws-lambda)
  - [AWS RDS Databases](#aws-rds-databases)
  - [AWS CF Cloud Formation](#aws-cf-cloud-formation)
  - [AWS CloudWatch](#aws-cloudwatch)
    - [CloudWatch Agent info in EC2](#cloudwatch-agent-info-in-ec2)
    - [Cloudwatch Logs](#cloudwatch-logs)
  - [AWS CloudWatch Logs set to 30 days](#aws-cloudwatch-logs-set-to-30-days)
  - [AWS S3](#aws-s3)

<!-- /code_chunk_output -->

### Use cases for AWS CLI
source obtained from this wonderful [Medium post by circuit People](https://medium.com/circuitpeople/aws-cli-with-jq-and-bash-9d54e2eabaf1)

#### installation AWS CLI2
follow [Install AWS CLI2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html)

## General AWS
#### Get current configs. 
File is usually located at `$HOME/.aws/config`
`aws configure list`

#### How Many Services does AWS Have?
```bash
curl -s https://raw.githubusercontent.com/boto/botocore/develop/botocore/data/endpoints.json | jq -r '.partitions[0].services | keys[]' | wc -l
```

## AWS EC2 Elastic Compute Cloud
#### Get account Id and region of current EC2 instance
``` bash
export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')
```

#### List EC2 key pairs
```bash
aws ec2 describe-key-pairs | jq -r '.KeyPairs[].KeyName'
```

#### How many instances of each type do I have, and in what states?
```bash
aws ec2 describe-instances | jq -r "[[.Reservations[].Instances[]|{ state: .State.Name, type: .InstanceType }]|group_by(.state)|.[]|{state: .[0].state, types: [.[].type]|[group_by(.)|.[]|{type: .[0], count: ([.[]]|length)}] }]"
```

### AWS EC2 metadata API interactions

```bash
#### Get AWS EC2 metadata info
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600") && \
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/

#### Get security groups from AWS EC2
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/security-groups

#### Get public hostname
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/public-hostname

#### Get profile
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/profile
```

### Creating EC2 Instances
Quickly create EC2 instances.

#### Step 1: Find the right AMI
```bash
export AMI_ID=$(aws ec2 describe-images --owners amazon | jq -r ".Images[] | { id: .ImageId, desc: .Description } | select(.desc?) | select(.desc | contains(\"Amazon Linux 2\")) | select(.desc | contains(\".NET Core 2.1\")) | .id")
```

#### Step 2: Create a key pair, and hold on to it in a file:
`aws ec2 create-key-pair --key-name aurora-test-keypair > keypair.pem`

#### Step 3: Create the instance using the AMI and the key pair, and hold onto the result in a file:
```bash
aws ec2 run-instances --instance-type t2.micro --image-id $AMI_ID --region us-east-1 --subnet-id <your_subnet_id> --key-name keypair --count 1 > instance.json
```

#### Step 4: Grab the instance Id from the file:
`export INSTANCE_ID=$(jq -r .Instances[].InstanceId instance.json)`

#### Step 5: Wait for the instance to spin-up, then grab it’s IP address and hold onto it in an environment variable:
```
export INSTANCE_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
```

#### Step 6: SSH and profit AWS
`ssh -i keypair.pem ec2-user@$INSTANCE_IP`

### AWS EC2 Volumes

#### How Many Gigabytes of Volumes do I have, by Status?
```bash
aws ec2 describe-volumes | jq -r '.Volumes | [ group_by(.State)[] | { (.[0].State): ([.[].Size] | add) } ] | add'
```

#### How many Snapshots do I have?
`aws ec2 describe-snapshots --owner-ids self | jq '.Snapshots | length'`

#### how large are the snapshot in total?
`aws ec2 describe-snapshots --owner-ids self | jq '[.Snapshots[].VolumeSize] | add'`

#### how do they breakdown by the volume used to create them?
```bash
aws ec2 describe-snapshots --owner-ids self | jq '.Snapshots | [ group_by(.VolumeId)[] | { (.[0].VolumeId): { "count": (.[] | length), "size": ([.[].VolumeSize] | add) } } ] | add'
```

#### get the information like: InstanceID, InstanceType and the value of the Name tag
```bash
INST_ID=""
aws ec2 describe-instances --instance-ids $INST_ID --output text --query 'Reservations[].Instances[].[InstanceId, InstanceType, [Tags[?Key==Name].Value] [0][0] ]'
```

#### extracting Tag values
```bash
 aws ec2 describe-instances \
--output text \
--query 'Reservations[].Instances[].[InstanceId, InstanceType, ImageId,
KeyName, State.Name, LaunchTime, Placement.AvailabilityZone, Placement.Tenancy,
PrivateIpAddress, PrivateDnsName, PublicDnsName, PublicIpAddress, SubnetId, VpcId,
[Tags[?Key==Name].Value] [0][0], [Tags[?Key==Environment].Value] [0][0] ]'
```

#### Describing volumes
```bash
aws ec2 describe-volumes \
--output text \
--filters "Name=status,Values=in-use" \
--query 'Volumes[*].[Attachments[0].InstanceId,VolumeId,Attachments[0].State,
AvailabilityZone,Size,State,Iops,VolumeType]'
```

#### region
`ec2 describe-regions --output text --query 'Regions[].[RegionName]'`

### Inventory questions about EC2 instances
- how many are running in each region?
- how many instances there are with a certain Tag name and value combination?
- how many instances there are for Production, Staging or Development environments?
- examine certain instance types and check if some of them, combined with a certain environment, are running -longer than expected
-  total amount of Volumes attached to an instance and what the total volume size for each instance is.





## AWS IAM
#### When was my AWS user account created?
`aws iam get-user | jq -r ".User.CreateDate[:4]"` 

#### Which AWS Services am I using?
```bash
aws ce get-cost-and-usage --time-period Start=$(date "+%Y-%m-01" -d "-1 Month"),End=$(date --date="$(date +'%Y-%m-01') - 1 second" -I) --granularity MONTHLY --metrics UsageQuantity --group-by Type=DIMENSION,Key=SERVICE | jq '.ResultsByTime[].Groups[] | select(.Metrics.UsageQuantity.Amount > 0) | .Keys[0]'
```

#### What is each service costing me?
```bash
aws ce get-cost-and-usage --time-period Start=$(date "+%Y-%m-01"),End=$(date --date="$(date +'%Y-%m-01') + 1 month  - 1 second" -I) --granularity MONTHLY --metrics USAGE_QUANTITY BLENDED_COST  --group-by Type=DIMENSION,Key=SERVICE | jq '[ .ResultsByTime[].Groups[] | select(.Metrics.BlendedCost.Amount > "0") | { (.Keys[0]): .Metrics.BlendedCost } ] | sort_by(.Amount) | add'
```

## AWS VPC

#### What are my VPCs in table format
`aws ec2 describe-vpcs --output table`

#### What CIDRs have Ingress Access to which Ports?
```bash
aws ec2 describe-security-groups | jq '[ .SecurityGroups[].IpPermissions[] as $a | { "ports": [($a.FromPort|tostring),($a.ToPort|tostring)]|unique, "cidr": $a.IpRanges[].CidrIp } ] | [group_by(.cidr)[] | { (.[0].cidr): [.[].ports|join("-")]|unique }] | add'
```

#### How do I Create a CodeCommit Repository and Clone It?
```bash
export REPO_URL=$(aws codecommit create-repository --repository-name <name> | jq -r ".repositoryMetadata.cloneUrlHttp")

git clone $REPO_URL <name> && cd <name>
```
## AWS Lambda
#### Which Lambda Functions Runtimes am I Using?
```bash
aws lambda list-functions | jq ".Functions | group_by(.Runtime)|[.[]|{ runtime:.[0].Runtime, functions:[.[]|.FunctionName] }
]"
```

#### Are you exposing secrets in variables? Have a typo in a key?
```bash
aws lambda list-functions | jq -r '[.Functions[] |{name: .FunctionName, env: .Environment.Variables}] | .[] | select(.env|length > 0)'
```

#### What logs does my Lambda Function generate when I run it?
```bash
aws lambda invoke --function-name <function name> --payload '{}' --log-type Tail - | jq -r '{ "StatusCode": .StatusCode, "LogResult": (.LogResult|@base64d)}'
```

## AWS RDS Databases
#### What are my RDS Instance Endpoints?
```bash
aws rds describe-db-instances | jq -r '.DBInstances[] | { (.DBInstanceIdentifier):(.Endpoint.Address + ":" + (.Endpoint.Port|tostring))}'
```

## AWS CF Cloud Formation 
Infrastructure as a configuration

#### How Many CloudFormation Stacks do I have in each Status?
```bash
aws cloudformation list-stacks | jq  '.StackSummaries | [ group_by(.StackStatus)[] | { "status": .[0].StackStatus, "count": (. | length) }
]'
```

#### Number of cloudformation stack objects
```bash
exec env TERM='dumb' INSIDE_EMACS='26.1,tramp:2.3.3.26.1' ENV='' HISTFILE=~/.tramp_history PROMPT_COMMAND='' PS1=\#\$\  PS2='' PS3='' /bin/sh
aws cloudformation describe-stack-events --stack-name $MY_CLOUDFORMATION_STACKNAME | jq lenght
```

#### Which EC2 Instances were created by AWS CF Stacks?
```bash
for stack in $(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE | jq -r '.StackSummaries[].StackName'); do aws cloudformation describe-stack-resources --stack-name $stack | jq -r '.StackResources[] | select (.ResourceType=="AWS::EC2::Instance")|.PhysicalResourceId'; done;
```

## AWS CloudWatch
### CloudWatch Agent info in EC2
#### Log Location
```bash
/opt/aws/amazon-cloudwatch-agent/etc/
/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log
```

#### log config file 
`amazon-cloudwatch-agent.json`

### Cloudwatch Logs
#### What’s happening in my Log Streams?
`logs=$(aws logs describe-log-groups | jq -r '.logGroups[].logGroupName')`

#### Get the first log stream 
```bash
for each
for group in $logs; do echo $(aws logs describe-log-streams --log-group-name $group --order-by LastEventTime --descending --max-items 1 | jq -r '.logStreams[0].logStreamName + " "'); done
```

#### loop through the groups and streams to get the last 10 messages since midnight
```bash
for group in $logs; do for stream in $(aws logs describe-log-streams --log-group-name $group --order-by LastEventTime --descending --max-items 1 | jq -r '[ .logStreams[0].logStreamName + " "] | add'); do echo ">>>"; echo GROUP: $group; echo STREAM: $stream; aws logs get-log-events --limit 10 --log-group-name $group --log-stream-name $stream --start-time $(date -d 'today 00:00:00' '+%s%N' | cut -b1-13) | jq -r ".events[].message"; done; done
```

## AWS CloudWatch Logs set to 30 days
```bash
for group in $(aws logs describe-log-groups --query "logGroups[].[logGroupName]" --output text --no-paginate); do aws logs put-retention-policy --log-group-name $group --retention-in-days 30; done;
```

## AWS S3
#### How Much Data is in Each of my Buckets?
```bash
for bucket in $(aws s3api list-buckets --query "Buckets[].Name" --output text); do aws cloudwatch get-metric-statistics --namespace AWS/S3 --metric-name BucketSizeBytes --dimensions Name=BucketName,Value=$bucket Name=StorageType,Value=StandardStorage --start-time $(date --iso-8601)T00:00 --end-time $(date --iso-8601)T23:59 --period 86400 --statistic Maximum | echo $bucket: $(numfmt --to si $(jq -r ".Datapoints[0].Maximum // 0")); done;
```

#### Prefer to have that is dollars per month?
```bash
for bucket in $(aws s3api list-buckets --query "Buckets[].Name" --output text --profile eleven-prod); do aws cloudwatch get-metric-statistics --namespace AWS/S3 --metric-name BucketSizeBytes --dimensions Name=BucketName,Value=$bucket Name=StorageType,Value=StandardStorage --start-time $(date --iso-8601)T00:00 --end-time $(date --iso-8601)T23:59 --period 86400 --statistic Maximum --profile eleven-prod | echo $bucket: \$$(jq -r "(.Datapoints[0].Maximum //
 0) * .023 / (1024*1024*1024) * 100.0 | floor / 100.0"); done;
 ```

## AWS Secret Manager
#### Create a secret with a binary file in this case a java keystore JKS

```bash
SECRET_ID="arn:12312312:xxxxx"
BINARY_FILE="mykeystore.jks"

aws secretsmanager put-secret-value --secret-id $SECRET_ID --secret-binary fileb://$BINARY_FILE
```

#### Create a secret as a key and value format from a json file
```bash
aws secretsmanager put-secret-value --secret-id $SECRET_ID --secret-string file://secret.json
```

#### Obtain a secret that contains JSON data as a SecretString and list the JSON keys
```bash
$SECRET_NAME=my-aws-secret
aws secretsmanager get-secret-value --secret-id $SECRET_NAME | jq -r '.SecretString' | jq -r 'keys[]'
```

[Back to top](#)

---
#### REFERENCES
- https://superadmins.com/creating-ec2-inventory-with-aws-cli/