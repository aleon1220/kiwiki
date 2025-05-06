[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Elastic Container Service
https://docs.aws.amazon.com/ecs/

#### Access container in a task Bash
```bash
ECS_TASK_ID="218911777777

aws ecs execute-command --cluster my-ecs-cluster \
--task $ECS_TASK_ID \
--container app-operateservices \
--command "/bin/bash" \
--interactive
```