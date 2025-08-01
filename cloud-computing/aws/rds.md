[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Relational Databases Systems
#### list RDS Instance Endpoints?

```bash
aws rds describe-db-instances | jq -r '.DBInstances[] | { (.DBInstanceIdentifier):(.Endpoint.Address + ":" + (.Endpoint.Port|tostring))}'
```

#### Describe RDS instances

```bash
aws rds describe-db-instances
```

#### Check logs for given instance

```bash
RDS_INSTANCE_ID="REPLACE"
aws rds describe-db-log-files --db-instance-identifier $RDS_INSTANCE_ID
```


[Back to top](#)

[Kiwiki Home](/../../)
