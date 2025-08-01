[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Identiy Access Management
#### When was my AWS user created? JQ

```bash
aws iam get-user | jq -r ".User.CreateDate[:4]"
```

[Back to top](#)

[Kiwiki Home](/../../)
