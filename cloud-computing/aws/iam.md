# Identiy Access Management
#### When was my AWS user account created? JQ

```bash
aws iam get-user | jq -r ".User.CreateDate[:4]"
```

[Back to top](#)

[Kiwiki Home](/../../)