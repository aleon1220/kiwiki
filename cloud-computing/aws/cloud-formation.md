- [IaC Cloud Formation](#iac-cloud-formation)
      - [How Many CloudFormation Stacks do I have in each Status? JQ](#how-many-cloudformation-stacks-do-i-have-in-each-status-jq)
      - [Number of cloudformation stack objects](#number-of-cloudformation-stack-objects)
      - [Which EC2 Instances were created by AWS CF Stacks?](#which-ec2-instances-were-created-by-aws-cf-stacks)

[Kiwiki Home](/../../)

# IaC Cloud Formation
Infrastructure as a configuration JSON or YAML
https://docs.aws.amazon.com/cloudformation/?icmpid=docs_homepage_mgmtgov

[Back to Main Page](./readme.md)
#### How Many Cloud Formation Stacks do I have in each Status?
```bash
aws cloudformation list-stacks | jq  '.StackSummaries | [ group_by(.StackStatus)[] | { "status": .[0].StackStatus, "count": (. | length) }]'
```

#### Number of cloudformation stack objects
```bash
exec env TERM='dumb' INSIDE_EMACS='26.1,tramp:2.3.3.26.1' ENV='' HISTFILE=~/.tramp_history PROMPT_COMMAND='' PS1=\#\$\  PS2='' PS3='' /bin/sh
aws cloudformation describe-stack-events --stack-name $MY_CLOUDFORMATION_STACKNAME | jq lenght
```

#### EC2 Instances were created by AWS CF Stacks?

```bash
for stack in $(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE | jq -r '.StackSummaries[].StackName'); do aws cloudformation describe-stack-resources --stack-name $stack | jq -r '.StackResources[] | select (.ResourceType=="AWS::EC2::Instance")|.PhysicalResourceId'; done;
```

[Back to top](#)
[Kiwiki Home](./readme.md)
