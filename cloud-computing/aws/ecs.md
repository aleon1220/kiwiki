[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Elastic Container Service
https://docs.aws.amazon.com/ecs/

Variables that are helpful to use the commands in this page

```bash
ECS_TASK_ID="NOT the ARN just ID number"
MY_ECS_CLUSTER=""
CONTAINER_NAME=""
```

#### Access container interactively in a task
```bash
aws ecs execute-command --cluster $MY_ECS_CLUSTER \
--task $ECS_TASK_ID \
--container $CONTAINER_NAME \
--command "/bin/bash" \
--interactive
```
