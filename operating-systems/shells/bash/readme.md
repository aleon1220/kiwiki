# Bash

## 17 Bash Scripting Best Practices

Ideas distilled from the [g0t4/course-bash](https://github.com/g0t4/course-bash) series
(module 6, *Bash Scripting Best Practices*) and applied to the scripts in this directory.

### 1. Persist customizations in `~/.bashrc`

A shell option set by hand dies with the shell, and nothing warns you it is gone.
Put it in `~/.bashrc` so every non-login shell starts the same way.

```bash
# ~/.bashrc
shopt -s globstar    # make **/*.bash match recursively
shopt -s checkwinsize
```

### 2. Keep `PS1` minimal

Show only what you always need. A long prompt wraps your command to the next line.

```bash
PS1='\W$ '        # basename of cwd  -> bash$
PS1='\t \W$ '     # add the time     -> 14:32:05 bash$
PS1='\h:\w$ '     # hostname + full path (usually too busy)
```

`man bash` → **PROMPTING** lists every escape.

### 3. Source separate files to keep `~/.bashrc` tidy

Do not grow a 5000 line `~/.bashrc`. Split it and source the parts, the way
[bashrc_customizations.sh](bashrc_customizations.sh) loads every file in
[.bash_functions/](.bash_functions/).

```bash
BASH_FUNCTIONS_DIR="$HOME/.bash_functions"
for f in "$BASH_FUNCTIONS_DIR"/*.sh; do
    [ -r "$f" ] && source "$f"
done
```

### 4. Dissect aliases and functions with `type` and `set -x`

* upside of an alias is not typing it out
* the downside is forgetting what it does.

```bash
type cdr          # alias cdr='cd "$(repo_root)"'
type repo_root    # dumps the whole function body

# trace it in a subshell so the cd does not affect your current shell
( set -x; cdr; pwd )
```

### 5. Skip or swap a broken rc file with `--norc` and `--rcfile`

When a typo in `~/.bashrc` breaks every new shell, do not fight it blind.

```bash
bash --norc                        # start with no customizations at all
bash --rcfile ~/dotfiles/bash/rc   # start with a different rc file
```

Multi character options must come **before** single character ones:
`bash --norc -x` works, `bash -x --norc` does not.

### 6. Debug startup files with `bash -x` and `bash -v`

`-x` traces what *runs*, `-v` echoes what bash *reads* (so it also shows function
definitions, which never "run"). Combine them when you need both.

```bash
bash -x                     # execution trace, same as set -x
bash -v                     # verbose, every input line as written
bash -xv                    # read line, then the expanded command
bash --rcfile ~/other/rc -x # trace a specific rc file
```

### 7. Login shells read profile files, not `~/.bashrc`

`bash -l` / `bash --login` ignores `~/.bashrc` entirely. It reads `/etc/profile`
(which loops over `/etc/profile.d/*.sh` on Linux, and is much smaller on macOS),
then the **first** user file it finds:

| order | file |
| ----- | ---- |
| 1 | `~/.bash_profile` |
| 2 | `~/.bash_login` |
| 3 | `~/.profile` |

First match wins, the rest are never opened. On exit a login shell also runs
`~/.bash_logout`, which has no meaning for a regular shell. Use `--noprofile` to skip them.

### 8. Prove which startup files bash opens with `strace`

Stop guessing which file set a variable, watch the syscalls.

```bash
strace -e trace=openat bash            > /tmp/non-login.txt 2>&1
strace -e trace=openat bash --noprofile -l > /tmp/login.txt 2>&1
diff /tmp/non-login.txt /tmp/login.txt
```

### 9. Detect an interactive shell with `$-`

`$-` holds the active option letters. An `i` means interactive.

```bash
echo $-                       # himBHs  -> interactive
echo 'echo $-' | bash         # hBs     -> non-interactive
```

Branch on it inside a script to prompt a human or fall back to `$1`:

```bash
if [[ $- == *i* ]]; then
    read -rp "image path: " IMAGE
else
    IMAGE="${1:-}"
fi
```

### 10. Know the difference between `bash -c`, `bash -s` and `bash script.sh`

All three are non-interactive, and `$-` tells you which one you used.

```bash
bash -c 'echo $-'         # hBc  -> command came from -c
echo 'echo $-' | bash     # hBs  -> script came from stdin (-s is implicit)
bash script.sh            # hB   -> script came from a file
```

### 11. Reuse `~/.bashrc` functions in a script with `bash -i`

A piped script never loads `~/.bashrc`, so your helpers are "command not found".

```bash
echo 'repo_root' | bash        # repo_root: command not found
echo 'repo_root' | bash -i     # loads ~/.bashrc first, works
```

Cleaner alternative, source only the file you actually need:

```bash
echo 'source ~/.bash_functions/util_functions.sh; repo_root' | bash
```

### 12. `source script.sh` and `./script.sh` are not the same

`source` (or its `.` alias) runs in the **current** shell, `./` forks a new one.

| | `source ./pad.sh` | `./pad.sh` |
| --- | --- | --- |
| shell | current, inherits interactivity | new, non-interactive |
| `$0` | `bash` | `./pad.sh` |
| `cd` inside | changes your shell | discarded on exit |
| needs `chmod +x` | no | yes, else *permission denied* |

```bash
chmod +x pad.sh
ls -l pad.sh      # look for the x bits: -rwxr-xr-x
```

### 13. Make scripts portable with a `/usr/bin/env` shebang

Hard coding `#!/opt/homebrew/bin/fish` breaks on the next machine.

```bash
#!/usr/bin/env bash
```

The shebang also drives editor syntax highlighting, `bat`, and language servers
on extensionless files. Mnemonic: **she**bang, so hash first, **bang** last.

### 14. Detect a login shell with `shopt login_shell`

`$-` says nothing about login status, `shopt` does.

```bash
shopt login_shell     # login_shell  off
bash -l -c 'shopt login_shell'   # login_shell  on
```

### 15. Start every script with `set -euo pipefail`

The REPL is forgiving on purpose, a script should not be. This is the boilerplate
that turns silent failures into loud ones.

```bash
set -o errexit    # -e  stop on the first failing command
set -o nounset    # -u  error on unset variables instead of empty strings
set -o pipefail   #     a pipeline fails if any stage fails
set -o xtrace     # -x  optional, trace while developing
```

Verify it took effect, and mind the quoting or the `|` becomes a pipe to a
non-existent `nounset` command:

```bash
set -o | grep -E "errexit|nounset|pipefail"
```

### 16. Validate parameters, and give them defaults first

Under `set -u` your own validation is the first thing that explodes, because it
reads a variable that was never assigned. Default the variables, then validate.

```bash
ROLLS="${ROLLS:-}"
SIDES="${SIDES:-}"

if [[ -z "$ROLLS" || -z "$SIDES" ]]; then
    rich --print "[bold white on red]error:[/] --rolls and --sides are both required"
    usage; exit 1
fi

if ! [[ "$ROLLS" =~ ^[1-9][0-9]*$ && "$SIDES" =~ ^[1-9][0-9]*$ ]]; then
    rich --print "[bold white on red]error:[/] --rolls and --sides must be positive integers"
    exit 1
fi
```

Colouring the error keeps it from being lost above a wall of usage text.

### 17. Surface failed exit codes with `PROMPT_COMMAND`

`PROMPT_COMMAND` runs before every prompt. Report only failures, never successes.

```bash
_report_failure() {
    local exit_code=$?
    if (( exit_code != 0 )); then
        printf '\e[1;37;41m command failed: %d \e[0m\n' "$exit_code"
    fi
    return 0
}
PROMPT_COMMAND="_report_failure; ${PROMPT_COMMAND:-}"
```

Capture `$?` on the very first line, anything else overwrites it.

## Bash Cheat Sheet

Section contains shell and bash scripts for different purposes.
Tested and used in Linux ubuntu 18.04 and WSL Ubuntu 18.04, Ubuntu 22

## Some Bash Keyboard tips

* `↑ Up arrow` to recall previous commands
* `Tab` completion
* `Ctrl + A` to go to the beginning of a line
* `Ctrl + L` to clear screen (instead of typing "clear").
* `Ctrl + R` to reverse search through history
* `Ctrl + U` to cancel current input
* `#*` and `##*` for prefix manipulation
* `%` and `%%` for suffix manipulation
* `^^` for pattern substitution of previous command
* `sudo !!` to run previous command with sudo privileges.

## Bash options/Flags

``` bash
set -o errexit
set -o nounset
set -o pipefail
set -o xtrace
```

* Terminate an SSH session that got stuck

``` bash
$ ~?
Supported escape sequences:
 ~.   - terminate connection (and any multiplexed sessions)
 ~B   - send a BREAK to the remote system
 ~C   - open a command line
 ~R   - request rekey
 ~V/v - decrease/increase verbosity (LogLevel)
 ~^Z  - suspend ssh
 ~#   - list forwarded connections
 ~&   - background ssh (when waiting for connections to terminate)
 ~?   - this message
 ~~   - send the escape character by typing it twice
(Note that escapes are only recognized immediately after newline.)
```

## Bash helpful commands

* display file content without comments or empty lines

```bash
FILE_NAME="myfile.conf"

grep -Ev '^#|^\$' $FILE_NAME
```

### alias Command

* common list alias command

```bash
alias ll='ls -alF'
```

* Colorize Output

leverage Colordiff: It may not be installed by default. to install on Ubuntu systems.

```bash
sudo apt -y colordiff
```

* create the aliases

``` bash
alias diff='colordiff'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
```

* aliases for Date & time

``` bash
alias d='date +%F'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%m-%d-%Y"'
```

* Confirmation When Copying, Linking, or Deleting

``` bash
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
```

## System Updates

### Debian / Ubuntu

```bash
alias apt get="sudo apt-get"
alias updateyes="sudo apt-get --yes"
alias updgradeOS="sudo apt update && sudo apt-get upgrade --yes"
```

### RHEL, CentOS, Fedora

```bash
alias update='yum update'
alias updateyes='yum --assumeyes update'
```

### History & Commands Usage

#### 10 Most used commands from history

``` bash
cat ~/.bash_history | tr "\|\;" "\n" | sed -e "s/^ //g" | cut -d " " -f 1 | sort | uniq -c | sort -n | tail -n 10
```

#### Create directories from 1990-2020

``` bash
from=1990
years=30

for i in {0..$years}; do
      echo "mkdir -pv $from the value of i=$i"
      from=$(( $from + 1 ))
done
```

#### Rename files to trim unwanted string "ANNOYING_STRING-"

* Use rename if you want it to operate faster

```bash
for file in * ; do
    echo mv -v "$file" "${file#*ANNOYING_STRING-}"
done
```

#### Quick set up Bash Functions

* From this directory copy the resources to your `$HOME`

```bash
cp --recursive .bash_functions/ $HOME
cp .bash_aliases $HOME
```

* Append to the end of your `.bashrc` file

```bash
cat <<EOF >> $HOME/.bashrc

home_bash_functions=$HOME/.bash_functions/bash_functions.sh
if [ -f \$home_bash_functions ]; then
      source \$home_bash_functions
fi
EOF
```

* source the files to apply the changes

```bash
source $HOME/.bash_aliases
source $HOME/.bashrc
```

#### Create symbolic links

```bash
ln -s lsd lsl
ln -s lsd lsf
ln -s lsd lsx
```

#### Bash process substitution

``` bash
echo <(printf "hi all \n")
```

#### built-in command called `complete`

to execute the auto complete feature for AWSCLI
`complete -C '/usr/local/bin/aws_completer' aws`

### [JSON JQ](https://www.json.org/json-en.html) in bash

### JQ

* [source JQ Manual](https://stedolan.github.io/jq/manual/)
* [source How to Geek](https://www.howtogeek.com/529219/how-to-parse-json-files-on-the-linux-command-line-with-jq/)

one of the nicest things to do is to output JSON to less and see the JSON output in nice colouring.
for that do

#### Colorize json data with `jq` and less

```bash
JSON="your.json" cat $JSON | jq . --color-output | less --RAW-CONTROL-CHARS
```

* another form with short format via flags

```bash
cat your.json | jq . -C | less -R
```

#### Pipe json to console, find a string and colorize output

```bash
cat ~/path/to/env-index.json | jq
cat ~/path/to/env-index.json | jq -R | grep $STRING_TOFIND
```

#### Extract multiple values

```bash
jq ".$JSON_KEY1.$JSON_VALUE1, .$JSON_KEY2.$JSON_Value2, .$JSON_Key3" $FileName.json
```

#### Get values from array

```bash
jq ".$Array_name[].$JSON_VALUE1" $FileName.json
```

#### Get specific element from array. If you know the position

Remember the array uses a zero-offset

```bash
jq ".$Array_name[3].$JSON_VALUE1" $FileName.json
```

##### JQ delete function

`del()` to delete a `key:value` pair

it just removes it from the output of the command.

If you need to create a new file without the message `key:value pair` in it, run the command, and then redirect the output into a new file.

* set variables

``` bash
FULL_JSON_FILE="big-json-file.json"
NEW_JSON_FILE="metadata.json"
JSON_KEY01="OTA_URL_PREFIX"
JSON_KEY02="REL_NOTE"
```

* Remove JSON Keys `JSON_KEY01` & `JSON_KEY02`

```bash
jq "del(.JSON_KEY01, .JSON_KEY02)" "$FULL_JSON_FILE" > "$NEW_JSON_FILE"
```

* delete one key and output in screen

```bash
jq "del(.$JSON_KEY1)" $FULL_JSON_FILE
```

* retrieve the names of a list from the object at index position e.g. 995 through the end of the array

```bash
jq ".[995:] | .[] | .name" $FileName.json
```

* `.[995:]:` This tells jq to process the objects from array index 995 through the end of the array. No number after the colon ( : ) is what tells jq to continue to the end of the array.
* `.[]:` This array iterator tells jq to process each object in the array.
* `.name:` This filter extracts the name value.

##### Extract the last 10 objects from the array. A “-10” instructs jq to start processing objects 10 back from the end of the array

```bash
jq ".[-10:] | .[] | .name" $FileName.json
```

##### Apply slicing to strings. Request the first four characters of the name of the object at array index 234

```bash
jq ".[234].name[0:4]" $FileName.json
```

##### See a specific object in its entirety

```bash
jq ".[234]" $FileName.json
```

##### see only the values, you can do the same thing without the key names

```bash
jq ".[234][]" $FileName.json
```

##### Retrieve multiple values from each object, we separate them with commas

```bash
jq ".[450:455] | .[] | .JsonValue1, .JsonValue2" $FileName.json
```

* Retrieve nested values, you have to identify the objects that form the “path” to them

Include the all-encompassing array, the nested object, and the nested array, as shown below

```bash
jq ".[121].Object.ArrayJson[]" $FileName.json
```

##### JQ length Function

```bash
jq ".[100:110] | .[].name | length" $FileName.json
```

##### see how many `key:value` pairs are in the first object in the array

```bash
jq ".[0] | length" "$FileName"
```

##### JQ keys Function

find out about the JSON you’ve got to work with. It can tell you what the names of the keys are, and how many objects there are in an array

#### find Keys in ObjectName

```bash
jq ".ObjectName.[0] | keys"  $FileName.json
```

* Find elements in ObjectName

Zero-offset array elements, numbered zero to N

```bash
jq ".ObjectName | keys" $FileName.json
```

#### JQ Function has()

function to interrogate the JSON and see whether an object has a particular key name. Note the key name must be wrapped in quotation marks.

```bash
jq '.[] | has("nametype")' $FileName.json
```

### has() on specific object

check a specific object, you include its index position in the array filter

```bash
jq '.[678] | has("nametype")' $FileName.json
```

#### Rename JSON Keys

``` bash
# ZIP_HASH to FILE_HASH & ZIP_SIZE to FILE_SIZE
jq '[ . | .["ZIP_HASH"] = .FILE_HASH | .["ZIP_SIZE"] = .FILE_SIZE | del(.ZIP_HASH, .ZIP_SIZE)]' "${OTA_ARTIFACTS_OUT_DIR}/temp0.json" > "${TA_ARTIFACTS_OUT_DIR}/temp1.json"
```

* extract a key where an array is empty
* set variables

``` bash
FULL_JSON_FILE="current-images.jsonl"
FILTER_ARRAY_ELEMENT=".boundingBoxAnnotations"
KEY_TO_FETCH=".imageGcsUri"
NEW_OUTPUT_FILE="unlabeled_images.txt"
```

* perform the selection

``` bash
jq -r 'select( "$FILTER_ARRAY_ELEMENT" | length == 0) | "$KEY_TO_FETCH" ' "$FULL_JSON_FILE"  > "$NEW_OUTPUT_FILE"
```

## Reference Material

1. [Medium Query Bash best practices](https://medium.com/search?q=bash%20best%20practices)
2. [Linux terminal trick opensource.com](https://opensource.com/article/20/1/linux-terminal-trick)
3. [g0t4/course-bash](https://github.com/g0t4/course-bash) - example code for the Pluralsight bash course series
4. [Bash Script Flow & Basic Utilities](https://app.pluralsight.com/library/courses/bash-script-flow-basic-utilities) - first published course in that series
