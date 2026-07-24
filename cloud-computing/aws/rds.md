# AWS RDS Relational Databases Systems

#### list RDS Instance Endpoints?

```bash
aws rds describe-db-instances --query 'DBInstances[*].{Identifier: DBInstanceIdentifier, Endpoint: Endpoint.Address, Port: Endpoint.Port}' --output table
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
