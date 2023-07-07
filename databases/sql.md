- [SQL Databases](#sql-databases)
  - [MariaDB (MySQL open source Fork)](#mariadb-mysql-open-source-fork)
  - [Oracle MySQL](#oracle-mysql)
      - [Connect to a DB with mysql command utilities](#connect-to-a-db-with-mysql-command-utilities)
      - [Check the default character set for a particular database DB\_NAME](#check-the-default-character-set-for-a-particular-database-db_name)
  - [AWS RDS MySQL engine](#aws-rds-mysql-engine)
  - [PostgreSQL](#postgresql)
      - [Check this super PostgreSQL Cheat sheet](#check-this-super-postgresql-cheat-sheet)
      - [Access the PostgreSQL server from psql with a specific user](#access-the-postgresql-server-from-psql-with-a-specific-user)
      - [Check DB version](#check-db-version)
      - [Dump DB and create a restore script](#dump-db-and-create-a-restore-script)
      - [back up my entire PostgreSQL cluster and save it in the entire\_cluster.sql file](#back-up-my-entire-postgresql-cluster-and-save-it-in-the-entire_clustersql-file)
  - [Microsoft SQL Server](#microsoft-sql-server)

[Kiwiki Home](/../../)
# SQL Databases
## MariaDB (MySQL open source Fork)

## Oracle MySQL

#### Connect to a DB with mysql command utilities

```bash
HOST="localhost"; USER="mysql"
mysql -h $HOST -u $USER -p
```

#### Check the default character set for a particular database DB_NAME

```SQL
SELECT SCHEMA_NAME, DEFAULT_CHARACTER_SET_NAME
       FROM INFORMATION_SCHEMA.SCHEMATA
       WHERE SCHEMA_NAME='DB_NAME';
```

## AWS RDS MySQL engine

MySQL has a cloud behaviuour in AWS or any other cloud provider

## PostgreSQL

#### Check this super [PostgreSQL Cheat sheet](https://www.postgresqltutorial.com/postgresql-cheat-sheet/)

#### Access the PostgreSQL server from psql with a specific user

```bash
psql -U [username]
```

> Once in the `psql` console

#### Check DB version

```bash
SELECT version();
```

#### Dump DB and create a restore script

```bash
pg_dump -U postgres -W -C -d example_backups > ~/db_backup.sql
```

#### back up my entire PostgreSQL cluster and save it in the entire_cluster.sql file

```bash
pg_dumpall -U postgres -W -f ~/Example_Dumps/Cluster_Dumps/entire_cluster.sql
```

> Avoid system asking for the password by using a PostgreSQL config file at  `$HOME/.pgpass`

- `pgpass` Syntax

```bash
hostname:port:database:username:password
```

## Microsoft SQL Server
[Back to top](#)

[Kiwiki Home](/../../)