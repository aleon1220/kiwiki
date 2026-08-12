# AWS IaC Cloud Formation

Infrastructure as a configuration JSON or YAML
[AWS CloudFormation](https://docs.aws.amazon.com/cloudformation)

#### get total count of Stack status per event

```bash
aws cloudformation list-stacks --query 'StackSummaries[*].{Status: StackStatus, Name: StackName}' --output table
```

#### get stack events cloudformation for a stack

```bash
CLOUDFORMATION_STACKNAME=""
aws cloudformation describe-stack-events --stack-name $CLOUDFORMATION_STACKNAME --query 'length(StackEvents)' --output text
```

#### list all the resources in the specified stack

```bash
MY_CLOUDFORMATION_STACKNAME=""
aws cloudformation describe-stack-resources --stack-name $MY_CLOUDFORMATION_STACKNAME --query 'length(StackResources)' --output text
```

#### get EC2 Instance IDs per CF Stacks?

```bash
for stack in $(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE --query 'StackSummaries[*].StackName' --output text); do aws cloudformation describe-stack-resources --stack-name $stack --query "StackResources[?ResourceType=='AWS::EC2::Instance'].PhysicalResourceId" --output text; done;
```
