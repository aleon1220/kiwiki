[Kiwiki Home](/../../)
[Back to Main Page](./readme.md)

# AWS CLI commands
# Introduction
AWS CLI commands for some AWS services. AWS service names Sorted from A-Z
source obtained from this wonderful [Medium post by circuit People](https://medium.com/circuitpeople/aws-cli-with-jq-and-bash-9d54e2eabaf1)

## AWS Amazon Web services General

#### How Many Services does AWS Have? JQ

```bash
curl -s https://raw.githubusercontent.com/boto/botocore/develop/botocore/data/endpoints.json | jq -r '.partitions[0].services | keys[]' | wc -l
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

## AWS CLI

#### Install AWS CLI

Amazon Web Services Command Line Interface client.

Follow [Install AWS CLI2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html)

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

``` bash
export AWS_PROFILE="user1"
```

#### give the aws cli flag
``` bash
aws iam get-user --profile $AWS_NAMED_PROFILE
```

---

# C

## AWS [Code Commit](./code-commit.md)
Git Repos

---

## AWS CF Cloud Formation
Infrastructure as a configuration (not code)
[Cloud Formation](./cloud-formation.md)

---
## AWS CloudWatch
[Cloud Watch](./cloud-watch.md)

# E

## AWS EC2 Elastic Compute Cloud
[EC2 Compute](./ec2.md)

# I
## [IAM Identity Access Management](./iam.md)

---
# [L]
## [Lambda](./lambda.md)
---

# R

## [RDS Databases]((./rds.md))

---

# S

## [S3](./s3.md)

## [Secret Manager](./secrets-manager.md)

---

# V

## [VPC](./vpc.md)

#### References
- [Named Profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-using-profiles)

[Back to top](#)

[Kiwiki Home](/../../)
