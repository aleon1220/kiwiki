# AWS Code Commit
AWS Git
https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html

#### How do I Create a CodeCommit Repository and Clone It?

```bash
export REPO_URL=$(aws codecommit create-repository --repository-name <name> | jq -r ".repositoryMetadata.cloneUrlHttp")

git clone $REPO_URL <name> && cd <name>
```
[Back to top](#)
[Kiwiki Home](./readme.md)