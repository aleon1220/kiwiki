# Git

System to manage and store source code. Keeps track of changes to files. Text files only.

#### List of common `git` commands
``` bash
git init
git clone
git branch
git checkout
git status
git fetch
git pull
git add
git commit
git push
git remote
git merge
git log
git stash
git reset
git config
```

### Git basic flow challenge/Demo by hackerRanx

Goal is to create a git repo at a linux location, Add changes to a source-code file, commit changes, create a develop branch with new changes and finally merge from `develop --> main`

#### Initialize and operate a git repo at `/var/save/repo`

``` bash
mkdir -pv /var/save/repo | cd /var/save/repo

git init
Initialized empty Git repository in /var/save/repo/.git/
```

#### Create a develop branch (clones main references)
``` bash
git checkout -b develop
```

#### Check what branches are available in the repo
``` bash
git branch
* master
  test
```

#### Check the log to see info about all commits
``` bash
git log
commit 4c569ff830048206717d62544efbd288f85005e3 (HEAD -> master, test)
Author: hackerrank <me@hackerrank.com>
Date:   Mon Jun 28 22:02:25 2021 +0000
    Added commit03
    Signed-off-by: hackerrank <me@hackerrank.com>

commit cf10ff6b4ceee54c4c92ae72ba58c612d990b9cc
Author: hackerrank <me@hackerrank.com>
Date:   Mon Jun 28 22:02:04 2021 +0000
    Added commit02
    Signed-off-by: hackerrank <me@hackerrank.com>

commit 360dba467b0605ab8235954a7fcde81a5645df9f
Author: hackerrank <me@hackerrank.com>
Date:   Mon Jun 28 22:00:58 2021 +0000
    Commit01 on test
    Signed-off-by: hackerrank <me@hackerrank.com>

commit 3ca19596ebb32aa611a6625f184e37735a5f5156
Author: hackerrank <me@hackerrank.com>
Date:   Mon Jun 28 21:57:08 2021 +0000
    Adding initial files git repo
    - code tested
    Signed-off-by: hackerrank <me@hackerrank.com>

[70][22:06:12] ubuntu@taskserver:[/var/save/my-repo]
```

#### Verify commits in `develop` branch

``` bash
git rev-list --date-order --abbrev-commit --reverse HEAD

3ca1959
360dba4
cf10ff6
4c569ff
[74][22:07:50] ubuntu@taskserver:[/var/save/repo]
```

#### Perform the merge develop --> main
``` bash
git merge develop
Updating 3ca1959..4c569ff
Fast-forward
 Hello.java | 3 +++
 1 
 file changed, 3 insertions(+)
```

#### Verifying commits in `main`
``` bash
git rev-list --date-order --abbrev-commit --reverse HEAD

3ca1959
360dba4
cf10ff6
4c569ff
```

## Git Administration/Operation

#### Branch was created in the past and changes either had been added or removed in the destination branch `main | develop`
``` bash
git fetch
git merge origin/develop
```

- use `@` instead of `HEAD`

