# AWS CLI commands

### [Kiwiki Home](./../readme.md)

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=3 orderedList=false} -->


<!-- code_chunk_output -->

- [AWS CLI commands](#aws-cli-commands)
  - [Kiwiki Home](#kiwiki-home)
  - [General AWS](#general-aws)
    - [Use cases for AWS CLI](#use-cases-for-aws-cli)
  - [AWS EC2 Elastic Compute Cloud](#aws-ec2-elastic-compute-cloud)
    - [AWS EC2 metadata API interactions](#aws-ec2-metadata-api-interactions)
    - [Creating EC2 Instances](#creating-ec2-instances)
    - [AWS EC2 Volumes EBS AWS CLI reference](#aws-ec2-volumes-ebs-aws-cli-reference)
    - [Inventory questions about EC2 instances](#inventory-questions-about-ec2-instances)
  - [AWS EC2 Elastic Load balancer](#aws-ec2-elastic-load-balancer)
  - [AWS IAM](#aws-iam)
  - [AWS VPC](#aws-vpc)
  - [AWS Code Commit](#aws-code-commit)
  - [AWS Lambda](#aws-lambda)
  - [AWS RDS Databases](#aws-rds-databases)
  - [AWS CF Cloud Formation](#aws-cf-cloud-formation)
  - [AWS CloudWatch](#aws-cloudwatch)
    - [AWS CloudWatch Agent info in `AWS EC2`](#aws-cloudwatch-agent-info-in-aws-ec2)
    - [Cloudwatch Logs](#cloudwatch-logs)
  - [AWS CloudWatch Logs set to 30 days](#aws-cloudwatch-logs-set-to-30-days)
  - [AWS S3](#aws-s3)
  - [AWS Secret Manager](#aws-secret-manager)

<!-- /code_chunk_output -->

### Use cases for AWS CLI

source obtained from this wonderful [Medium post by circuit People](https://medium.com/circuitpeople/aws-cli-with-jq-and-bash-9d54e2eabaf1)

### AWS CLI

#### Install AWS CLI2

follow [Install AWS CLI2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html)

#### Get current configs

File is usually located at `$HOME/.aws/config`

```bash
ls -lat $HOME/.aws/
```


```bash
aws configure list

```

#### How Many Services does AWS Have? JQ

```bash
curl -s https://raw.githubusercontent.com/boto/botocore/develop/botocore/data/endpoints.json | jq -r '.partitions[0].services | keys[]' | wc -l
```

## AWS EC2 Elastic Compute Cloud

#### Get account Id and region of current EC2 instance JQ

```bash
export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')
```

#### List EC2 key pairs JQ

```bash
aws ec2 describe-key-pairs | jq -r '.KeyPairs[].KeyName'
```

#### Get EC2 KeyPairs

```bash
aws ec2 describe-key-pairs --query 'KeyPairs[].KeyName'

```

#### How many instances of each type and in what states? JQ

```bash
aws ec2 describe-instances | \
  jq -r \
  "[ [.Reservations[].Instances[]|{ state: .State.Name, type: .InstanceType }] | group_by(.state)|.[]|{state: .[0].state, types: [.[].type] | [group_by(.)|.[]|{type: .[0], count: ([.[]]|length)}] }]"
```

#### Find EC2 instance ID by instance Name 

```bash
INSTANCE_NAME="ec2-rnd-prd-ec2"

aws ec2 describe-instances --filters "Name=tag:Name,Values=*$INSTANCE_NAME*" \ 
    --output text --query 'Reservations[*].Instances[*].InstanceId'
```

#### Get Availability Zone, ID, Name, Private IP and Status 

```bash
aws ec2 describe-instances \
--query 'Reservations[*].Instances[*].{Name:Tags[?Key==`Name`]|[0].Value,ID:InstanceId,AZ:Placement.AvailabilityZone,PrivIP:PrivateIpAddress,Status:State.Name}' --output table
```

#### AWS EC2 metadata API interactions Get AWS EC2 metadata info

```bash
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600") && \
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/
```

#### Get security groups from AWS EC2

```bash
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/security-groups
```

#### Get public hostname

```bash
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/public-hostname
```

#### Get profile

```bash
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/profile
```

#### Describe instances using Tag values for keys Name and Environment

```bash
 aws ec2 describe-instances \
--output text \
--query 'Reservations[].Instances[].[InstanceId, InstanceType, ImageId,
KeyName, State.Name, LaunchTime, Placement.AvailabilityZone, Placement.Tenancy,
PrivateIpAddress, PrivateDnsName, PublicDnsName, PublicIpAddress, SubnetId, VpcId,
[Tags[?Key==Name].Value] [0][0], [Tags[?Key==Environment].Value] [0][0] ]'
```

### Creating EC2 Instances

Quickly create EC2 instances.

#### 1. Step 1: Find the right AMI JQ

```bash
export AMI_ID=$(aws ec2 describe-images --owners amazon | jq -r ".Images[] | { id: .ImageId, desc: .Description } | select(.desc?) | select(.desc | contains(\"Amazon Linux 2\")) | select(.desc | contains(\".NET Core 2.1\")) | .id")
```

#### 2. Step 2: Create a key pair, and hold on to it in a file:

```bash
aws ec2 create-key-pair --key-name aurora-test-keypair > keypair.pem
```

#### 3. Step 3: Create the instance using the AMI and the key pair, and hold onto the result in a file:

```bash
aws ec2 run-instances --instance-type t2.micro --image-id $AMI_ID --region us-east-1 --subnet-id <your_subnet_id> --key-name keypair --count 1 > instance.json
```

#### 4. Step 4: Grab the instance Id from the file JQ

```bash
export INSTANCE_ID=$(jq -r .Instances[].InstanceId instance.json)
```

#### 5. Step 5: Wait for the instance to spin-up, then grab its IP address and hold onto it in an environment variable

```bash
export INSTANCE_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
```

#### 6. Step 6: SSH and profit AWS

```bash
ssh -i keypair.pem ec2-user@$INSTANCE_IP
```

### AWS EC2 EBS Volumes [AWS CLI reference](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-volumes.html)

- [AWS Premium questions](https://aws.amazon.com/premiumsupport/knowledge-center/ebs-volume-snapshot-ec2-instance/)

#### Find all snapshots over 1 month old JQ

```bash
aws ec2 describe-snapshots --owner self --output json | jq '.Snapshots[] | select(.StartTime < "'$(date --date='-1 month' '+%Y-%m-%d')'") | [.Description, .StartTime, .SnapshotId]'
```

#### List snapshots over 1 month old in all Regions JQ

```bash
for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; \
do echo $REGION && aws ec2 describe-snapshots --owner self --region $REGION --output json | \
jq '.Snapshots[] | select(.StartTime < "'$(date --date='-1 month' '+%Y-%m-%d')'") | \
 [.Description, .StartTime, .SnapshotId]' ; done
```

#### Find all publicly available snapshots in an AWS account in all Regions JQ

```bash
for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; do echo "$REGION:"; 
  for snap in $(aws ec2 describe-snapshots --owner self --output json --region $REGION --query 'Snapshots[*].SnapshotId' | jq -r '.[]';
   do aws ec2 describe-snapshot-attribute --snapshot-id $snap --region $REGION --output json --attribute createVolumePermission \
   --query '[SnapshotId,CreateVolumePermissions[?Group == `all`]]' | jq -r '.[]'; \
   done; 
   echo; 
   done
```

#### Get the status of all volumes currently in the optimizing stage (after volume modification) in all Regions

```bash
for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; \
do echo $REGION && aws ec2 describe-volumes-modifications \
--query 'VolumesModifications[].{VolumeID:VolumeId,TargetSize:TargetSize,OriginalSize:OriginalSize,Progress:Progress,OriginalIops:OriginalIops,TargetIops:TargetIops}' \
--output json --filter 'Name=modification-state,Values=optimizing' --region $REGION; done
```

#### Find all volumes not attached to any instance in all Regions

```bash
for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; \
 do echo $REGION && aws ec2 describe-volumes --filter "Name=status,Values=available" \ 
 --query 'Volumes[*].{VolumeID:VolumeId,Size:Size,Type:VolumeType,AvailabilityZone:AvailabilityZone}' \ 
 --region $REGION; done
```

#### Find all volumes in the "error" state in all Regions

```bash
for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; do echo $REGION && aws ec2 describe-volumes --filter "Name=status,Values=error" --query 'Volumes[*].{VolumeID:VolumeId,Size:Size,Type:VolumeType,AvailabilityZone:AvailabilityZone}' --region $REGION; done
```

#### List value associated with the 'Name' tag, Instance ID & EBS Volume ID

```bash
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value, InstanceId, BlockDeviceMappings[*].Ebs.VolumeId]' --output text
```

#### Details about EC2 instance and volume block

```bash
aws ec2 describe-instances --query 'Reservations[*].Instances[*].{Name:ImageId,InstanceId:InstanceId,VolumeInfo:BlockDeviceMappings}' --output json
```

#### List stopped instances and associated volumes.

Useful for clean up of cloud resources and cost savings

```bash
aws ec2 describe-instances --filters "Name=instance-state-name,Values=stopped" --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value,InstanceId,BlockDeviceMappings[*].Ebs.VolumeId]' --output text
```

#### How Many Gigabytes of Volumes do I have, by Status? JQ

```bash
aws ec2 describe-volumes | jq -r '.Volumes | [ group_by(.State)[] | { (.[0].State): ([.[].Size] | add) } ] | add'
```

#### How many Snapshots do I have? JQ

```bash
aws ec2 describe-snapshots --owner-ids self | jq '.Snapshots | length'
```

#### How large are the snapshot in total? JQ

```bash
aws ec2 describe-snapshots --owner-ids self | jq '[.Snapshots[].VolumeSize] | add'
```

#### How do they breakdown by the volume used to create them? JQ

```bash
aws ec2 describe-snapshots --owner-ids self | jq '.Snapshots | [ group_by(.VolumeId)[] | { (.[0].VolumeId): { "count": (.[] | length), "size": ([.[].VolumeSize] | add) } } ] | add'
```

#### Get the information: InstanceID, InstanceType and the value of the Name tag

```bash
INSTANCE_ID=""
aws ec2 describe-instances --instance-ids $INSTANCE_ID --output text \
  --query 'Reservations[].Instances[].[InstanceId, InstanceType, [Tags[?Key==Name].Value] [0][0] ]'
```

#### Describing volumes

```bash
aws ec2 describe-volumes \
--output text \
--filters "Name=status,Values=in-use" \
--query 'Volumes[*].[Attachments[0].InstanceId,VolumeId,Attachments[0].State,AvailabilityZone,Size,State,Iops,VolumeType]'
```

#### Describe volumes that are attached to a specific instance in another region

```bash
aws ec2 describe-volumes \
    --region ap-southeast-1 \
    --filters \
    Name=attachment.instance-id,Values=i-1234567890abcdef0  \
    Name=attachment.delete-on-termination,Values=true
```

#### AWS Regions

Describe AWS regions where you have access

```bash
aws ec2 describe-regions --output text --query 'Regions[].[RegionName]'
```

### Inventory questions about EC2 instances

- How many EC2 are running in each region?
- How many instances there are with a certain Tag name and value combination?

```bash
### ALL EC2 resources in environment Staging NZ
aws ec2 describe-tags --filters Name="tag:environment:staging",Values="NZ" --output table
```

- How many instances there are for Production, Staging or Development environments?
- Examine certain instance types and check if some of them, combined with a certain environment, are running -longer than expected
- Total amount of Volumes attached to an instance and what the total volume size for each instance is.

### AWS EC2 Elastic Load balancer

A Load balancer has rules. The rules point to target groups.
Target groups reference AWS EC2 instances.
The EC2 instance has a security group / Firewall

#### List Load balancers by name

```bash
aws elbv2 describe-load-balancers | jq .LoadBalancers[].LoadBalancerName
```

#### Obtain the AWS ARN of a given LoadBalancer name

```bash
LOAD_BALANCER_NAME="networklb-dev-internal"

aws elbv2 describe-load-balancers --names $LOAD_BALANCER_NAME --query 'LoadBalancers[*].LoadBalancerArn' --output text
```

#### List target groups names that belong to a load balancer

[AWS CLI target groups docs](https://docs.aws.amazon.com/cli/latest/reference/elbv2/describe-target-groups.html)

```bash
LB_ARN="LB ARN"

aws elbv2 describe-target-groups \
    --load-balancer-arn $LB_ARN  \
    --query 'TargetGroups[*].TargetGroupName' | jq

aws elbv2 describe-target-groups \
    --load-balancer-arn $LB_ARN | jq
```

#### Get Target Groups ARNs part of a load balancer

```bash
aws elbv2 describe-target-groups     \
--load-balancer-arn $LB_ARN      \
--query 'TargetGroups[*].TargetGroupArn' | jq
```

#### Register an EC2 instance in a target group

```bash
TG_ARN="arn:aws:elasticloadbalancing:us-east-1:1234567890:targetgroup/tg-dev-app-7999/122absljsdsd898"

aws elbv2 register-targets \
    --target-group-arn $TG_ARN \
    --targets Id=$EC2_INSTANCE_ID
```

## AWS IAM

#### When was my AWS user account created? JQ

```bash
aws iam get-user | jq -r ".User.CreateDate[:4]"
```

#### Which AWS Services am I using? JQ

```bash
aws ce get-cost-and-usage --time-period Start=$(date "+%Y-%m-01" -d "-1 Month"),End=$(date --date="$(date +'%Y-%m-01') - 1 second" -I) --granularity MONTHLY --metrics UsageQuantity --group-by Type=DIMENSION,Key=SERVICE | jq '.ResultsByTime[].Groups[] | select(.Metrics.UsageQuantity.Amount > 0) | .Keys[0]'
```

#### What is each service costing me? JQ

```bash
aws ce get-cost-and-usage --time-period Start=$(date "+%Y-%m-01"),End=$(date --date="$(date +'%Y-%m-01') + 1 month  - 1 second" -I) --granularity MONTHLY --metrics USAGE_QUANTITY BLENDED_COST  --group-by Type=DIMENSION,Key=SERVICE | jq '[ .ResultsByTime[].Groups[] | select(.Metrics.BlendedCost.Amount > "0") | { (.Keys[0]): .Metrics.BlendedCost } ] | sort_by(.Amount) | add'
```

## AWS VPC

#### What are my VPCs in table format

```bash
aws ec2 describe-vpcs --output table
```

#### What CIDRs have Ingress Access to which Ports? JQ

```bash
aws ec2 describe-security-groups | \
 jq '[ .SecurityGroups[].IpPermissions[] as $a | { "ports": [($a.FromPort|tostring),($a.ToPort|tostring)]|unique, "cidr": $a.IpRanges[].CidrIp } ] | [group_by(.cidr)[] | { (.[0].cidr): [.[].ports|join("-")]|unique }] | add'
```

## AWS Code Commit

#### How do I Create a CodeCommit Repository and Clone It?

```bash
export REPO_URL=$(aws codecommit create-repository --repository-name <name> | jq -r ".repositoryMetadata.cloneUrlHttp")

git clone $REPO_URL <name> && cd <name>
```

## AWS Lambda

#### Which Lambda Functions Runtimes am I Using? JQ

```bash
aws lambda list-functions | jq ".Functions | group_by(.Runtime)|[.[]|{ runtime:.[0].Runtime, functions:[.[]|.FunctionName] }]"
```

#### Are you exposing secrets in variables? Have a typo in a key? JQ

```bash
aws lambda list-functions | jq -r '[.Functions[] |{name: .FunctionName, env: .Environment.Variables}] | .[] | select(.env|length > 0)'
```

#### What logs does my Lambda Function generate when I run it? JQ

```bash
aws lambda invoke --function-name <function name> --payload '{}' --log-type Tail - | jq -r '{ "StatusCode": .StatusCode, "LogResult": (.LogResult|@base64d)}'
```

## AWS RDS Databases

#### What are my RDS Instance Endpoints? JQ

```bash
aws rds describe-db-instances | jq -r '.DBInstances[] | { (.DBInstanceIdentifier):(.Endpoint.Address + ":" + (.Endpoint.Port|tostring))}'
```

#### Describe RDS instances

```bash
aws rds describe-db-instances
```

#### Check logs for given instance

```bash
aws rds describe-db-log-files --db-instance-identifier $RDS_INSTANCE
```

## AWS CF Cloud Formation

Infrastructure as a configuration (not code)

#### How Many CloudFormation Stacks do I have in each Status? JQ

```bash
aws cloudformation list-stacks | jq  '.StackSummaries | [ group_by(.StackStatus)[] | { "status": .[0].StackStatus, "count": (. | length) }]'
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

### AWS CloudWatch Agent info in `AWS EC2`

#### Log Location

```bash
/opt/aws/amazon-cloudwatch-agent/etc/
/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log
```

#### log config file

```bash
less /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.json
```

### Cloudwatch Logs

#### Exploring Log Streams?

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

## AWS CloudWatch Logs set to 30 days

```bash
for group in $(aws logs describe-log-groups --query "logGroups[].[logGroupName]" --output text --no-paginate); do aws logs put-retention-policy --log-group-name $group --retention-in-days 30; done;
```

## AWS S3

#### List objects and sort by `LastModified` field

```bash
DATE=$(date +%Y-%m-%d)
aws s3api list-objects-v2 --bucket "$BUCKET" --query 'Contents[?contains(LastModified, `'"$DATE"'`)]'
```

#### List contents of a bucket and export to a text file

```bash
BUCKET="s3-bucket-name"
aws s3api list-objects-v2 --bucket "$BUCKET" --output text > "$BUCKET-Contents.txt"
```

#### List number of S3 buckes

```bash
printf "\n EC2 server name== $(hostname) \n\n" ; aws s3api list-buckets --color on --output table ; printf "\n\t Total number of S3 Bucket objects $(aws s3 ls | wc -l) \n"
```

#### Simplififed S3 listing of buckets

```bash
printf "\n local servername== $(hostname) \n" ; aws s3 ls ; printf "\n Total number of S3 buckets $(aws s3 ls | wc - l) \n\n"
```

#### Copy directories/files to S3 given bucket excuding .git files

```bash
aws s3 cp /tmp/foo s3://bucket/ --recursive --exclude ".git/*"
```

#### How Much Data is in Each of my Buckets?

```bash
for bucket in $(aws s3api list-buckets --query "Buckets[].Name" --output text); do aws cloudwatch get-metric-statistics --namespace AWS/S3 --metric-name BucketSizeBytes --dimensions Name=BucketName,Value=$bucket Name=StorageType,Value=StandardStorage --start-time $(date --iso-8601)T00:00 --end-time $(date --iso-8601)T23:59 --period 86400 --statistic Maximum | echo $bucket: $(numfmt --to si $(jq -r ".Datapoints[0].Maximum // 0")); done;
```

#### Prefer to have that is dollars per month?

```bash
AWS_PROFILE_USE="name-of-aws-profile"
for bucket in $(aws s3api list-buckets --query "Buckets[].Name" --output text --profile $AWS_PROFILE_USE); do aws cloudwatch get-metric-statistics --namespace AWS/S3 --metric-name BucketSizeBytes --dimensions Name=BucketName,Value=$bucket Name=StorageType,Value=StandardStorage --start-time $(date --iso-8601)T00:00 --end-time $(date --iso-8601)T23:59 --period 86400 --statistic Maximum --profile $AWS_PROFILE_USE | echo $bucket: \$$(jq -r "(.Datapoints[0].Maximum //
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
SECRET_NAME="my-aws-secret"
aws secretsmanager get-secret-value --secret-id $SECRET_NAME | jq -r '.SecretString' | jq -r 'keys[]'
```

[Back to top](#)

---

#### REFERENCES

- https://superadmins.com/creating-ec2-inventory-with-aws-cli/

[Back to top of Page](#)
