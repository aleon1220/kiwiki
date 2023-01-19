# AWS Cloud Formation
Infrastructure as a configuration JSON or YAML
https://docs.aws.amazon.com/cloudformation/?icmpid=docs_homepage_mgmtgov
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