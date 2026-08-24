# once functions are named with opFunction they come up at the end
opFunctionLogInfo() {
    echo "======= [$(date +'%Y-%m-%d %H:%M:%S')] [${FUNCNAME[1]}] $1"
}

# function to show files in current dir
function opFunctionListMyFiles() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    
    # use your preferred ls command
    builtin cd "${DIR}" && \
    ls --file --color=auto
}

function opFunctionUptime() {
    opFunctionLogInfo "System info"
    uname --all
    /usr/bin/time --verbose uptime --pretty
    opFunctionLogInfo "Completed verbose uptime info"
}

function opFunctionUpdateOS(){
  opFunctionGetSecretAdminWSL
  printf "$ADMIN_SECRET" | sudo --stdin apt update
  printf "======= Upgradable System Packages \n"
  apt list --upgradable
  opFunctionLogInfo "Updated the OS package lists"
}

function opFunctionUpgradeOS(){
  opFunctionUpdateOS
  printf "$ADMIN_SECRET" | sudo --stdin apt upgrade --yes
  opFunctionLogInfo "Upgraded OS"
}

function opFunctionListOSFunctions(){
  #!/bin/bash
  printf "======= listing_os_functions() \n"
  declare -F | cut -d' ' -f3
  return 0
}