- [Virtual Private Cloud](#virtual-private-cloud)
      - [What are my VPCs in table format](#what-are-my-vpcs-in-table-format)
      - [What CIDRs have Ingress Access to which Ports? JQ](#what-cidrs-have-ingress-access-to-which-ports-jq)

[Kiwiki Home](/../../)
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

[Back to top](#)

[Kiwiki Home](/../../)