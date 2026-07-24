# AWS Identiy Access Management

#### When was my AWS user created?

```bash
aws iam get-user --query 'User.CreateDate' --output text
```
