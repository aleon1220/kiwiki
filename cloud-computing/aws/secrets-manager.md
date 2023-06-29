# Secrets Manager
Passwords

#### Create a secret with a binary file in this case a java keystore JKS

```bash
SECRET_ID="arn:12312312:xxxxx"
BINARY_FILE="mykeystore.jks"

aws secretsmanager put-secret-value --secret-id $SECRET_ID --secret-binary fileb://$BINARY_FILE
```

#### Create a secret as a key and value format from a json file

```bash
aws secretsmanager put-secret-value --secret-id $SECRET_ID --secret-string file://secret.json
```

#### Obtain a secret that contains JSON data as a SecretString and list the JSON keys

```bash
SECRET_NAME="my-aws-secret"
aws secretsmanager get-secret-value --secret-id $SECRET_NAME | jq -r '.SecretString' | jq -r 'keys[]'
```

[Back to top](#)
[Kiwiki Home](./readme.md)