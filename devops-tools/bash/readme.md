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
