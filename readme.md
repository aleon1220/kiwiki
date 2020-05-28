# Wiki Information Technology
it happened in 2020-04-28. For years i have been collecting snippets on linux, solaris, C, Java, Docker, Kubernetes, etc.
Then a google docs file was inside of a google drive folder. I accidentally deleted the folder and later on i emptied the bin. I truly dislike that. 
I got in touch with google support to no avail. 
I still hope i can recover my file.

Dont rely on the cloud 100%. Have local copies of your digital material.

# To be Categorized
`df -h`<br>
`uname -a` <br>
`cat ~/.ssh/id_rsa.pub`<br>
`sudo apt --fix-broken install`<br>
`sudo apt-get purge unattended-upgrades`<br>
`cat /etc/apt/apt.conf.d/10periodic`<br>
`sudo visudo`<br>

`scp -r $RANQX_LO_LOCAL_PATH/sftp-shim ubuntu@$SFTPSHIM_SERVER_DNS:$SFTP_DEPLOYMENT_PATH`<br>
`curl localhost:80`<br>
`stat %A $DIR`<br>
`sudo mv $DIR1 $DIRDestiny`<br>
`echo "cd $PWD"` <br>
`which pip` <br>
`sudo apt update` <br>
`sudo apt list | grep python` <br>
`sudo apt list --installed` <br>
`clear` <br>
`exit` <br>
`xclip` <br>
`echo $XDG_CURRENT_DESKTOP` <br>
`sudo dpkg -i $DEBIAN_PKG`<br>
`sudo find -name HEAD -execdir test -e refs -a -e objects -a -e config \; -printf %h\\n` <br>
##### Creat an alias with a command to go to a specific directory
`alias ee='cd /home/ws/01-inbox/02-projects/2019-ee/test-env/eenz' <br>
`ee`

#### get text between quotes in a text file. Options
`echo Source_File.txt | grep $REGEX_PATTERN`  <br>
`grep "'.*'" -o references-get-between-quoutes.txt > result_1855.txt` <br>
`PATTERN='".*"'` <br>
`grep -o $PATTERN raw_file.txt > result_file_$(date)_.txt` <br>
## PDF Operations
### PDF tool kit
##### Recursively find inside pdfs
`find . -iname '*.pdf' -exec pdfgrep "An agent architecture for managing data " {} +`
`pdfgrep -r "Title of PDF to find"`
`info pdftk`
`pdftk 18.pdf dump_data_utf8 | grep InfoValue:`
`sudo apt autoremove`
`sudo apt upgrade`
`ls -lth /var/log/ | sort --month-sort`
`less /var/log/syslog`
`touch new_empty_file.txt`
`less /etc/X11/xorg.conf`

# Introduction
2020-04-28 I just lost years of work on setting a nice Information Technology Wiki. Now i will start a new one in github.
It will have categories and then subcategories with functionalites.

# Linux
##### Get info about current user
`id`
##### Check Timestamp for last updated packages in package manager apt
`ls -l /var/lib/apt/periodic/update-stamp`<br>
##### History of commands executed in the current session
`history` <br>
##### Create a random password
`randompass=$(dd status=none bs=24 count=1 if=/dev/urandom | base64 | tr /= _)`<br>
##### Get stats info about the system
`stat --help`
##### interactive process viewer
`htop`
##### Remove directory
`rm -rf $DIR_PATH`
##### See who is connected and Display the load average (uptime output)
`w -u`
##### Get the user login history
`last $USERNAME`
##### print the user name who are all currently logged in the current host
`users`
##### print the loggedin user name
`id -un`
##### get the list of the usernames who are currently logged in.
`who`
##### get a list of all usernames that are currently logged
`who | cut -d' ' -f1 | sort | uniq`
##### Launch file explorer Nautilus as super user admin
`sudo nautilus`
##### Scan full disk and analyze it
`sudo ncdu /`
#### Search for execution of a command in the history
`COMMAND=who ; history | grep $COMMAND`
#### set max map count
`sudo sysctl -w vm.max_map_count=262144`

##### Show contents in tree view
tree ~

# Terminals
## Bash
#### start a process in the background
`COMMAND="rescuetime"`
`$COMMAND &`
#### Create a testing version with the date. No space in generated date
`APP_VERSION="vtest-"$(date +%F_%H%M)`<br>
#### Create a file with content in a given path
`FILE_PATH=/home/ubuntu/.bash_functions`

#### Create a dir and run a command in 1 line
`cd $DIR1; $(COMMAND)`

#### Create a file and add content to it
```
sudo bash -c "cat > $FILE_PATH"<<EOF
Lots of content
foo
bar
EOF
```

#### Create a function to show files in current dir
FILE_PATH=/home/ubuntu/.bash_functions
sudo bash -c "cat > $FILE_PATH"<<EOF
function cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
        ls -F --color=auto
}
EOF

#### Clear Bash terminal
clear

#### exit from terminal
exit
##### Change permissions of a file based on permissions of other file
RFILE=reference_file ; sudo chmod --reference=$RFILE
##### Change ownership of all files inside current dir to a given group
GROUP_NAME=common ; sudo chown :$GROUP_NAME *

### Networking
#### Test connectivity to a port
`nc -vvv $host $port` <br>

### Get listening ports
`ss -tulwn`

## PowerShell 
Executed in Powershell 7 in windows 10 that runs as a VM inside Linux ubuntu 18.

### Networking

##### Get your Public IP Address
(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content

#### VPN
(OpenVPN set up in ubuntu|https://tecadmin.net/install-openvpn-client-on-ubuntu/)

#### Open SSH
(https://www.openssh.com/)
(https://www.ssh.com/ssh/ssh-academy)|SSH Academy
#### Great docs at (https://www.digitalocean.com/community/tutorials/how-to-configure-custom-connection-options-for-your-ssh-client#general-tweaks-and-connection-items)
* Use a config ssh custom file to ease connectivity
* Make sure you are clear PuTTY will create keys with a `priv.ppk` format in windows vs Linux Open SSH key `id_rsa`

# Git
`git clone git@github.com:elastic/stack-docker.git`
`git status`
`git branch`
`git info`

# Programming Languages

# DataBases
## MySQL
#### Connect to DB with mysql command utilities
`HOST=localhost; USER=mysql`

`mysql -h $HOST -u $USER -p`

## PostgreSQL

## Microsoft SQL Server 2016

# OSes
## Linux Ubuntu
### System settings
#### Get dimendions of Display
`xdpyinfo | grep dim`

### Nautilus operations
#### Show hidden files Keyboard shortcut
CTRL + H
#### Show Path Location Keyboard shortcut
CTRL + L
#### Switch between the Icons and List formats
CTRL + 1 | CTRL + 2
#### Search for files
CTRL + F
#### Delete File(s)
CTRL + delete
#### permanently delete
Shift + Delete
(You should never delete your Home directory, as doing so will most likely erase all your GNOME configuration files and possibly prevent you from logging in. Many personal system and program configurations are stored under your home directory.)


## Windows 10 (unfortunately)

## Mac


# Docker
`docker version` <br>
`docker volume ls` <br>
`docker system df`<br>
#### Search for an app or project containing given strings
`docker seach nagios`
#### Stop All Containers
`docker stop $(docker ps --quiet)`
#### Clean up Everything including volumes
`docker system prune --all --force --volumes`
#### List labels for a given docker container
```
CONTAINER=ID or container name
docker inspect --format \
    '{{ range $k, $v := .Config.Labels -}}
    {{ $k }}={{ $v }}
    {{ end -}}' $CONTAINER
