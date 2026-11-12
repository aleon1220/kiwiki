# Git

System to manage and store source code. Keeps track of changes to files. Text files only
refer to [git official manual](https://git-scm.com/docs/user-manual)

## Git Administration/Operation

### Git Global Settings

* Get general git repo info

```bash
git config --list
```

* Get global config info

```bash
git config --global --list
```

* do basic config setup

will apply to all repositories

```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

* set CLI editor

use nano  for simplicity compared to `vim`

```bash
git config --global core.editor "nano"
```

## git Default Flow

* usual add, commit, push

```bash
git add . ; git commit ; git push
```

* Force-switches to branch, discarding changes

```bash
git checkout main --force
```

* fetch from remote and then merge to develop

```bash
git fetch
git merge origin/develop
```

* Push changes to remote branch `my-feature`

```bash
git push origin :my-feature
```

* use `@` instead of `HEAD`

* Delete Remote Branches

```bash
git push REMOTE -d BRANCH
```

* Delete remote branch (short form `:`)

```bash
git push REMOTE :BRANCH
```

* Remove remote branches that were deleted (merged)

> tested on BitBucket

```bash
git config fetch.prune true 
```

* Change remote URL if you change your repository’s name

```bash
git remote set-url REMOTE $NEWURL
```

* Github set remote URL

```bash
git remote set-url origin github.com/myusername/my-repo
```

### Stash Individual Files

* set var for file to stash

```bash
file_stash="src/index.js"
```

* add to stash

```bash
git stash push -- $file_stash
```

* Show Content of Most Recent Stash

```bash
git stash show -p [stash@{<n>}]
```

**Flags Explanation:**

* `-p` to see the actual content of the stash. Omitting it will show only the file names.
* `stash@{<n>}` allows us to specify a certain stash, denoted by `n` ( 0 being the most recent one )

```bash
git stash show -p stash@{1}
```

* List git stashes

```bash
git stash list
```

* Reset the current HEAD or changes of your local branch to a specific state

```bash
git reset [FILE_PATH]
```

* Check Out File From Another Branch

```bash
BRANCH="main"
PATH_TO_CHECKOUT="src/functions.py"

git checkout $BRANCH -- $PATH_TO_CHECKOUT
```

### Work with 2 branches

* Creates a linked working tree (i.e., another directory on the file system associated with the repo) called `my-other-awesome-feature`, one level above your current working directory, with the specified branch checked out.

```bash
git worktree add <path> <branch>
```

```bash
git worktree add my-other-awesome-feature ../my-other-awesome-feature

git worktree remove ../my-other-awesome-feature
```

* when you no longer need the branch:

```bash
git worktree remove [-f] PATH_TO_MODIFY
```

* Show Commit Contents

Shows changes introduced by a commit

```bash
git show $COMMIT_ID
```

* see the changes between two specific commits run

```bash
git diff $COMMIT_A $COMMIT_B
```

* Show changes-diff with remote HEAD

```bash
git diff HEAD~ HEAD
```

* Compare Files Between Branches/Commits

```bash
COMMIT_A="0659bdc"
COMMIT_B="e6c7c0d"
FILE_PATH_COMPARE="src/automate.py"

git diff $COMMIT_A $COMMIT_B -- $FILE_PATH_COMPARE
```

* Reset a Single File to a specific Commit

```bash
git checkout [<$COMMIT_ID>] -- <path(s)>
```

* Reset a single file

```bash
FILE_TO_RESET="README.md"
git checkout -- $FILE_TO_RESET
```

* Change Last Commit Message

```bash
git commit --amend [-m 'MESSAGE']

git push -f
```

* If the old commit had already been pushed

```bash
git push --force-with-lease REMOTE BRANCH
```

**Note:**
* be careful when making any changes to already pushed commits

---
### Git Rebase

#### Change a Specific Commit Message

one commit with the wrong email address. The commit history must be updated

* List commits with author emails to find target commits

```bash
git log --all --pretty=format:"%h %an <%ae> %s" | grep "authorName@outlookcom
```

* could use full scan

```bash
git log --pretty=full
```

* Start an interactive rebase that stops just before that commit

```bash
TARGET_COMMIT="abc1234"
git rebase -i "$TARGET_COMMIT"^
```

* from the text editor, choose a git rebase operation

Change `pick` to `edit` for that commit, save, and close.

```bash
pick "$TARGET_COMMIT" commit message with changes here
```

* Amend the author on that commit

```bash
git commit --amend --author="Author Name <authorName@outlook.com>" --no-edit
```

* Continue the rebase

Git will replay multiple queued commits after this automatically.

```bash
git rebase --continue
```

* Push your updated history

```bash
TARGET_BRANCH="your-branch"
git push --force-with-lease origin $TARGET_BRANCH
```

* Verify the fix

```bash
git log -1 --pretty=full
```
---

* Doing a Rebase for the previous 3 commits

```bash
git rebase -i HEAD~3
```

### Many commits across the whole repo need re-writing

For broad changes, consider a history rewrite tool:
`git filter-repo` (recommended, separate install): powerful and fast for bulk author rewrites.

* using `git filter-repo`

```bash
git filter-repo --mailmap .mailmap
```

* Delete Last Commit but Keep the Changes

```bash
git reset HEAD^
```

* Unstage a File

```bash
git reset HEAD $PATH_OF_REPO
```

### Remove Ignored Files Remote repo

if `.gitignore` is updated, previously created files will persist in your remote repository. To remedy this

* remove files and clean up

```bash
git rm
```

* clean up git cache

```bash
git rm [-r] [-n] --cached <path(s)>
```

* reset everything to match the remote branch

```bash
git fetch origin
git reset --hard origin/main
```

* Find local GIT repos

```bash
sudo find -name HEAD -execdir test -e refs -a -e objects -a -e config \; -printf %h\\n
```

* Get help with any git command

```bash
git $COMMAND --help

git init --help
```

* Clone a repo with given private ssh key

```bash
EXTRA_PRIVATE_KEY_PATH="/home/user/.ssh/id_rsa_example"
GIT_REPO_URL="git@github.com:Organization/org-repo-name.git"

git clone -c core.sshCommand="/usr/bin/ssh -i $EXTRA_PRIVATE_KEY_PATH" $GIT_REPO_URL
```

### Clone a Git Repo with fine grained token

* set variables

```bash
YOUR_GITHUB_USERNAME="username"
YOUR_TOKEN="github_pat_key"
REPO_URI="github-org/github-repo-name.git"
```

* clone the repo

```bash
git clone "https://$YOUR_GITHUB_USERNAME:$YOUR_PAT@github.com/$REPO_URI" .
```

* List the fetched branches for a repository

```bash
git branch
```

## Git Conflict resolution

### Give priority to dev over main

You have merge conflicts and want dev to win

* Ensure your local repository is up to date

```bash
git fetch origin
```

* Switch to your dev branch

```bash
git checkout dev
git pull origin dev
```

* Merge main into dev, but force Git to keep dev's changes during conflicts

```bash
git merge origin/main -X ours
```

* Push the resolved branch back to GitHub

```bash
git push origin dev
```

---

## Git Security
refers to encryption and commit signing

### Git commit sign
* prefer sign commits with PGP encryption
* SSH much easier but less secured

* Git TLS Certificates

Git uses a file named `ca-bundle.crt` to list all the trusted certificates. We can find that file by typing the following in a terminal window:

```bash
git config --list --show-origin
```

* Get TLS info

```bash
git config --global http.sslCAInfo
```

* Instruct Git to use GPG2 instead of GPG2 as the signing program

```bash
git config --global gpg.program gpg2
```

* Test GPG2 encrytion

signing text with `gpg` or `gpg2`

```bash
echo "test" | gpg2 --clearsign
```

* Set variable for GPG and terminal usage

```bash
export GPG_TTY=$(tty)
```

* Sign the Commit GPG

```bash
git commit -S -m "SSH signed commit"
```

### Sign commits with SSH Key

* Configure Git to use SSH for commit signing

```bash
git config --global gpg.format ssh
```

* Refer to Public SSH Key

use default values

```bash
git config --global user.signingkey ~/.ssh/id_rsa.pub
```

* Use an alias to add, commit and push

```bash
alias gacp_extrakey="git add . && git -c core.sshCommand='/usr/bin/ssh -i \$HOME/.ssh/extrakey' commit -S && git -c core.sshCommand='/usr/bin/ssh -i \$HOME/.ssh/extrakey' push"

gacp_extrakey
```

* Show GPG signatures used in a repo

```bash
git log --show-signature
```

* push with alternative SSH key

```bash
git -c core.sshCommand="/usr/bin/ssh -i /home/user/.ssh/id_alternative" push
```

---

## Git Analysis/Reporting

* List all remote branches

```bash
git branch --remotes
```

* List remote active branches

```bash
git ls-remote --heads origin
```

* Get info about commits for a given user

```bash
git_user="git_user"
git_date="Sat Aug 30 2024"

git log --oneline -5 --author $git_user --before $git_date
```

* Create a local branch for testing

```bash
git checkout -b feature/ID01-functionality
```

* Get a histogram for a gitdiff

```bash
git diff --histogram
```

* Print out subject line

```bash
git log --oneline
```

* Better log displaying

```bash
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
```

* Groups commits by user, shows the subject line for simplicity

```bash
git shortlog
```

* Switch to previous branch

```bash
git checkout -
```

* Add small patches to a commit

```bash
git add -p
```

### Find the last working commit by basically using binary search

* begin the process

```bash
git bisect start
```

* Select a commit that you know is working correctly

```bash
git bisect good
```

* select a commit that you know is NOT working correctly

```bash
git bisect bad
```

* Change/Ammend commit message made long ago

**n** is the number of commits to go back

```bash
git rebase -i HEAD~n

# Use
git cherry-pick

## then edit the cherry-picked commit
edit

git push --force
```

* Check size of repo

```bash
git count-objects -vH
```

* Get detailed info about a remote server

```bash
git remote --verbose
```

* get extra info about remote

```bash
git remote show origin
```

## PR Pull Request Version Control

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

* Report Project User name, User key, Repo name and Repo Slug: run a SQL query in the PostgreSQL DB

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

* Update the remote URL using current and new remote URL

```bash
git remote set-url origin git@bitbucket.org:tutorials/tutorials.git
```

## Git implementations GitHub — GitHub CLI (`gh`)

`gh` is the official GitHub command-line tool ([cli.github.com](https://cli.github.com/)) that integrates repositories, issues, pull requests, GitHub Projects (`/projects`), GitHub Actions workflows, and releases directly into the terminal alongside `git`.

* **Standalone Deep-Dive Guide:** [GitHub CLI (`gh`) Full Guide & `/projects` Use Cases](./github-cli.md)
* **Official Documentation:** [GitHub CLI Manual](https://cli.github.com/manual/)

### 1. Authentication, Multi-Account & Token Scopes (`gh auth`)

* Interactive login and automatic Git credential setup

```bash
gh auth login
gh auth setup-git
```

* Authenticate in CI/CD or headless environments with a Fine-Grained Personal Access Token (PAT)

```bash
export GH_TOKEN="github_pat_xxxxxxxxxxxx"
# Or via stdin:
echo "$MY_GITHUB_PAT" | gh auth login --with-token
```

* Verify current authentication status and token scopes

```bash
gh auth status
```

* Switch between multiple authenticated GitHub accounts (e.g., work vs. personal)

```bash
gh auth switch --user <github-username>
```

* Add the `project` token scope required for managing GitHub Projects (`/projects`)

```bash
gh auth refresh -s project,read:project
```

### 2. Repository, Rulesets & Issue Management (`gh repo`, `gh issue`)

* Clone a repository or create a new repository from an organization template

```bash
gh repo clone <org-or-user>/<repo-name>
gh repo create <org-or-user>/<new-repo> --template <org-or-user>/<template-repo> --private --clone
```

* Verify active repository rulesets and branch protection on `main`

```bash
gh ruleset list
gh ruleset check main
```

* Create an issue and immediately generate a linked feature branch (`gh issue develop`)

```bash
ISSUE_URL=$(gh issue create \
  --title "fix(auth): handle token refresh timeout" \
  --body "Acceptance criteria and reproduction steps..." \
  --label "bug,priority:high" \
  --assignee "@me")

ISSUE_NUM="${ISSUE_URL##*/}"
gh issue develop "$ISSUE_NUM" --checkout --name "fix/${ISSUE_NUM}-token-refresh-timeout"
```

### 3. Pull Request Lifecycle & CI Checks (`gh pr`, `gh run`)

* Open an early Draft Pull Request to trigger CI checks before requesting human review

```bash
gh pr create \
  --draft \
  --base main \
  --fill \
  --assignee "@me" \
  --label "work-in-progress"
```

* Watch CI checks in real time from the terminal and inspect failed step logs if a check fails

```bash
gh pr checks --watch --fail-fast
gh run view <run-id> --log-failed
gh run rerun <run-id> --failed
```

* Check out a teammate's PR locally, inspect the diff, and submit an approval review

```bash
gh pr checkout 145
gh pr diff 145
gh pr review 145 --approve --body "LGTM! Verified locally and CI checks pass."
```

* Rebase PR branch onto `main`, mark Ready for Review, and enable Squash Auto-Merge

```bash
gh pr update-branch --rebase
gh pr ready
gh pr merge --squash --delete-branch --auto
```

### 4. GitHub Projects (`/projects`) Module Use Cases (`gh project`)

GitHub Projects (`https://github.com/orgs/<org>/projects` or `https://github.com/users/<user>/projects`) provides cross-repository planning and tracking.

* **Use Case A — Board Provisioning, Template Cloning & Linking:** Create or copy a standardized project board and link it to repositories and teams

```bash
ORG="my-org"

# List existing projects or create a new board
gh project list --owner "$ORG"
gh project create --owner "$ORG" --title "Q4 Platform Delivery"

# Copy an existing organization template project (including draft issues)
gh project copy 1 \
  --source-owner "$ORG" \
  --target-owner "$ORG" \
  --title "Service Migration - Phase 2" \
  --drafts

# Link repositories and teams to project #4
PROJECT_NUM=4
gh project link "$PROJECT_NUM" --owner "$ORG" --repo "core-service"
gh project link "$PROJECT_NUM" --owner "$ORG" --team "platform-team"
```

* **Use Case B — Custom Schema & Field Governance (`field-create`, `field-list`):** Define tech-stack-neutral fields (`Priority`, `Size`, `Points`, `Target Date`)

```bash
PROJECT_NUM=4
ORG="my-org"

gh project field-list "$PROJECT_NUM" --owner "$ORG"

gh project field-create "$PROJECT_NUM" \
  --owner "$ORG" \
  --name "Priority" \
  --data-type "SINGLE_SELECT" \
  --single-select-options "P0-Critical,P1-High,P2-Medium,P3-Low"

gh project field-create "$PROJECT_NUM" \
  --owner "$ORG" \
  --name "Size" \
  --data-type "SINGLE_SELECT" \
  --single-select-options "XS,S,M,L,XL"

gh project field-create "$PROJECT_NUM" --owner "$ORG" --name "Target Date" --data-type "DATE"
```

* **Use Case C — Backlog Intake & Cross-Repository Filtering (`item-create`, `item-add`, `item-list`):** Add draft items or existing Issues/PRs and query board state

```bash
PROJECT_NUM=4
ORG="my-org"

# Create a draft architecture spike on the board before repo assignment
gh project item-create "$PROJECT_NUM" \
  --owner "$ORG" \
  --title "Spike: Evaluate OpenTelemetry collector memory footprint" \
  --body "Define benchmark criteria before creating service-specific implementation issues."

# Attach an existing repository Issue or PR to the project board
gh project item-add "$PROJECT_NUM" \
  --owner "$ORG" \
  --url "https://github.com/my-org/core-service/issues/142"

# List open items assigned to you (excluding Done) with Status and Priority columns
gh project item-list "$PROJECT_NUM" \
  --owner "$ORG" \
  --query "assignee:@me is:open -status:Done" \
  --field "Status" \
  --field "Priority"
```

* **Use Case D — Automated Item State Transitions & Sprint Cleanup (`item-edit`, `item-archive`):** Move items across workflow columns and archive completed items

```bash
PROJECT_NUM=4
ORG="my-org"
ISSUE_URL="https://github.com/my-org/core-service/issues/142"

# Transition item Status and Priority by URL and field name
gh project item-edit "$PROJECT_NUM" --owner "$ORG" --url "$ISSUE_URL" --field "Status" --value "In Progress"
gh project item-edit "$PROJECT_NUM" --owner "$ORG" --url "$ISSUE_URL" --field "Priority" --value "P1-High"

# Archive all "Done" items on the project board after release
gh project item-list "$PROJECT_NUM" --owner "$ORG" --query "status:Done" --format json \
  --jq -r '.items[].id' | while read -r item_id; do
    gh project item-archive "$PROJECT_NUM" --owner "$ORG" --id "$item_id"
done
```

### 5. Language-Neutral SDLC Patterns for Stable Flow

1. **Issue-First Traceability (`gh issue develop`):** Every branch originates from a triaged issue registered on the `/projects` board.
2. **Small Batch Sizes & Early Draft PRs (`gh pr create --draft`):** Push the first atomic commit early and open a Draft PR so stack-neutral CI checks run continuously.
3. **Zero-Context-Switch CI Debugging (`gh pr checks --watch` + `gh run view --log-failed`):** Diagnose build, lint, or test failures directly in the terminal.
4. **Work-in-Progress (WIP) Limits & Review-First Daily Cadence:** Prioritize unblocking teammate PRs (`gh pr list --search "is:open review-requested:@me -is:draft"`) before starting new branches.
5. **Trunk Stability via Rebase & Auto-Merge (`gh pr update-branch --rebase` + `gh pr merge --auto`):** Keep `main` perpetually releasable and let quality gates merge PRs automatically.
6. **Deterministic Semantic Releases (`gh release create vX.Y.Z --generate-notes --verify-tag`):** Cut immutable releases and archive completed project items.

## Git implementations GitLab

## Git implementations Azure ADO Repos

* **Azure DevOps Overview & CLI (`az repos`):** [Azure DevOps (ADO)](../../cloud-computing/azure/ado/readme.md)

---

## Git flow by example

<details>
<summary> git flow example </summary>

Quick Start: Learning `git` basics by example. Flow challenge/Demo by hackerRanx.

See git in action with the [Git flow by example](#git-flow-by-example)

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

* set local git config settings

```bash
git config user.email "me@hackerrank.com"
git config user.name "hackerrank"
```

* Create a develop branch (clones main references)

```bash
git checkout -b develop
```

* Check available branches in the repo

```bash
git branch
* main
  test
```

* check git working tree status

```bash
git status
```

* Check the log to see info about all commits `git log`

```bash
commit 4c569ff830048206717d62544efbd288f85005e3 (HEAD -> main, test)
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

* Verify commits in `develop` branch

```bash
git rev-list --date-order --abbrev-commit --reverse HEAD

3ca1959
360dba4
cf10ff6
4c569ff
[74][22:07:50] ubuntu@taskserver:[/var/save/repo]
```

* merge develop --> main

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
