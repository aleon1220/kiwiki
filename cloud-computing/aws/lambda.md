- [AWS Lambda Functions](#aws-lambda-functions)
      - [Which Lambda Functions Runtimes am I Using? JQ](#which-lambda-functions-runtimes-am-i-using-jq)
      - [Are you exposing secrets in variables? Have a typo in a key? JQ](#are-you-exposing-secrets-in-variables-have-a-typo-in-a-key-jq)
      - [What logs does my Lambda Function generate when I run it? JQ](#what-logs-does-my-lambda-function-generate-when-i-run-it-jq)

[Kiwiki Home](/../../)
# AWS Lambda Functions

#### Which Lambda Functions Runtimes am I Using? JQ

```bash
aws lambda list-functions | jq ".Functions | group_by(.Runtime)|[.[]|{ runtime:.[0].Runtime, functions:[.[]|.FunctionName] }]"
```

#### Are you exposing secrets in variables? Have a typo in a key? JQ

```bash
aws lambda list-functions | jq -r '[.Functions[] |{name: .FunctionName, env: .Environment.Variables}] | .[] | select(.env|length > 0)'
```

#### What logs does my Lambda Function generate when I run it? JQ

```bash
aws lambda invoke --function-name <function name> --payload '{}' --log-type Tail - | jq -r '{ "StatusCode": .StatusCode, "LogResult": (.LogResult|@base64d)}'
```

[Back to top](#)

[Kiwiki Home](/../../)