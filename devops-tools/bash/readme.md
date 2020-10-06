# Bash Cheat Sheet
This section contains .bash_functions/ and .bash_aliases used and tested in Linux ubuntu 18.04

The alias Command
alias [name[=value]]
Colorize Output
# Colordiff may not be installed by default.  (sudo apt-get -y colordiff to install on Ubuntu systems.)
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
System Updates
# Debian / Ubuntu:
alias apt-get="sudo apt-get"
alias updatey="sudo apt-get -y"
alias update='sudo apt-get update && sudo apt-get upgrade'
 # RHEL, CentOS, Fedora
alias update='yum update'
alias updatey='yum -y update'

## Create dirs from 1990-2020
``` shell
years=30
from=1990
for i in {0..30}; do
      echo "mkdir $from the value of i=$i"
      from=$(( $from + 1 ))
done
```

## Rename lots of files to trim annoying unwanted strings "ANNOYING_STRING-". Use rename if you want it to operate faster
``` shell
for file in * ; do
    echo mv -v "$file" "${file#*ANNOYING_STRING-}"
done
```

## Quick set up
- From this directory copy the resources to your $HOME/
```bash
cp --recursive .bash_functions/ $HOME
cp .bash_aliases $HOME
```
- Append to the end of your .bashrc file
```bash
cat <<EOF >> $HOME/.bashrc

home_bash_functions=$HOME/.bash_functions/bash_functions.sh
if [ -f \$home_bash_functions ]; then
      source \$home_bash_functions
fi
EOF
```
- source the files
```bash
source $HOME/.bash_aliases
source $HOME/.bashrc
```
- Create links
```
ln -s lsd lsl
ln -s lsd lsf
ln -s lsd lsx
```

## Encryption

### Java Key Store
#### single line command to generate a .keystore or .jks
`echo y | keytool -genkeypair -dname "cn=Mark Jones, ou=JavaSoft, o=Sun, c=US" -alias business -keypass kpi135 -keystore /working/android.keystore -storepass ab987c -validity 20000`

##### flags explanation
``` bash
dname=is a unique identifier for the application in the .keystore
      cn=the full name of the person or organization that generates the .keystore
      ou=Organizational Unit that creates the project, its a subdivision of the Organization that creates it. Ex. android.google.com
      o=Organization owner of the whole project. Its a higher scope than ou. Ex.: google.com
      c=The country short code. Ex: For United States is "US"

alias=Identifier of the app as an single entity inside the .keystore (it can have many)
keypass=Password for protecting that specific alias.
keystore= Path where the .keystore file shall be created (the standard extension is actually .ks)
storepass=Password for protecting the whole .keystore content.
validity=Amout of days the app will be valid with this .keystore
```