```
#### Get IP of a given container
`docker inspect -f ‘{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}’ $CONTAINER_NAME_OR_ID` <br>
List commands used to create a given image
```
MY_IMG=
docker history $MY_IMG | awk 'NR>1 {print $1}' | xargs docker inspect --format '{{ ((index .ContainerConfig.Cmd ) 0) }}'
```
# Docker-Compose
`docker-compose version` <br>
`docker-compose config` <br>
`docker-compose --verbose up -d` <br>
`docker-compose build` <br>
`docker-compose images` <br>
`docker-compose -f setup.yml up --remove-orphans` <br>
`docker-compose --verbose top` <br>
`docker-compose --verbose ps` <br>
`docker-compose --verbose stats` <br>

# Kubernetes
## Kubectl commands frequently used
`kubectl get pods` <br>
`kubectl get deployments.apps --show-*` <br>
`kubectl get deployments.apps --show-labels` <br>
`kubectl create -f wishlist-deployment.yaml` <br>
`kubectl get rs` <br>
`kubectl get deployments` <br>
`helm install --name "wishlist-chart" -f values.yaml .` <br>

## Minikube
`minikube version` <br>
`minikube status` <br>
`minikube update-check` <br>
`minikube update` <br>
`minikube upgrade` <br>
`kubectl version` <br>
`minikube start` <br>
`minikube status` <br>
`minikube stop` <br>
