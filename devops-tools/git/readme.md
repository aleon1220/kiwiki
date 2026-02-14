[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Git
System to manage and store source code. Keeps track of changes to files. Text files only
refer to [git official manual](https://git-scm.com/docs/user-manual)

See git in action with the [Git flow by example](#git-flow-by-example)

## Default Flow
#### usual add, commit, push
```bash
git add . ; git commit ; git push
```

## Git Administration/Operation
### Git Global Settings
#### Get global config info

```bash
git config --global --list
```
#### do basic config setup
will apply to all repositories
```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

#### use nano as CLI editor
for simplicity compared to vim`

```bash
git config --global core.editor "nano"
```

#### Force-switches to branch, discarding changes
```bash
git checkout master --force
```
#### fetch from remote and then merge to develop

```bash
git fetch
git merge origin/develop
```

- Push changes to remote branch `my-feature`

```bash
git push origin :my-feature
```

- use `@` instead of `HEAD`

#### Delete Remote Branches

```bash
git push REMOTE -d BRANCH
```

#### Delete remote branch (short form `:`)

```bash
git push REMOTE :BRANCH
```

#### Remove remote branches that were deleted (merged)

> tested on BitBucket

```bash
git config fetch.prune true 
```

#### Change remote URL if you change your repository’s name

```bash
git remote set-url REMOTE $NEWURL
```

#### Github set remote URL

```bash
git remote set-url origin github.com/myusername/my-repo
```

#### Stash Individual Files

```bash
git stash push -- <filepath(s)>
# Example
git stash push -- src/index.js README.md
```

#### Show Content of Most Recent Stash

```bash
git stash show -p [stash@{<n>}]
```

**Flags Explanation:**

- `-p` to see the actual content of the stash. Omitting it will show only the file names.
- `stash@{<n>}` allows us to specify a certain stash, denoted by `n` ( 0 being the most recent one )

```bash
git stash show -p stash@{1}
```
#### List git stashes

```bash
git stash list
```

#### Reset the current HEAD or changes of your local branch to a specific state

```bash
git reset [FILE_PATH]
```

#### Check Out File From Another Branch

```bash
BRANCH="main"
PATH_TO_CHECKOUT="src/functions.py"

git checkout $BRANCH -- $PATH_TO_CHECKOUT
```

#### Work with 2 branches

```bash
git worktree add <path> <branch>
```

```bash
git worktree add my-other-awesome-feature ../my-other-awesome-feature

git worktree remove ../my-other-awesome-feature
```
**Explanation**

Creates a linked working tree (i.e., another directory on the file system associated with the repo) called `my-other-awesome-feature`, one level above your current working directory, with the specified branch checked out.

#### when you no longer need the branch:

```bash
git worktree remove [-f] PATH_TO_MODIFY
```

#### Show Commit Contents
Shows changes introduced by a commit

```bash
git show $COMMIT_ID
```

- Alternatively, to see the changes between two specific commits run

```bash
git diff $COMMIT_A $COMMIT_B
```

#### Show changes-diff with remote HEAD

```bash
git diff HEAD~ HEAD
```

#### Compare Files Between Branches/Commits

```bash
git diff $COMMIT_A $COMMIT_B -- PATH

# e.g.
git diff 0659bdc e6c7c0d -- src/automate.py
```

#### Reset a Single File to a specific Commit

```bash
git checkout [<$COMMIT_ID>] -- <path(s)>
```

#### Reset a single file

```bash
git checkout -- todo.md
```

#### Change Last Commit Message

```bash
git commit --amend [-m 'MESSAGE']

git push -f
```

#### If the old commit had already been pushed

```bash
git push --force-with-lease REMOTE BRANCH
```

**Note:**
- As a general rule, it’s important to be careful when making any changes to already pushed commits

#### Change a Specific Commit Message
one commit with the wrong email address. The commit history must be updated

##### List commits with author emails to find target commits
```bash
git log --all --pretty=format:"%h %an <%ae> %s" | grep "authorName@outlookcom
```

##### could use full scan
```bash
git log --pretty=full
```
##### Start an interactive rebase that stops just before that commit
```bash
TARGET_COMMIT="abc1234"
git rebase -i "$TARGET_COMMIT"^
```

##### from the text editor, choose a git rebase operation.
Change `pick` to `edit` for that commit, save, and close.
```bash
pick "$TARGET_COMMIT" commit message with changes here
```

##### Amend the author on that commit
```bash
git commit --amend --author="Author Name <authorName@outlook.com>" --no-edit
```

##### Continue the rebase
Git will replay multiple queued commits after this automatically.

```bash
git rebase --continue
```
##### Push your updated history
```bash
TARGET_BRANCH="your-branch"
git push --force-with-lease origin $TARGET_BRANCH
```

##### Verify the fix
```bash
git log -1 --pretty=full
```
---

#### Doing a Rebase for the previous 3 commits

```bash
git rebase -i HEAD~3
```

### Many commits across the whole repo need re-writing
For broad changes, consider a history rewrite tool:
`git filter-repo` (recommended, separate install): powerful and fast for bulk author rewrites.

#### using `git filter-repo`
```bash
git filter-repo --mailmap .mailmap
```

#### Delete Last Commit but Keep the Changes

```bash
git reset HEAD^
```

#### Unstage a File

```bash
git reset HEAD $PATH_OF_REPO
```

### Remove Ignored Files Remote repo

if `.gitignore` is updated, previously created files will persist in your remote repository. To remedy this

#### remove files and clean up
```bash
git rm
```

#### clean up git cache

```bash
git rm [-r] [-n] --cached <path(s)>
```

#### reset everything to match the remote branch

```bash
git fetch origin
git reset --hard origin/master
```

#### Find local GIT repos

```bash
sudo find -name HEAD -execdir test -e refs -a -e objects -a -e config \; -printf %h\\n
```

#### Get help with any git command

```bash
git $COMMAND --help

git init --help
```

#### Clone a repo with given private ssh key

```bash
EXTRA_PRIVATE_KEY_PATH="/home/user/.ssh/id_rsa_example"
GIT_REPO_URL="git@github.com:Organization/org-repo-name.git"

git clone -c core.sshCommand="/usr/bin/ssh -i $EXTRA_PRIVATE_KEY_PATH" $GIT_REPO_URL
```

#### Clone a Git Repo

```bash
git clone git@github.com:elastic/stack-docker.git
```

#### List the fetched branches for a repository

```bash
git branch
```

---

## Git Security
refers to encryption and commit signing

### Git commit sign
- prefer sign commits with PGP encryption
- SSH much easier but less secured

#### Git TLS Certificates

Git uses a file named `ca-bundle.crt` to list all the trusted certificates. We can find that file by typing the following in a terminal window:

```bash
git config --list --show-origin
```

#### Get TLS info

```bash
git config --global http.sslCAInfo
```

#### Instruct Git to use GPG2 instead of GPG2 as the signing program

```bash
git config --global gpg.program gpg2
```

#### Test GPG2 encrytion

signing text with `gpg` or `gpg2`

```bash
echo "test" | gpg2 --clearsign
```

#### Set variable for GPG and terminal usage

```bash
export GPG_TTY=$(tty)
```

#### Sign the Commit GPG

```
git commit -S -m "SSH signed commit"
```

### Sign commits with SSH Key

```bash
git config --global gpg.format ssh
```

#### Refer to Public SSH Key

use default values

```
git config --global user.signingkey ~/.ssh/id_rsa.pub
```

#### Use an alias to add, commit and push
```bash
alias gacp_extrakey="git add . && git -c core.sshCommand='/usr/bin/ssh -i \$HOME/.ssh/extrakey' commit -S && git -c core.sshCommand='/usr/bin/ssh -i \$HOME/.ssh/extrakey' push"

gacp_extrakey
```

#### Show GPG signatures used in a repo

```bash
git log --show-signature
```
#### push with alternative SSH key
```bash
git -c core.sshCommand="/usr/bin/ssh -i /home/user/.ssh/id_alternative" push
```

---

## Git Analysis/Reporting

#### List all remote branches
```bash
git branch --remotes
```

#### List remote active branches

```bash
git ls-remote --heads origin
```

#### Get info about commits for a given user

```bash
git_user="git_user"
git_date="Sat Aug 30 2024"
git log --oneline -5 --author $git_user --before $git_date
```

#### Create a local branch for testing

```bash
git checkout -b feature/ID01-functionality
```

#### Get a histogram for a gitdiff

```bash
git diff --histogram
```

#### Print out subject line

```bash
git log --oneline
```

#### Better log displaying

```bash
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
```

#### Groups commits by user, shows the subject line for simplicity

```bash
git shortlog
```

#### Switch to previous branch

```bash
git checkout -
```

#### Add small patches to a commit

```bash
git add -p
```

#### Find the last working commit by basically using binary search

```bash
git bisect start

# for a commit that you know is working correctly
git bisect good

# for a commit that you know is NOT working correctly
git bisect bad
```

#### Change/Ammend commit message made long ago
**n** is the number of commits to go back

```bash
git rebase -i HEAD~n

# Use
git cherry-pick

## then edit the cherry-picked commit
edit

git push --force
```

#### Check size of repo
```bash
git count-objects -vH
```

#### Get detailed info about a remote server
```bash
git remote --verbose
```

#### get extra info about remote
```bash
git remote show origin
```

# PR Pull Request Version Control
Pull requests are essential for collaborating on code changes and getting feedback from others
pull requests facilitate collaboration, code quality, and transparency. They allow others to review your work and ensure that changes are well-tested before merging.

1. Create a Branch
1. Commit Your Changes
1. Push Your Changes
1. Open a Pull Request
1. Discuss and Review
1. Rebase and Tests
If necessary, rebase your branch to keep it up-to-date with the base branch.
Run tests to ensure your changes don’t break anything.
1. Merge Your Branch

---

## Git implementations Bitbucket

#### Report Project User name, User key, Repo name and Repo Slug
- Run a SQL query in the PostgreSQL DB

```sql
SELECT 
       prj.name AS "Project / User Name"
     , prj.project_key AS "Project / User Key"
     , rep.name AS "Repository Name"
     , rep.slug AS "Repository Slug"
FROM repository rep 
INNER JOIN project prj ON rep.project_id = prj.id
ORDER BY prj.name, rep.name
```

#### Update the remote URL using current and new remote URL

```bash
git remote set-url origin git@bitbucket.org:tutorials/tutorials.git
```

## Git implementations GitLab

## Git implementations Azure ADO Repos

---
## Git flow by example
<details>
<summary> git flow example </summary>

Quick Start: Learning `git` basics by example. Flow challenge/Demo by hackerRanx.

Goal is to create a git repo in linux instance: Add changes to a source-code file, commit changes, create a develop branch with new changes and finally merge from **develop branch** to **main**

```bash
develop --> main
```

- Initialize and operate a git repo at `/var/save/repo`

```bash
mkdir --parents --verbose /var/save/repo | cd /var/save/repo

git init
Initialized empty Git repository in /var/save/repo/.git/
```
- set local git config settings
```bash
git config user.email "me@hackerrank.com"
git config user.name "hackerrank"
```

- Create a develop branch (clones main references)

```bash
git checkout -b develop
```

- Check available branches in the repo

```bash
git branch
* master
  test
```

- check git working tree status
```bash
git status
```

- Check the log to see info about all commits `git log`

```bash
commit 4c569ff830048206717d62544efbd288f85005e3 (HEAD -> master, test)
Author: hackerrank <me@hackerrank.com>
Date:   Mon Jun 28 22:02:25 2021 +0000
    Added commit03
    Signed-off-by: hackerrank <me@hackerrank.com>

commit 3ca19596ebb32aa611a6625f184e37735a5f5156
Author: hackerrank <me@hackerrank.com>
Date:   Mon Jun 28 21:57:08 2021 +0000
    Adding initial files git repo
    - code tested
    Signed-off-by: hackerrank <me@hackerrank.com>

[70][22:06:12] ubuntu@taskserver:[/var/save/my-repo]
```

- Verify commits in `develop` branch

```bash
git rev-list --date-order --abbrev-commit --reverse HEAD

3ca1959
360dba4
cf10ff6
4c569ff
[74][22:07:50] ubuntu@taskserver:[/var/save/repo]
```
- merge develop --> main
```bash
git merge develop
Updating 3ca1959..4c569ff
Fast-forward
 Hello.java | 3 +++
 1 
 file changed, 3 insertions(+)
```
</details>
<!-- end of expand -->

---

## References
1. [git commands to live by @Omar Shakari](https://medium.com/better-programming/git-commands-to-live-by-349ab1fe3139)
2. [stackdiary how-to-sign-your-git-commits-with-ssh-keys](https://stackdiary.com/tutorials/how-to-sign-your-git-commits-with-ssh-keys)
3. [Atlassian support docs change-the-remote-url-to-your-repository](https://support.atlassian.com/bitbucket-cloud/docs/change-the-remote-url-to-your-repository)
4. [Atlassian Docs | Bitbucket Sign tags commits with SSH keys | Bitbucket Data Center Server 8.15](https://confluence.atlassian.com/bitbucketserver/sign-commits-and-tags-with-ssh-keys-1305971205.html)
5. [Atlassian Docs | Bitbucket obtain list of all projects and repos from DB](https://confluence.atlassian.com/bitbucketserverkb/how-to-obtain-a-list-of-all-projects-and-repositories-from-bitbucket-database-975027747.html)
6. [Coderwall | A better git log](coderwall.com/p/euwpig/a-better-git-log)

[Back to top](#)

[Kiwiki Home](/../../)
