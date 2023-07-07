- [Identiy Access Management](#identiy-access-management)
      - [When was my AWS user created? JQ](#when-was-my-aws-user-created-jq)

[Kiwiki Home](/../../)
# Identiy Access Management
#### When was my AWS user created? JQ

```bash
aws iam get-user | jq -r ".User.CreateDate[:4]"
```

[Back to top](#)

[Kiwiki Home](/../../)