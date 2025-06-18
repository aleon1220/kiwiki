[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Elastic Container Service
https://docs.aws.amazon.com/ecs/

#### Access container in a task Bash
```bash
ECS_TASK_ID="NOT The ARN the ID number"
MY_ECS_CLUSTER=""
CONTAINER_NAME=""

aws ecs execute-command --cluster $MY_ECS_CLUSTER \
--task $ECS_TASK_ID \
--container $CONTAINER_NAME \
--command "/bin/bash" \
--interactive
```
