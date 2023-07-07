- [Relational Databases Systems](#relational-databases-systems)
      - [What are my RDS Instance Endpoints? JQ](#what-are-my-rds-instance-endpoints-jq)
      - [Describe RDS instances](#describe-rds-instances)
      - [Check logs for given instance](#check-logs-for-given-instance)

[Kiwiki Home](/../../)
# Relational Databases Systems
#### What are my RDS Instance Endpoints? JQ

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