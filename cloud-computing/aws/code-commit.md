- [AWS Code Commit](#aws-code-commit)
      - [Create/Clone a CodeCommit Repository](#createclone-a-codecommit-repository)

[Kiwiki Home](/../../)
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