[Kiwiki Home](/../../)
[Back to Main Page](./readme.md)

# Relational Databases Systems
#### What are my RDS Instance Endpoints?

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


[Back to top](#)

[Kiwiki Home](/../../)