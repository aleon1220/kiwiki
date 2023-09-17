- [EC2](#ec2)
      - [Get account Id and region of current EC2 instance JQ](#get-account-id-and-region-of-current-ec2-instance-jq)
      - [List EC2 key pairs JQ](#list-ec2-key-pairs-jq)
      - [Get EC2 KeyPairs](#get-ec2-keypairs)
      - [How many instances of each type and in what states? JQ](#how-many-instances-of-each-type-and-in-what-states-jq)
      - [Find EC2 instance ID by instance Name](#find-ec2-instance-id-by-instance-name)
      - [Get Availability Zone, ID, Name, Private IP and Status](#get-availability-zone-id-name-private-ip-and-status)
      - [AWS EC2 metadata API interactions Get AWS EC2 metadata info](#aws-ec2-metadata-api-interactions-get-aws-ec2-metadata-info)
      - [Get security groups from AWS EC2](#get-security-groups-from-aws-ec2)
      - [Get public hostname](#get-public-hostname)
      - [Get profile](#get-profile)
      - [Describe instances using Tag values for keys Name and Environment](#describe-instances-using-tag-values-for-keys-name-and-environment)
    - [Create EC2 Instances with AWS CLI](#create-ec2-instances-with-aws-cli)
      - [1. Step 1: Find the right AMI JQ](#1-step-1-find-the-right-ami-jq)
      - [2. Step 2: Create a key pair, and hold on to it in a file:](#2-step-2-create-a-key-pair-and-hold-on-to-it-in-a-file)
      - [3. Step 3: Create the instance using the AMI and the key pair, and hold onto the result in a file:](#3-step-3-create-the-instance-using-the-ami-and-the-key-pair-and-hold-onto-the-result-in-a-file)
      - [4. Step 4: Grab the instance Id from the file JQ](#4-step-4-grab-the-instance-id-from-the-file-jq)
      - [5. Step 5: Wait for the instance to spin-up, then grab its IP address and hold onto it in an environment variable](#5-step-5-wait-for-the-instance-to-spin-up-then-grab-its-ip-address-and-hold-onto-it-in-an-environment-variable)
      - [6. Step 6: SSH and profit AWS](#6-step-6-ssh-and-profit-aws)
    - [EC2 EBS Volumes](#ec2-ebs-volumes)
      - [Find all snapshots over 1 month old JQ](#find-all-snapshots-over-1-month-old-jq)
      - [List snapshots over 1 month old in all Regions JQ](#list-snapshots-over-1-month-old-in-all-regions-jq)
      - [Find all publicly available snapshots in an AWS account in all Regions JQ](#find-all-publicly-available-snapshots-in-an-aws-account-in-all-regions-jq)
      - [Get the status of all volumes currently in the optimizing stage (after volume modification) in all Regions](#get-the-status-of-all-volumes-currently-in-the-optimizing-stage-after-volume-modification-in-all-regions)
      - [Find all volumes not attached to any instance in all Regions](#find-all-volumes-not-attached-to-any-instance-in-all-regions)
      - [Find all volumes in the "error" state in all Regions](#find-all-volumes-in-the-error-state-in-all-regions)
      - [List value associated with the 'Name' tag, Instance ID \& EBS Volume ID](#list-value-associated-with-the-name-tag-instance-id--ebs-volume-id)
      - [Details about EC2 instance and volume block](#details-about-ec2-instance-and-volume-block)
      - [List stopped instances and associated volumes.](#list-stopped-instances-and-associated-volumes)
      - [How Many Gigabytes of Volumes do I have, by Status? JQ](#how-many-gigabytes-of-volumes-do-i-have-by-status-jq)
      - [How many Snapshots do I have? JQ](#how-many-snapshots-do-i-have-jq)
      - [How large are the snapshot in total? JQ](#how-large-are-the-snapshot-in-total-jq)
      - [How do they breakdown by the volume used to create them? JQ](#how-do-they-breakdown-by-the-volume-used-to-create-them-jq)
      - [Get the information: InstanceID, InstanceType and the value of the Name tag](#get-the-information-instanceid-instancetype-and-the-value-of-the-name-tag)
      - [Describing volumes](#describing-volumes)
      - [Describe volumes that are attached to a specific instance in another region](#describe-volumes-that-are-attached-to-a-specific-instance-in-another-region)
      - [AWS Regions](#aws-regions)
    - [Inventory questions about EC2 instances](#inventory-questions-about-ec2-instances)
    - [EC2 Elastic Load balancer](#ec2-elastic-load-balancer)
      - [List Load balancers by name](#list-load-balancers-by-name)
      - [Obtain the AWS ARN of a given LoadBalancer name](#obtain-the-aws-arn-of-a-given-loadbalancer-name)
      - [List target groups names that belong to a load balancer](#list-target-groups-names-that-belong-to-a-load-balancer)
      - [Get Target Groups ARNs part of a load balancer](#get-target-groups-arns-part-of-a-load-balancer)
      - [Register an EC2 instance in a target group](#register-an-ec2-instance-in-a-target-group)
  - [References](#references)

[Kiwiki Home](/../../)
# EC2
Elastic Cloud Compute
https://docs.aws.amazon.com/ec2/
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
aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId, InstanceType, ImageId,KeyName,State.Name,LaunchTime,Placement.AvailabilityZone,Placement.Tenancy,PrivateIpAddress,PrivateDnsName,PublicDnsName,PublicIpAddress,SubnetId,VpcId,[Tags[?Key==Name].Value] [0][0], [Tags[?Key==Environment].Value] [0][0] ]' --output text
```

### Create EC2 Instances with AWS CLI

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

### EC2 EBS Volumes

refer to [AWS CLI reference](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-volumes.html)

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
aws ec2 describe-instances --filters "Name=instance-state-name,Values=stopped" \
  --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value,InstanceId,BlockDeviceMappings[*].Ebs.VolumeId]' --output text
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
  --query 'Reservations[].Instances[].[InstanceId, InstanceType, [ Tags[?Key==Name].Value] [0][0] ]'
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
# ALL EC2 resources in environment test in NZ
aws ec2 describe-tags --filters Name="tag:environment:test",Values="NZ" --output table
```

- How many instances there are for Production, Staging or Development environments?
- Examine certain instance types and check if some of them, combined with a certain environment, are running -longer than expected
- Total amount of Volumes attached to an instance and what the total volume size for each instance is.

### EC2 Elastic Load balancer

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

## References
- [Create EC2 inventory CLI](https://superadmins.com/creating-ec2-inventory-with-aws-cli/)

[Back to top](#)

[Kiwiki Home](/../../)
