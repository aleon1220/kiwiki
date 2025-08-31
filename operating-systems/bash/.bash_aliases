#########
# Aliases
#########

# Based on Digital Ocean (https://www.digitalocean.com/community/tutorials/an-introduction-to-useful-bash-aliases-and-functions)

alias ll="ls --color -lhA"
alias ls="ls --color -CF"
alias sl="ls --color"
alias lsl="ls -lhFA | less"
alias cd..="cd .."

# find files in our current directory
alias fhere="find . -name "

# System Aliases
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -h"
# listing process table
alias ps="ps auxf"
# passing an argument
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias mkdir="mkdir --parents --verbose"
alias wget="wget -c"

# history and grep
alias histg="history | grep"
alias top="htop"

# Get public IP
alias myip="curl http://ipecho.net/plain; echo"

