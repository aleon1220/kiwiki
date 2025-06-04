[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# AWS Code Commit
AWS Git
https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html

#### Create/Clone a CodeCommit Repository

```bash
export REPO_URL=$(aws codecommit create-repository --repository-name <name> | jq -r ".repositoryMetadata.cloneUrlHttp")

git clone $REPO_URL <name> && cd <name>
```
[Back to top](#)

[Kiwiki Home](/../../)
