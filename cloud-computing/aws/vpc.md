[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Virtual Private Cloud

#### What are my VPCs in table format

```bash
aws ec2 describe-vpcs --output table
```

#### What CIDRs have Ingress Access to which Ports? JQ

```bash
aws ec2 describe-security-groups | \
 jq '[ .SecurityGroups[].IpPermissions[] as $a | { "ports": [($a.FromPort|tostring),($a.ToPort|tostring)]|unique, "cidr": $a.IpRanges[].CidrIp } ] | [group_by(.cidr)[] | { (.[0].cidr): [.[].ports|join("-")]|unique }] | add'
```
#### find security group by name & get SecgroupID 
```bash
SecGroup_QA=$(aws ec2 describe-security-groups --filters Name=group-name,Values=qual-nlb-sg --query "SecurityGroups[*].GroupId" --output text)
```

#### create ingress group in a particular security groupID
```bash
SERVICE_PORT="38139"
aws ec2 authorize-security-group-ingress --group-id "$SecGroup_QA" --protocol tcp --port $SERVICE_PORT --cidr 10.0.0.0/8
```

[Back to top](#)

[Kiwiki Home](/../../)
