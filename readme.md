# Wiki Information Technology
it happened in 2020-04-28. For years i have been collecting snippets on linux, solaris, C, Java, Docker, Kubernetes, etc.
Then a google docs file was inside of a google drive folder. I accidentally deleted the folder and later on i emptied the bin. I truly dislike that. 
I got in touch with google support to no avail. 
I still hope i can recover my file.

Dont rely on the cloud 100%. Have local copies of your digital material.

# To be Categorized
htop
nc -vvv $host $port
df -h
uname -a
ls -l /var/lib/apt/periodic/update-stamp
cat ~/.ssh/id_rsa.pub
sudo apt --fix-broken install
sudo apt-get purge unattended-upgrades
cat /etc/apt/apt.conf.d/10periodic
sudo visudo
randompass=$(dd status=none bs=24 count=1 if=/dev/urandom | base64 | tr /= _)
APP_VERSION="vtest-"$(date +%F_%H%M)
scp -r $RANQX_LO_LOCAL_PATH/sftp-shim ubuntu@$SFTPSHIM_SERVER_DNS:$SFTP_DEPLOYMENT_PATH
curl localhost:80
stat %A $DIR
sudo mv $DIR1 $DIRDestiny
echo "cd $PWD"
history 5
which pip
sudo apt update
sudo apt list | grep python
sudo apt list --installed
kubectl get pods
kubectl get deployments.apps --show-*
kubectl get deployments.apps --show-labels 
clear
kubectl create -f wishlist-deployment.yaml
exit
kubectl get rs
kubectl get deployments
helm install --name "wishlist-chart" -f values.yaml .
xclip
echo $XDG_CURRENT_DESKTOP
sudo dpkg -i $DEBIAN_PKG
sudo find -name HEAD -execdir test -e refs -a -e objects -a -e config \; -printf %h\\n
alias ee='cd /home/ws/01-inbox/02-projects/2019-ee/test-env/eenz'
ee
rm -rf DIR_PATH

get text between quotes in a text file. Options
echo references-get-between-quoutes.txt | grep '".*"'
echo references-get-between-quoutes.txt | grep '".*"' $
echo references-get-between-quoutes.txt | grep '".*"' $?
echo references-get-between-quoutes.txt | grep '".*"' ?
echo references-get-between-quoutes.txt | grep '".*"' {}
echo references-get-between-quoutes.txt | grep '".*"' {} +
echo references-get-between-quoutes.txt | grep '".*"' .
echo references-get-between-quoutes.txt | grep '".*"'
grep "'.*'" -o references-get-between-quoutes.txt > result_1855.txt
PATTERN='".*"'
grep -o $PATTERN raw_file.txt > result_file_$(date)_.txt

Recursively find inside pdfs
find . -iname '*.pdf' -exec pdfgrep "An agent architecture for managing data " {} +

pdfgrep -r "Title of PDF to find"
PDF tool kit
info pdftk
pdftk 18.pdf dump_data_utf8 | grep InfoValue:

sudo apt autoremove
sudo apt upgrade
ls -lth /var/log/ | sort --month-sort
less /var/log/syslog
touch new_empty_file.txt
less /etc/X11/xorg.conf

# Introduction
2020-04-28 I just lost years of work on setting a nice Information Technology Wiki. Now i will start a new one in github.
It will have categories and then subcategories with functionalites.

# Linux
##### Get info about current user
`id`
##### Get stats info about the system
`stat --help`
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
COMMAND="rescuetime"
$COMMAND &

#### Create a file with content in a given path
FILE_PATH=/home/ubuntu/.bash_functions

#### Create a dir and run a command in 1 line
cd $DIR1; $(COMMAND)

sudo bash -c "cat > $FILE_PATH"<<EOF
Lots of content
foo
bar
EOF

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
git clone git@github.com:elastic/stack-docker.git
git status
git branch
git info

# Programming Languages



# DataBases
## MySQL

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
docker version
docker volume ls
docker system df
docker seach nagios

# Docker-Compose
docker-compose version
docker-compose config
docker-compose --verbose up -d
docker-compose build 
docker-compose images
docker-compose -f setup.yml up --remove-orphans
docker-compose --verbose top
docker-compose --verbose ps
docker-compose --verbose stats

# Kubernetes

## Minikube
minikube version
minikube status
minikube update-check
minikube update
minikube upgrade
kubectl version
minikube start
minikube status
minikube stop
