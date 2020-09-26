<h1> Wiki Information Technology </h1>

## Introduction
2020-04-28 I just lost years of work on setting a nice Information Technology Wiki. Now i will start a new one in github.
It will have categories and then subcategories with functionalites.

It happened in 2020-04-28. For years i have been collecting snippets on linux, solaris, C, Java, Docker, Kubernetes, etc.
Then a google docs file was inside of a google drive folder. I accidentally deleted the folder and later on i emptied the bin. I truly dislike that.
I got in touch with google support to no avail.
I still hope i can recover my file.

Don't rely on the cloud 100%. Have local copies of your digital material.

The wiki is going to be divided into subcategories. This main Wiki will redirect to the others but will contain main commands for the OS Linux, Windows (Powershell) and Mac (terminal bash

# Linux Bash Commands

# To be Categorized Inbox
netsh int ipv6 reset reset.log
Disable any active virtual private network (VPN) connection.
 restore the firewall defaults
Disable the IP Helper service (Windows). This features attempts to manage some aspects of IPv6 connectivity. To disable it:

Press Windows key+R, then type services.msc in the displayed Run box, and select OK.
This opens a list of Windows system services. Scroll through the list and locate the service named IP Helper, then right-click the service name and choose Properties.
In the Startup type drop-down list, choose Disabled, then select OK.
Restart your system, then check to see if the IPv6 connection now works as expected.
## Systemd Systemctl
Check status

sudo systemctl status application
# Example
sudo systemctl status nginx
Check if active

If you’re using a monitoring service like Zabbix and need to check if a service is active, you can use:

# systemctl is-active nginx

### List all loaded units

`systemctl list-units -all | grep loaded | awk '{print $1;}'`

### List all enabled units

`systemctl list-unit-files| grep enabled | awk '{print $1;}' > enabled.txt`

Most of the time, we need to make sure that all the services we use are in the startup script.
### List all loaded services

`systemctl list-units -all | grep service | grep loaded | awk '{print $1;}'`

### List all enabled services

`systemctl list-unit-files | grep service | grep enabled | awk '{print $1;}' > enabled.txt`

### To find the list of services that are loaded but not enabled, we can do the following:
```
systemctl list-units -all | grep service | grep loaded | awk '{print $1;}' > loaded.txt
systemctl list-unit-files | grep service | grep enabled | awk '{print $1;}' > enabled.txt
diff -y loaded.txt enabled.txt
#If you want a quick glance of missing ones you can also use
diff -y loaded.txt enabled.txt | grep '<'
```

# Generate SSH Key pair
# Add a SSH key to ssh-agent 
```
ssh-add -k ~/.ssh/id_rsa
ssh-keygen -t rsa
grep -Eri health_url .
cat ~/multi/ui-pages/env-index.json | jq
popd
pushd
cat ~/multi/ui-pages/env-index.json | jq -R | grep 2
cat ~/multi/ui-pages/env-index.json | jq -C '.' | less -R
ps xfa | less
find . -maxdepth 1 -type d -mtime +15  -printf '%f\n'
HTTPDUSER=$(ps axo user,comm | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1)
git diff --histogram
```

# AWS EC2 API interactions
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/security-groups
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/public-hostname
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/profile
exec env TERM='dumb' INSIDE_EMACS='26.1,tramp:2.3.3.26.1' ENV='' HISTFILE=~/.tramp_history PROMPT_COMMAND='' PS1=\#\$\  PS2='' PS3='' /bin/sh
aws cloudformation describe-stack-events --stack-name ranqx-loan-testing-sandbox-cloudwatch | jq lenght
cat ~/.ssh/id_rsa.pub | xclip -sel clip
# Basic Git config set up
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
## Analyse Logs. 3 to 31.gz month. Month like Feb 2020 and print
zcat access.log.{3..31}.gz | grep -E 'Feb/2020' | awk '{print $1}' | sort -u | less

#### Xclip to capture the clipboard when copying.
`xclip` <br>
#### nohup runs the given COMMAND with hangup signals ignored, so that the command can continue running in the background after you log out.
`nohup $COMMAND_OR_SCRIPT > out_$(date).txt`
#### Equivelance of commands in bash
```
echo -e 'FROM busybox\nRUN echo "hello world"' | docker build -

docker build -<<EOF
FROM busybox
RUN echo "hello world"
EOF
```

## Image operations with [Image Magick](https://imagemagick.org/index.php)
### easily-resize-images
``` bash
# percentage
convert  -resize 50% source.png dest.jpg

# Specific size
SIZE="1024X768"
convert -resize $SIZE source.png destination.jpg
``` 

##### maintain symbolic links determining default commands. Show installed Apps
update-alternatives --get-selections
##### Info about system
`uname -a` <br>
##### Get info about current user
`id`
##### Edit sudo users
`sudo visudo`<br>
##### Move DIR1 to DIRDestiny Path
`sudo mv $DIR1 $DIRDestiny`<br>
##### Find where the command is installed
`which pip` <br>
##### Creat an alias with a command to go to a specific directory
```
alias ee='cd /home/ws/01-inbox/02-projects/2019-ee/test-env/eenz' <br>
ee
```
#### Copy files from Local to Remote Server
`scp -r $LOCAL_PATH/sftp-shim ubuntu@$REMOTE_HOST_SERVER:$REMOTE_SERVER_PATH`<br>
`echo $XDG_CURRENT_DESKTOP` <br>
`stat %A $DIR`<br>
`echo "cd $PWD"` <br>
## Find Search operations
#### Find files containing specific text
`grep -iRl "TEXT-TO-FIND" ./`
#### Switches:
```
-i - ignore text case
-R - recursively search files in subdirectories.
-l - show file names instead of file contents portions.
```
`./` As the last parameter, the path to the folder containing files you want to search for text. 
You can use the full path of the folder.
`grep -iRl "TEXT" /home/user/Documents`
#### Find local git repos
`sudo find -name HEAD -execdir test -e refs -a -e objects -a -e config \; -printf %h\\n` <br>

## Package Management
### APT
#### Fetch packages from Repo
`sudo apt update`
#### Auto remove Obsolete packages
`sudo apt autoremove`
#### Upgrade packages
`sudo apt upgrade`
#### List a package by name. e.g. python
`sudo apt list | grep python` <br>
#### List a installed packages
`sudo apt list --installed` <br>
#### Fix broken install packages
`sudo apt --fix-broken install`<br>
#### Purge a package
`sudo apt-get purge unattended-upgrades`<br>
#### Install a Debian Package
`sudo dpkg -i $DEBIAN_PKG`<br>
#### Check if Periodic updates are enabled
`cat /etc/apt/apt.conf.d/10periodic`<br>
#### Get packages from repo and find given string
`dpkg --get-selections | grep PACKAGE_TO_FIND`
#### Snap list installed packages
`snap list`
## Debugging Linux Systems
A very important set of skills when something goes wrong and is important to get quick info.
This can become a small DIY project to manage desktop and cloud servers.
### Check System Logs Journal Control
##### command for viewing logs collected by systemd.
#### Obtain Log output with admin permissions
`sudo journalctl`
#### Obtain Log output from oldest to newest.
`journalctl -r`
#### Monitor New Log Messages
`journalctl -f`
#### Show Logs within a Time Range
```
journalctl --since "2018-08-30 14:10:10"
journalctl --until "2018-09-02 12:05:50"
```
#### Show Logs for a Specific Boot
`journalctl -b`
`journalctl --list-boots`
#### Show Logs for a systemd Service
`journalctl -u $SERVICE_NAME`
#### View Kernel Messages
`journalctl -k`
# change Output Format to json-pretty
`journalctl -o json-pretty`
### Manually Clean Up Archived Logs
#### Reduce the size of your journals to 2GiB:
`journalctl --vacuum-size=2G`
#### Remove archived journal files with dates older than the specified relative time.
`journalctl --vacuum-time=1years`
#### Create a Symbolic Link
```
SOURCE_FILE=/home/ubuntu/.local/bin/docker-compose
SYMBOLIC_LINK_PATH=/usr/bin/docker-compose
sudo ln --symbolic $SOURCE_FILE $SYMBOLIC_LINK_PATH
```
##### Check Timestamp for last updated packages in package manager apt
`ls -l /var/lib/apt/periodic/update-stamp`<br>
##### History of commands executed in the current session
`history` <br>
##### Create a random password
`randompass=$(dd status=none bs=24 count=1 if=/dev/urandom | base64 | tr /= _)`<br>
##### Get stats info about the system
`stat --help`
#### get text between quotes in a text file. Options
`echo Source_File.txt | grep $REGEX_PATTERN`  <br>
`grep "'.*'" -o references-get-between-quoutes.txt > result_1855.txt` <br>
`PATTERN='".*"'` <br>
`grep -o $PATTERN raw_file.txt > result_file_$(date)_.txt` <br>
##### interactive process viewer
`htop`
#### Check Disk Usage
`df -h`<br>
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
### Some tips
- `Up arrow` to recall previous commands
- `Tab` completion
- `Ctrl + U` to cancel current input
- `Ctrl + R` to reverse search through history
- `Ctrl + A` to go to the beginning of a line
- `#*` and `##*` for prefix manipulation
- `%` and `%%` for suffix manipulation
- `^^` for pattern substitution of previous command
- Ctrl + L to clear screen (instead of typing "clear").
- sudo !! to run previous command with sudo privileges.
- grep -Ev '^#|^$' <file> will display file content without comments or empty lines."

source: [opensource.com](https://opensource.com/article/20/1/linux-terminal-trick)

### most used commands in History
history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10

### script to list files, directories, executables, and links from a given Workspace directory
#### with `find`
`find . -maxdepth 1 -type f -print`

#### Script usage=  `lsf` lists files, `lsd` lists directories, `lsx` lists executables,  `lsl` lists links.
[Bash Section](/devops-tools/bash)

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
Lots of content and text
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

#### Clear Bash terminal Screen
`clear` <br>
#### exit from terminal
exit
##### Change permissions of a file based on permissions of other file
RFILE=reference_file ; sudo chmod --reference=$RFILE
##### Change ownership of all files inside current dir to a given group
GROUP_NAME=common ; sudo chown :$GROUP_NAME *

## PDF Operations
### PDF tool kit
##### Recursively find inside pdfs
`find . -iname '*.pdf' -exec pdfgrep "Title of  File to search " {} +` <br>
`pdfgrep -r "Title of PDF to find"` <br>
#### Get info about the pdf toolkit
`info pdftk` <br>
#### Get info about PDF_FILE
`pdftk $PDF_FILE.pdf dump_data_utf8 | grep InfoValue:`<br>
`ls -lth /var/log/ | sort --month-sort` <br>
`less /var/log/syslog` <br>
`touch new_empty_file.txt` <br>
`less /etc/X11/xorg.conf` <br>

#### extract a range of pages from a pdf file
`pdftk source.pdf cat 5-10 output ExtractedOutput_p5-10.pdf`
#### split specific pages from the source file, for example page 5, page 6, and page 10
`pdftk source.pdf cat 5 6 10 output SplittedOutput.pdf`

### Networking
##### Check this awesome Cheat sheet
[CheatSheet](https://www.linuxtrainingacademy.com/linux-ip-command-networking-cheat-sheet/)
#### Test connectivity to a port
`nc -vvv $host $port` <br>
#### Check Any URL and get output in Text
`curl -l localhost:80` <br>

### Get listening ports
`ss -tulwn`

## PowerShell 
Executed in Powershell 7 in windows 10 that runs as a VM inside Linux ubuntu 18.

### Networking

##### Get your Public IP Address
(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content

#### VPN
(OpenVPN set up in ubuntu|https://tecadmin.net/install-openvpn-client-on-ubuntu/)

### Open SSH
(https://www.openssh.com/)
(https://www.ssh.com/ssh/ssh-academy)|SSH Academy
#### Great docs at (https://www.digitalocean.com/community/tutorials/how-to-configure-custom-connection-options-for-your-ssh-client#general-tweaks-and-connection-items)
* Use a config ssh custom file to ease connectivity
* Make sure you are clear PuTTY will create keys with a `priv.ppk` format in windows vs Linux Open SSH key `id_rsa`
#### Get content of default name of Public Key
`cat ~/.ssh/id_rsa.pub`<br>
#### Read Public SSH key, ssh to $REMOTE_HOST with root user and run a command to create a directory ssh and add the public key to authorized_keys file

```
COMMAND="mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
cat ~/.ssh/id_rsa.pub | \
ssh root@$REMOTE_HOST $COMMAND
```

# Git
### Clone a Git Repo
`git clone git@github.com:elastic/stack-docker.git`
`git status`
`git branch`
`git info`

# Programming Languages
## Java
todo add short details description
todo add main links
### OpenJDK
##### update-alternative set version for Java
update-alternatives --config java

### Oracle Java

## Python

# DataBases
## MariaDB (MySQL open source Fork)
## Oracle MySQL 
#### Connect to DB with mysql command utilities
```HOST=localhost; USER=mysql
mysql -h $HOST -u $USER -p
```
#### To check the default character set for a particular database DB_NAME
```
SELECT SCHEMA_NAME, DEFAULT_CHARACTER_SET_NAME
       FROM INFORMATION_SCHEMA.SCHEMATA
       WHERE SCHEMA_NAME='DB_NAME';
```
## AWS RDS MySQL engine

## PostgreSQL

## Microsoft SQL Server

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

## Windows - Server and win10 (unfortunately) with Powershell
### Clean-up network devices
`netcfg -d`
# Extracted from some old notes
attrib = configurations for files and folders
netstat -nao = network statistics
	netsat -ano | find str "PID"
sc = services command
	sc delete "serviceName"
sfc /scannow || System File Checker
nslookup "host" || verify that DNS name resolution is working correctly
pathping  "ip" || determine whether the router is performing slowly or dropping packets.
fciv.exe [Commands] <Options> || File Checksum Integrity Verifier install as plugin first.

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
#### Show containers that have an exposed port then sort
`docker ps --filter expose=0-65535/tcp | sort -u -k7`
#### List labels for a given docker container source: https://gist.github.com/steve-jansen
```
CONTAINER=ID or container name
docker inspect --format \
    '{{ range $k, $v := .Config.Labels -}}
    {{ $k }}={{ $v }}
    {{ end -}}' $CONTAINER
```
#### Get IP of a given container
`docker inspect -f ‘{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}’ $CONTAINER_NAME_OR_ID` <br>
#### List commands used to create a given image
```
MY_IMG=
docker history $MY_IMG | awk 'NR>1 {print $1}' | xargs docker inspect --format '{{ ((index .ContainerConfig.Cmd ) 0) }}'
```

### yq for yaml processing
```
echo 'yq() {
  docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
}' | tee -a ~/.bashrc && source ~/.bashrc
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

# Mac Terminal