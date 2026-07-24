[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Virtual Private Cloud

#### What are my VPCs in table format

```bash
aws ec2 describe-vpcs --output table
```

#### What CIDRs have Ingress Access to which Ports?

```bash
aws ec2 describe-security-groups --query 'SecurityGroups[*].IpPermissions[*].{FromPort: FromPort, ToPort: ToPort, IpRanges: IpRanges[*].CidrIp}' --output table
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
