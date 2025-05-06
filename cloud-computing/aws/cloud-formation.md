[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# IaC Cloud Formation
Infrastructure as a configuration JSON or YAML
[AWS CloudFormation](https://docs.aws.amazon.com/cloudformation)

#### Cloud Formation Stack Events with their Status
```bash
aws cloudformation list-stacks | jq  '.StackSummaries | [ group_by(.StackStatus)[] | { "status": .[0].StackStatus, "count": (. | length) }]'
```

#### cloudformation stack events for a given stack 
```bash
MY_CLOUDFORMATION_STACKNAME=""
aws cloudformation describe-stack-events --stack-name $MY_CLOUDFORMATION_STACKNAME | jq length
```

#### list all the resources in the specified stack
```bash
MY_CLOUDFORMATION_STACKNAME=""
aws cloudformation describe-stack-resources --stack-name $MY_CLOUDFORMATION_STACKNAME | jq '.StackResources | length'
```

#### EC2 Instance IDs created by AWS CF Stacks?
```bash
for stack in $(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE | jq -r '.StackSummaries[].StackName'); do aws cloudformation describe-stack-resources --stack-name $stack | jq -r '.StackResources[] | select (.ResourceType=="AWS::EC2::Instance")|.PhysicalResourceId'; done;
```

[Back to top](#)
[Kiwiki Home](./readme.md)
