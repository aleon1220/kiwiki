# Bash Cheat Sheet
This section contains [`.bash_functions/`](.bash_functions/bash_functions.sh) and [.bash_aliases](.bash_aliases) files. I tried adding the most commonly used actions. This is  tested and used in Linux ubuntu 18.04 and WSL Ubuntu 18.04.

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=3 orderedList=false} -->

<!-- code_chunk_output -->

- [Bash Cheat Sheet](#bash-cheat-sheet)
  - [Bash options/Flags](#bash-optionsflags)
  - [System Updates](#system-updates)
    - [Debian / Ubuntu:](#debian--ubuntu)
    - [RHEL, CentOS, Fedora](#rhel-centos-fedora)
    - [JSON JQ in bash](#json-jq-in-bash)
    - [JQ](#jq)
    - [has() on specific object](#has-on-specific-object)
    - [Some tips](#some-tips)
  - [Readings](#readings)

<!-- /code_chunk_output -->

## Bash options/Flags
``` bash
set -o errexit
set -o nounset
set -o pipefail
set -o xtrace
```

#### The alias Command
`alias [name[=value]]`
#### Colorize Output
#### install Colordiff
It may not be installed by default. to install on Ubuntu systems.
`sudo apt-get -y colordiff`

``` bash
alias diff='colordiff'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'

Date and Time Aliases
alias d='date +%F'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%m-%d-%Y"'
Confirmation When Copying, Linking, or Deleting
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
```

## System Updates

### Debian / Ubuntu:
```bash
alias apt-get="sudo apt-get"
alias updatey="sudo apt-get -y"
alias update="sudo apt-get update && sudo apt-get upgrade"
```
### RHEL, CentOS, Fedora
```bash
alias update='yum update'
alias updatey='yum -y update'
```

#### 10 Most used commands from history
``` bash
cat ~/.bash_history | tr "\|\;" "\n" | sed -e "s/^ //g" | cut -d " " -f 1 | sort | uniq -c | sort -n | tail -n 10
```

#### Create dirs from 1990-2020
``` bash
from=1990
years=30

for i in {0..$years}; do
      echo "mkdir -pv $from the value of i=$i"
      from=$(( $from + 1 ))
done
```

#### Rename files to trim unwanted string "ANNOYING_STRING-"
Use rename if you want it to operate faster
```bash
for file in * ; do
    echo mv -v "$file" "${file#*ANNOYING_STRING-}"
done
```

#### Quick set up Bash Functions
- From this directory copy the resources to your $HOME/
```bash
cp --recursive .bash_functions/ $HOME
cp .bash_aliases $HOME
```
- Append to the end of your `.bashrc` file

```bash
cat <<EOF >> $HOME/.bashrc

home_bash_functions=$HOME/.bash_functions/bash_functions.sh
if [ -f \$home_bash_functions ]; then
      source \$home_bash_functions
fi
EOF
```bash
- source the files
```bash
source $HOME/.bash_aliases
source $HOME/.bashrc
```
- Create sym links
```bash
ln -s lsd lsl
ln -s lsd lsf
ln -s lsd lsx
```

#### Terminate an SSH session that got stuck
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

#### Bash process substitution
``` bash
echo <(printf "hi all \n")
```

there is a built-in command called `complete`. Example to execute the auto complete feature for AWSCLI
`complete -C '/usr/local/bin/aws_completer' aws`

### [JSON JQ](https://www.json.org/json-en.html) in bash
### JQ
- [source JQ Manual](https://stedolan.github.io/jq/manual/)
- [source How to Geek](https://www.howtogeek.com/529219/how-to-parse-json-files-on-the-linux-command-line-with-jq/)

one of the nicest things to do is to output JSON to less and see the JSON output in nice colouring.
for that do

#### colorize json data with jq and less
`JSON="your.json" cat JSON | jq . --color-output | less --RAW-CONTROL-CHARS`
`# for the impatient \ cat your.json | jq . -C | less -R`
##### Pipe json to console, find a string and colorize output
```bash
cat ~/path/to/env-index.json | jq
cat ~/path/to/env-index.json | jq -R | grep $STRING_ToFind
cat ~/path/to/env-index.json | jq -C '.' | less -R
```

#### Extract multiple values
`jq ".$JSON_KEY1.$JSON_VALUE1, .$JSON_KEY2.$JSON_Value2, .$JSON_Key3" $FileName.json`

#### Get values from array
`jq ".$Array_name[].$JSON_VALUE1" $FileName.json`

#### Get specific element from array. If you know the position
Remember the array uses a zero-offset
`jq ".$Array_name[3].$JSON_VALUE1" $FileName.json`

#####  jq‘s delete function, del(), to delete a key:value pair
it just removes it from the output of the command. If you need to create a new file without the message key:value pair in it, run the command, and then redirect the output into a new file.
`jq "del(.$JSON_KEY1)" $FileName.json`

#####  retrieve the names of a list from the object at index position e.g. 995 through the end of the array
`jq ".[995:] | .[] | .name" $FileName.json`

- `.[995:]:` This tells jq to process the objects from array index 995 through the end of the array. No number after the colon ( : ) is what tells jq to continue to the end of the array.
- `.[]:` This array iterator tells jq to process each object in the array.
- `.name:` This filter extracts the name value.

##### Extract the last 10 objects from the array. A “-10” instructs jq to start processing objects 10 back from the end of the array.
`jq ".[-10:] | .[] | .name" $FileName.json`

##### Apply slicing to strings. Request the first four characters of the name of the object at array index 234
`jq ".[234].name[0:4]" $FileName.json`

##### See a specific object in its entirety
`jq ".[234]" $FileName.json`

##### see only the values, you can do the same thing without the key names
`jq ".[234][]" $FileName.json`

##### Retrieve multiple values from each object, we separate them with commas
`jq ".[450:455] | .[] | .JsonValue1, .JsonValue2" $FileName.json`

##### Retrieve nested values, you have to identify the objects that form the “path” to them.
Include the all-encompassing array, the nested object, and the nested array, as shown below
`jq ".[121].Object.ArrayJson[]" $FileName.json`

##### JQ length Function
`jq ".[100:110] | .[].name | length" $FileName.json`

##### see how many key:value pairs are in the first object in the array
`jq ".[0] | length" $FileName.json`

##### JQ keys Function
find out about the JSON you’ve got to work with. It can tell you what the names of the keys are, and how many objects there are in an array

#### find Keys in ObjectName
`jq ".ObjectName.[0] | keys"  $FileName.json`

#### Find elements in ObjectName
Zero-offset array elements, numbered zero to N
`jq ".ObjectName | keys" $FileName.json`

#### JQ has() Function
function to interrogate the JSON and see whether an object has a particular key name. Note the key name must be wrapped in quotation marks.
`jq '.[] | has("nametype")' $FileName.json`

### has() on specific object
check a specific object, you include its index position in the array filter
`jq '.[678] | has("nametype")' $FileName.json`

#### Rename JSON Keys
``` bash
# ZIP_HASH to FILE_HASH & ZIP_SIZE to FILE_SIZE
jq '[ . | .["ZIP_HASH"] = .FILE_HASH | .["ZIP_SIZE"] = .FILE_SIZE | del(.ZIP_HASH, .ZIP_SIZE)]' "${OTA_ARTIFACTS_OUT_DIR}/temp0.json" > "${TA_ARTIFACTS_OUT_DIR}/temp1.json"
```
##### Remove JSON Keys
``` bash
# remove OTA_URL_PREFIX and REL_NOTE
jq "del(.OTA_URL_PREFIX, .REL_NOTE)" "${OTA_ARTIFACTS_OUT_DIR}/temp1.json" > "${OTA_ARTIFACTS_OUT_DIR}/${BUILD_ID}-metadata.json"
set -xeu -o pipefail # print exec and fail exec
zip -r "${OTA_ARTIFACTS_OUT_DIR}/${BUILD_ID}.upd" "${OTA_ARTIFACTS_OUT_DIR}/${BUILD_ID}-metadata.json" "${OTA_ARTIFACTS_OUT_DIR}/${BUILD_ID}.zip"
```

### Some tips

- `Up arrow` to recall previous commands
- `Tab` completion
- `Ctrl + A` to go to the beginning of a line
- `Ctrl + L` to clear screen (instead of typing "clear").
- `Ctrl + R` to reverse search through history
- `Ctrl + U` to cancel current input
- `#*` and `##*` for prefix manipulation
- `%` and `%%` for suffix manipulation
- `^^` for pattern substitution of previous command
- `sudo !!` to run previous command with sudo privileges.
- `grep -Ev '^#|^\$' $file` will display file content without comments or empty lines."

source [opensource.com](https://opensource.com/article/20/1/linux-terminal-trick)

## Readings
- [Medium Query Bash best practices](https://medium.com/search?q=bash%20best%20practices)

[Back to top](#)