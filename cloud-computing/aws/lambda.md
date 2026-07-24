[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# AWS Lambda Functions

#### Which Lambda Functions Runtimes am I Using?

```bash
aws lambda list-functions --query 'Functions[*].{FunctionName: FunctionName, Runtime: Runtime}' --output table
```

#### Are you exposing secrets in variables? Have a typo in a key?

```bash
aws lambda list-functions --query "Functions[?Environment.Variables != \`null\`].{FunctionName: FunctionName, Environment: Environment.Variables}"
```

#### What logs does my Lambda Function generate when I run it?

```bash
FUNCTION_NAME="REPLACE"
aws lambda invoke --function-name $FUNCTION_NAME --payload '{}' --log-type Tail --query '{StatusCode: StatusCode, LogResult: LogResult}' response.json
```
