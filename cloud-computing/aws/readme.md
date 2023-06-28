# AWS CLI commands

<!-- code_chunk_output -->

- [AWS CLI commands](#aws-cli-commands)
- [Introduction](#introduction)
  - [AWS Amazon Web services General](#aws-amazon-web-services-general)
      - [How Many Services does AWS Have? JQ](#how-many-services-does-aws-have-jq)
  - [AWS CLI](#aws-cli)
      - [Install AWS CLI](#install-aws-cli)
      - [List AWS CLI config directory](#list-aws-cli-config-directory)
      - [Get current AWS CLI configuration](#get-current-aws-cli-configuration)
      - [use a named profile](#use-a-named-profile)
      - [give the aws cli flag](#give-the-aws-cli-flag)
- [C](#c)
  - [AWS Code Commit](#aws-code-commit)
  - [Code Commit cheat sheet](#code-commit-cheat-sheet)
  - [AWS CF Cloud Formation](#aws-cf-cloud-formation)
  - [AWS CloudWatch](#aws-cloudwatch)
- [E](#e)
  - [AWS EC2 Elastic Compute Cloud](#aws-ec2-elastic-compute-cloud)
- [I](#i)
  - [AWS IAM](#aws-iam)
      - [When was my AWS user account created? JQ](#when-was-my-aws-user-account-created-jq)
      - [Which AWS Services am I using? JQ](#which-aws-services-am-i-using-jq)
      - [What is each service costing me? JQ](#what-is-each-service-costing-me-jq)
- [\[L\]](#l)
  - [AWS Lambda](#aws-lambda)
      - [Which Lambda Functions Runtimes am I Using? JQ](#which-lambda-functions-runtimes-am-i-using-jq)
      - [Are you exposing secrets in variables? Have a typo in a key? JQ](#are-you-exposing-secrets-in-variables-have-a-typo-in-a-key-jq)
      - [What logs does my Lambda Function generate when I run it? JQ](#what-logs-does-my-lambda-function-generate-when-i-run-it-jq)
- [R](#r)
  - [AWS RDS Databases](#aws-rds-databases)
      - [What are my RDS Instance Endpoints? JQ](#what-are-my-rds-instance-endpoints-jq)
      - [Describe RDS instances](#describe-rds-instances)
      - [Check logs for given instance](#check-logs-for-given-instance)
- [S](#s)
  - [AWS S3](#aws-s3)
      - [List objects and sort by `LastModified` field](#list-objects-and-sort-by-lastmodified-field)
      - [List contents of a bucket and export to a text file](#list-contents-of-a-bucket-and-export-to-a-text-file)
      - [List number of S3 buckes](#list-number-of-s3-buckes)
      - [Simplififed S3 listing of buckets](#simplififed-s3-listing-of-buckets)
      - [Copy directories/files to S3 given bucket excuding .git files](#copy-directoriesfiles-to-s3-given-bucket-excuding-git-files)
      - [How Much Data is in Each of my Buckets?](#how-much-data-is-in-each-of-my-buckets)
      - [Prefer to have that is dollars per month?](#prefer-to-have-that-is-dollars-per-month)
  - [AWS Secret Manager](#aws-secret-manager)
      - [Create a secret with a binary file in this case a java keystore JKS](#create-a-secret-with-a-binary-file-in-this-case-a-java-keystore-jks)
      - [Create a secret as a key and value format from a json file](#create-a-secret-as-a-key-and-value-format-from-a-json-file)
      - [Obtain a secret that contains JSON data as a SecretString and list the JSON keys](#obtain-a-secret-that-contains-json-data-as-a-secretstring-and-list-the-json-keys)
- [V](#v)
  - [AWS VPC](#aws-vpc)
      - [What are my VPCs in table format](#what-are-my-vpcs-in-table-format)
      - [What CIDRs have Ingress Access to which Ports? JQ](#what-cidrs-have-ingress-access-to-which-ports-jq)
      - [REFERENCES](#references)

<!-- /code_chunk_output -->

# Introduction

AWS CLI commands for some AWS services. AWS service names Sorted from A-Z
source obtained from this wonderful [Medium post by circuit People](https://medium.com/circuitpeople/aws-cli-with-jq-and-bash-9d54e2eabaf1)

## AWS Amazon Web services General

#### How Many Services does AWS Have? JQ

```bash
curl -s https://raw.githubusercontent.com/boto/botocore/develop/botocore/data/endpoints.json | jq -r '.partitions[0].services | keys[]' | wc -l
```

## AWS CLI

#### Install AWS CLI

Amazon Web Services Command Line Interface client

follow [Install AWS CLI2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html)

#### List AWS CLI config directory

File is usually located at `$HOME/.aws/config`

```bash
ls -lat $HOME/.aws/
```

#### Get current AWS CLI configuration

```bash
aws configure list
```

#### use a named profile
refer to https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-using-profiles

``` bash
export AWS_PROFILE="user1"
```

#### give the aws cli flag
``` bash
aws iam get-user --profile $AWS_NAMED_PROFILE
```

---

# C

## AWS Code Commit
[Code Commit cheat sheet](./code-commit.md)
---

## AWS CF Cloud Formation
Infrastructure as a configuration (not code)
[Cloud Formation](./cloud-formation.md)

---
## AWS CloudWatch
[Monitor AWS](./cloud-watch.md)
# E

## AWS EC2 Elastic Compute Cloud
[AWs Compute](./ec2.md)

# I
## AWS IAM

#### When was my AWS user account created? JQ

```bash
aws iam get-user | jq -r ".User.CreateDate[:4]"
```

#### Which AWS Services am I using? JQ

```bash
aws ce get-cost-and-usage --time-period Start=$(date "+%Y-%m-01" -d "-1 Month"),End=$(date --date="$(date +'%Y-%m-01') - 1 second" -I) \
  --granularity MONTHLY --metrics UsageQuantity --group-by Type=DIMENSION,Key=SERVICE | \
  jq '.ResultsByTime[].Groups[] | select(.Metrics.UsageQuantity.Amount > 0) | .Keys[0]'
```

#### What is each service costing me? JQ

```bash
aws ce get-cost-and-usage --time-period Start=$(date "+%Y-%m-01"),End=$(date --date="$(date +'%Y-%m-01') + 1 month  - 1 second" -I) --granularity MONTHLY --metrics USAGE_QUANTITY BLENDED_COST  --group-by Type=DIMENSION,Key=SERVICE | jq '[ .ResultsByTime[].Groups[] | select(.Metrics.BlendedCost.Amount > "0") | { (.Keys[0]): .Metrics.BlendedCost } ] | sort_by(.Amount) | add'
```

---
# [L]
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

---

# R

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

---

# S

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
printf "\n EC2 server name== $(hostname) \n\n" ; aws s3api list-buckets --color on --output table ; \
printf "\n\t Total number of S3 Bucket objects $(aws s3 ls | wc -l) \n"
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

---

# V

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

#### REFERENCES

- https://superadmins.com/creating-ec2-inventory-with-aws-cli/
- [What is Amazon CloudWatch Logs? - Amazon CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html)
- [Filter and pattern syntax - Amazon CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html)
- [Newest &#39;amazon-cloudwatchlogs&#39; Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/amazon-cloudwatchlogs)

[Back to top of Page](#)
[Kiwiki Home](./readme.md)