GitOps reading from a [medium post @Omar Shakari](https://medium.com/better-programming/git-commands-to-live-by-349ab1fe3139)

#### Delete Remote Branches
``` bash
git push REMOTE -d BRANCH
```
#### Delete remote branch (short form `:`)
``` bash
git push REMOTE :BRANCH
```

#### Push changes to remote branch `my-feature`
``` bash
git push origin :my-feature
```
#### Remove remote branches that were deleted (merged) on BitBucket
``` bash
git config fetch.prune true 
```

#### Change remote URL if you change your repository’s name
``` bash
git remote set-url REMOTE NEWURL
```

#### Github set remote URL
``` bash
git remote set-url origin github.com/myusername/my-repo
```
##### Stash Individual Files
``` bash
git stash push -- <filepath(s)>
# Example
git stash push -- src/index.js README.md
```

##### Show Content of Most Recent Stash
``` bash
git stash show -p [stash@{<n>}]
```
**Flags Explanation:**

- `-p` to see the actual content of the stash. Omitting it will show only the file names.

- `stash@{<n>}` allows us to specify a certain stash, denoted by `n` ( 0 being the most recent one ).

``` bash
git stash show -p stash@{1}
```
#### Check Out File From Another Branch
``` bash
git checkout <branch> -- <path(s)>

git checkout another-branch src/file.js
```
#### Working with 2 branches
``` bash
git worktree add <path> <branch>
```
- when you no longer need the branch:

``` bash
git worktree remove [-f] PATH_TO_MODIFY
```

**Example:**
1. `git worktree add my-other-awesome-feature ../my-other-awesome-feature`
1. `git worktree remove ../my-other-awesome-feature`

**Explanation:**

Creates a linked working tree (i.e., another directory on the file system associated with the repo) called `my-other-awesome-feature`, one level above your current working directory, with the specified branch checked out.

#### Show Commit Content shows changes introduced by a commit
``` bash
git show COMMIT
```
- Alternatively, to see the changes between two specific commits run

``` bash
git diff COMMIT_A COMMIT_B
```

#### Show changes-diff with remote HEAD
``` bash
git diff HEAD~ HEAD
```
#### Compare Files Between Branches/Commits
``` bash
git diff COMMIT_A COMMIT_B -- PATH

# e.g.
git diff 0659bdc e6c7c0d -- src/flair.py
```

#### Reset a Single File to Most Recent Commit
``` bash
git checkout [<commit>] -- <path(s)>
```

#### Reset a single file
``` bash
git checkout -- README.md
```
#### Change Last Commit Message
``` bash
git commit --amend [-m 'MESSAGE']
```

#### If the old commit had already been pushed, you’ll need to additionally run
``` bash
git push --force-with-lease REMOTE BRANCH
```
**Note:** 
- As a general rule, it’s important to be careful when making any changes to already pushed commits

#### Change a Specific Commit Message
``` bash
git rebase -i COMMIT
```

#### Doing a Rebase
``` bash
git rebase -i HEAD~3
```
#### Delete Last Commit but Keep the Changes
``` bash
git reset HEAD^
```
#### Unstage a File
``` bash
git reset HEAD $PATH_OF_REPO
```
#### Remove Ignored Files From Remote

later decided to `.gitignore` them, the files will nevertheless persist in your remote repository.

To remedy this
``` bash
git rm
```

#### Clean up git cache
``` bash
git rm [-r] [-n] --cached <path(s)>
```
- simply add
- commit, and push

#### Hard reset of branch
``` bash
git reset --hard
```
#### Show GPG signatures used in a repo
``` bash
git log --show-signature
```
#### Find local GIT repos
``` bash
sudo find -name HEAD -execdir test -e refs -a -e objects -a -e config \; -printf %h\\n
```

#### Get help with any git command
``` bash
git init --help
```

``` bash
git COMMAND --help
```

#### Clone a git repo with given private ssh key
``` bash
EXTRA_PRIVATE_KEY_PATH="/home/person/.ssh/id_rsa_example"
GIT_REPO_URL="git@github.com:Organization/org-repo-name.git"

git clone -c core.sshCommand="/usr/bin/ssh -i $EXTRA_PRIVATE_KEY_PATH" $GIT_REPO_URL
```

#### Clone a Git Repo
``` bash
git clone git@github.com:elastic/stack-docker.git
```

``` bash
git status
```
#### List the fetched branches for a repository
``` bash
git branch
```

``` bash
git info
```

#### Basic Git config set up

``` bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

#### Git TLS Certificates

Git uses a file named ca-bundle.crt to list all the trusted certificates. We can find that file by typing the following in a terminal window:
``` bash
git config --list --show-origin
```

#### Get TLS info
``` bash
git config --global http.sslCAInfo
```
#### Instruct Git to use GPG2 instead of GPG as the signing program
``` bash
git config --global gpg.program gpg2
```
#### Test by signing text with `gpg` or `gpg2`
``` bash
echo "test" | gpg2 --clearsign
```
#### Set variable for GPG and terminal usage
``` bash
export GPG_TTY=$(tty)
```
### Git Analysis/Reporting

#### Get git global info
``` bash
git config --global --list
```
#### List all remote branches
``` bash
git branch -r
```
#### List remote active branches
``` bash
git ls-remote --heads origin
```
#### Get info about commits for a given user
``` bash
git_user="git_user"
git_date="Sat Aug 30 2021"
git log --oneline -5 --author $git_user --before $git_date
```

#### Create a local branch for testing
``` bash
git checkout -b devops/ID-01-functionality
```

#### Get a histogram for a gitdiff
``` bash
git diff --histogram
```
#### Prints out just the subject line
``` bash
git log --oneline
```
#### A better log displaying
``` bash
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit

```
[source A better git log](coderwall.com/p/euwpig/a-better-git-log)
#### Groups commits by user, again showing just the subject line for concision
``` bash
git shortlog
```
#### Switch to previous branch
``` bash
git checkout -
```
#### Add small patches to a commit
``` bash
git add -p
```
#### Find the last working commit by basically using binary search
``` bash
git bisect start

# for a commit that you know is working correctly
git bisect good

# for a commit that you know is NOT working correctly
git bisect bad
```

#### Ammend a commit
``` bash
git commit --amend COMMIT_ID

git push -f
```

#### Change a commit message that was made
``` bash
#n is the number of commits to go back
git rebase -i HEAD~n

# Best to use git cherry-pick

## then
edit

git push -f
```

## Git implementations: Bitbucket

 Atlassian support [docs](https://support.atlassian.com/bitbucket-cloud/docs/change-the-remote-url-to-your-repository/)

#### Run a query to obtain Project User name, User key, Repo name and Repo Slug
``` sql
SELECT 
       prj.name AS "Project / User Name"
     , prj.project_key AS "Project / User Key"
     , rep.name AS "Repository Name"
     , rep.slug AS "Repository Slug"
FROM repository rep 
INNER JOIN project prj ON rep.project_id = prj.id
ORDER BY prj.name, rep.name
```
- [Bitbucket Knowlege Base](https://confluence.atlassian.com/bitbucketserverkb/how-to-obtain-a-list-of-all-projects-and-repositories-from-bitbucket-database-975027747.html)
- Get detailed info about a remote server
``` bash
git remote --verbose
```
- get extra info about remote
``` bash
git remote show origin
```
- Update the remote URL with git remote set-url using the current and new remote URLs.
``` bash
git remote set-url origin git@bitbucket.org:tutorials/tutorials.git
```
#### List git stashes
``` bash
git stash list
```
#### Reset the current HEAD or changes of your local branch to a specific state
``` bash
git reset [FILE_PATH]
```
