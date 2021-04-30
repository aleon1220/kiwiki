<h1> Wiki Information Technology </h1>

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=3 orderedList=false} -->

<!-- code_chunk_output -->

- [To be Categorized Inbox](#to-be-categorized-inbox)
  - [Introduction and complains](#introduction-and-complains)
- [About KIWIKI Project](#about-kiwiki-project)
  - [Repository Categories](#repository-categories)
  - [Storage](#storage)
  - [Check status of important services](#check-status-of-important-services)
  - [General Linux Bash Commands](#general-linux-bash-commands)
    - [Get OS info](#get-os-info)
  - [Systemd Systemctl](#systemd-systemctl)
  - [Find/Search operations](#findsearch-operations)
  - [Package Management](#package-management)
    - [APT](#apt)
  - [Debugging Linux Systems (mostly Ubuntu)](#debugging-linux-systems-mostly-ubuntu)
    - [Logs](#logs)
    - [Networking](#networking)
    - [Network Probing](#network-probing)
    - [Traffic capture](#traffic-capture)
    - [Network management](#network-management)
    - [Load testing](#load-testing)
    - [Benchmarking](#benchmarking)
    - [The `ip` command](#the-ip-command)
- [Terminals](#terminals)
    - [more in the Bash Section](#more-in-the-bash-sectiondevops-toolsbash)
  - [CURL Client URL](#curl-client-url)
  - [PDF Operations Tools](#pdf-operations-tools)
    - [PDF tool kit](#pdf-tool-kit)
- [Windows products (micro\$oft)](#windows-products-microoft)
  - [Windows - & WinServer](#windows-winserver)
    - [Networking](#networking-1)
    - [Disable the IP Helper service](#disable-the-ip-helper-service)
    - [Windows Nice Terminal](#windows-nice-terminalhttpsdocsmicrosoftcomen-uswindowsterminalget-startedinstallation)
    - [Open SSH](#open-ssh)
  - [SSH Key Management](#ssh-key-management)
    - [Key generation](#key-generation)
- [Git](#git)
  - [Git Administration/Operation](#git-administrationoperation)
    - [Git operations](#git-operations)
    - [Git Analysis](#git-analysis)
  - [Git implementations: Bitbucket](#git-implementations-bitbucket)
- [Programming Languages](#programming-languages)
  - [Java](#java)
    - [OpenJDK](#openjdk)
    - [Oracle Java](#oracle-java)
  - [Python](#python)
- [DataBases](#databases)
  - [MariaDB (MySQL open source Fork)](#mariadb-mysql-open-source-fork)
  - [Oracle MySQL](#oracle-mysql)
  - [AWS RDS MySQL engine](#aws-rds-mysql-engine)
  - [PostgreSQL](#postgresql)
  - [Microsoft SQL Server](#microsoft-sql-server)
- [Operating Systems](#operating-systems)
  - [Linux Ubuntu](#linux-ubuntu)
    - [System settings](#system-settings)
    - [Nautilus operations](#nautilus-operations)
- [Docker](#docker)
    - [YQ for yaml processing](#yq-for-yaml-processing)
  - [Docker-Compose](#docker-compose)
- [Kubernetes](#kubernetes)
  - [Kubectl commands frequently used](#kubectl-commands-frequently-used)
  - [Minikube](#minikube)
  - [Image Magick](#image-magickhttpsimagemagickorgindexphp)
    - [Image operations with ImageMagick](#image-operations-with-imagemagick)

<!-- /code_chunk_output -->

---
> END of Table of contents
---

## To be Categorized Inbox

#### Rename ZIP_HASH to FILE_HASH & ZIP_SIZE to FILE_SIZE
jq '[ . | .["ZIP_HASH"] = .FILE_HASH | .["ZIP_SIZE"] = .FILE_SIZE | del(.ZIP_HASH, .ZIP_SIZE)]' "${OTA_ARTIFACTS_OUT_DIR}/temp0.json" > "${TA_ARTIFACTS_OUT_DIR}/temp1.json"
##### remove OTA_URL_PREFIX and REL_NOTE
jq "del(.OTA_URL_PREFIX, .REL_NOTE)" "${OTA_ARTIFACTS_OUT_DIR}/temp1.json" > "${OTA_ARTIFACTS_OUT_DIR}/${BUILD_ID}-metadata.json"
set -xeu -o pipefail # print exec and fail exec
zip -r "${OTA_ARTIFACTS_OUT_DIR}/${BUILD_ID}.upd" "${OTA_ARTIFACTS_OUT_DIR}/${BUILD_ID}-metadata.json" "${OTA_ARTIFACTS_OUT_DIR}/${BUILD_ID}.zip"

ls -xl ${AOSP_OUT_DIR} #extension
Os hillman website. Iframe to include in website
```html
<iframe src="http://www.marketplaceleaders.org/a/" style="overflow:hidden" marginheight="0" marginwidth="0" frameborder="0" width="100%" height="100%"></iframe>
Read more: http://www.marketplaceleaders.org/tgif/api/#ixzz6pzkOZ8Wi
```
---
# About KIWIKI Project

This project is a collection of CLI commands.

The wiki is going to be divided into subcategories. This main Wiki will redirect to the others but will contain main commands for the OS Linux, Windows (Powershell) and Mac terminal commands.

## Repository Categories

1. [AWS](./aws/readme.md)
1. [Azure](./azure/readme.md)
1. devops-tools
1. productivity-tools
   - rescueTime
   - VsCode
1. Regular [expressions](./regex/readme.md)
1. security

## Introduction and complains

- **2020-04-28=** I just lost years of work on setting a nice Information Technology Wiki. Now i will start a new one in this github repo; It will have categories and then subcategories with functionalites.
For years i have been collecting snippets on linux, solaris, C, Java, Docker, Kubernetes, etc.
Then a google docs file was inside of a google drive folder. I accidentally deleted the folder and later on I emptied the bin. I truly dislike that.
I got in touch with google support to no avail. :-(
I still hope I can recover my file.

Don't rely on the cloud 100%. Have local copies of your digital material.

- **2020-11-10=** I totally confirm that i lost my google docs wiki file. I should have been more careful.
- **2021-04-07=** processing inbox category. Moved intro below About Project

you will interact with the computer through the Command Line Interface CLI shell.
## CLI Shell keyboard shortcuts
- `ctrl + a`  moves cursor to beginning of line (a alphabet or first letter)
- `ctrl + e`  moves cursor to end of line (Is also kinda close to letter `a` in the US keyboard)
- `ctrl + w`  cuts the word to the left of the cursor.
- `alt  + d`  cuts the word to the right of the cursor.
- `ctrl + k`  cuts everything to the right of the cursor.
- `ctrl + u`  cuts everything to the left of the cursor.
- `ctrl + y`  pastes back what you have just cut.
- `ctrl + e + x`  explanation below

``` bash
Type a Long command, e.g. add loops or some complex parsing logic. You need more editing power so you press


                      ctrl + e + x


Editors VIM(or Nano or VI etc.) opens with your command you had typed so far already in the buffer
```

## The Computer as a modern day to day tool

A Computer as a tool has a CPU processor, memory RAM, storage in form of a drive, connectivity via network card or wifi, graphics visualization via a monitor. The operating system has tools to manage and interact with all the described above.

The categories are:

1. Processing
2. Memory
3. Storage
4. Netowrking
5. Graphics
## Storage
Hard drives, volumes, SSDs, mounts, filesystem, etc

####  view your available disk devices and their mount points (if applicable) to help you determine the correct device name to use
`lsblk`

#### get information about all of the devices attached to the instance
`sudo lsblk -f`

#### Get manufacturer details for the device
`lsblk -io NAME,TYPE,SIZE,MOUNtPOINT,FSTYPE,MODEL`

#### DMI table decoder
`dmidecode | grep UUID`

#### get/set SATA/IDE device parameters
`DEVICE="/dev/nvme1n1" hdparm -tT --direct DEVICE`
#### get information about a specific device, such as its file system type.  If the output shows simply data, there is no filesystem in the device.
``` bash
DEVICE_CHECK="/dev/xvdf"*
sudo file -s DEVICE_CHECK
```
##### make sure you have mounted loop device kernel module
`lsmod | grep loop`

##### info about mount the loop device kernel module
`modprobe loop`

#### Show Id of devices
```bash
sudo blkid

# ubuntu
sudo lsblk -o +UUID

```

##### mount an ISO file as loop device
`mount -o loop -t iso9660 <path/to/iso/file> /media/cdrom`

#### Mount all filesystems
`sudo mount -a`

## Check status of important services
``` bash
timedatectl status
sudo systemctl edit --full cron.service
sudo systemctl status nginx supervisor php7.2-fpm
sudo service jenkins status
```

The file that keeps track of mounted devices is `/etc/fstab`
## General Linux Bash Commands

### Get OS info
#### get info about linux version
`cat /etc/os-release`

#### get pretty print version
`less /etc/issue`

#### Debian/ubuntu get version
```bash
lsb_release -a
hostnamectl
```

##### Info about system
`uname -a` <br>

## Systemd Systemctl

#### Check status
`sudo systemctl status APP_SERVICE`
#### Example system control status nginx
`sudo systemctl status nginx`

#### Check if service is active
`systemctl is-active nginx`

#### List all loaded service units

`systemctl list-units -all | grep loaded | awk '{print $1;}'`

#### List all enabled units

`systemctl list-unit-files| grep enabled | awk '{print $1;}' > enabled.txt`

Most of the time, we need to make sure that all the services we use are in the startup script.

#### List all loaded services

`systemctl list-units -all | grep service | grep loaded | awk '{print $1;}'`

#### List all enabled services

`systemctl list-unit-files | grep service | grep enabled | awk '{print $1;}' > enabled.txt`

#### Find the list of services that are loaded but not enabled

``` bash
systemctl list-units -all | grep service | grep loaded | awk '{print $1;}' > loaded.txt
systemctl list-unit-files | grep service | grep enabled | awk '{print $1;}' > enabled.txt
diff -y loaded.txt enabled.txt
#If you want a quick glance of missing ones you can also use
diff -y loaded.txt enabled.txt | grep '<'
```

#### `pushd` and `popd` to jump between directories

``` bash
pushd $DIR
popd
```

#### Analyse Logs. Logs named 3 to 31.gz month. Month like Feb 2020 and print

```
zcat access.log.{3..31}.gz | grep -E 'Feb/2020' | awk '{print $1}' | sort -u | less
```

#### Xclip to capture the clipboard when copying.
`cat ~/.ssh/id_rsa.pub | xclip -sel clip`<br>
`xclip`

#### X window var
`echo $XDG_CURRENT_DESKTOP` <br>

#### check a dir with a parameter. Double check `info stat`
`stat %A $DIR`<br>

#### nohup execution
`nohup` runs the given COMMAND with hangup signals ignored, so that the command can continue running in the background after you log out.

`nohup $COMMAND_OR_SCRIPT > out_$(date).txt`

#### echo a string an pipe it to a command
In this case the content of a `DockerFile` is echoed first then piped to `docker build` to create a docker image.

``` bash
echo -e 'FROM busybox\nRUN echo "hello world"' | docker build -
docker build -<<EOF
FROM busybox
RUN echo "hello world"
EOF
```

##### maintain symbolic links determining default commands. Show installed Apps
`update-alternatives --get-selections`

##### Get info about current user

`id`

##### Edit sudo users

`sudo visudo`<br>

##### Move DIR1 to DIRDestiny Path

`sudo mv $DIR1 $DIRDestiny`<br>

##### Find where the command is installed

`which pip` <br>

##### Create an alias with a command to go to a specific directory

``` bash
alias ee='cd /home/ws/01-inbox/02-projects/2019-ee/test-env/eenz' <br>
ee
```

#### Copy files from Local to Remote Server
define the local and remote paths in env vars. Perform the copy
``` bash
scp -r $LOCAL_PATH/sftp-shim ubuntu@$REMOTE_HOST_SERVER:$REMOTE_SERVER_PATH
echo "cd $PWD"
```

## Find/Search operations

#### Find files containing specific text

`grep -iRl "TEXT-TO-FIND" ./`

##### Switches:

```bash
-i - ignore text case
-R - recursively search files in subdirectories.
-l - show file names instead of file contents portions.
```

`./` As the last parameter, the path to the folder containing files you want to search for text.
You can use the full path of the folder.
`grep -iRl "TEXT" /home/user/Documents`

#### searches for ????
grep -Eri health_url .
#### Find directories modified within the past 10 days
``` bash
find . -maxdepth 1 -type d -mtime -10  -printf '%f\n'
HTTPDUSER=$(ps axo user,comm | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1)
```

## Package Management

### APT
ubuntu package manager
#### Fetch packages from Repo
`sudo apt update`

#### Auto remove Obsolete packages

`sudo apt autoremove`

#### Upgrade packages

`sudo apt upgrade`

#### List a package by name. e.g. python

`sudo apt list | grep python` <br>

#### List installed packages

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

---

## Debugging Linux Systems (mostly Ubuntu)

A very important set of skills when something goes wrong and is important to get quick info.
This can become a small DIY project to manage desktop and cloud servers.

`ls -lth /var/log/ | sort --month-sort` <br>
`less /var/log/syslog` <br>
`touch new_empty_file.txt` <br>
`less /etc/X11/xorg.conf` <br>

Article [medium.com Troubleshooting](https://medium.com/better-programming/5-powerful-unix-commands-for-easier-troubleshooting-dd619d5e173a)

#### lists all open files belonging to all active processes.
`lsof`

#### lists open files for current user
`lsof -u $USER`

#### End all user processes
`kill -9 $(lsof -t -u $TARGET_USER)`
#### Retrieve processes running on a specified range
`lsof -i :8090-9090`

### Explore System Processes

#### Find the process that consumes more CPU
`ps -eo pid,%cpu,%mem,args --sort -%cpu`

#### Sort processes by memory
`ps aux --sort=-%mem`

#### a very unuseful view with a process tree
``` bash
ps xfa | less
```

#### read from a file in a specific line e.g. 4
`less +4 -N show-time.sh`
### Logs
#### commong logs in linux
`/var/log/message`
Contains global system messages, including the messages that are logged during system startup. Includes mail, cron, daemon, kern, auth, etc.

`/var/log/auth.log`
Authenication logs

`/var/log/kern.log`
Kernel logs

`/var/log/cron.log`
Crond logs

#### Check System Logs Journal Control

##### command for viewing logs collected by systemd.

#### Obtain Log output with admin permissions

`sudo journalctl`

#### Obtain Log output from oldest to newest.

`journalctl -r`

#### Monitor New Log Messages

`journalctl -f`

#### Show Logs within a Time Range

```bash
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

#### change Output Format to json-pretty

`journalctl -o json-pretty`

#### Manually Clean Up Archived Logs

#### Reduce the size of your journals to 2GiB:

`journalctl --vacuum-size=2G`

#### Remove archived journal files with dates older than the specified relative time.

`journalctl --vacuum-time=1years`

### Networking

commands and useful cheat sheet used in networking

##### Check this awesome Cheat sheet

[CheatSheet](https://www.linuxtrainingacademy.com/linux-ip-command-networking-cheat-sheet/)

Accessing a service
`whois` servers
`dig DOMAIN` DNS queries and shows associated records
`nslookup` alternative to dig. It doesnt use the system local DNS.
`traceroute DOMAIN` packets hop

### Network Probing

which tcp or UDP ports are open.
Can i open a TCP connection to this destination?

`nmap -sS localhost` port scanning TCP,UDP ports open or closed
`ping/ping6` sends ICMP pings. checks latency
`netcat` `nc -l 80` test ports
`telnet` a complete protocol

`tcdump -i eth0 icmp`

### Traffic capture
`tcpdump` traffic capture uses bpf filters
`tcpdump -i eth0 -vvv -d dst $IP`
wireshark
### Network management
`ifconfig` see info about interfaces. get your IP address

`route -n` routing info. Routing table

`arp` check arp cache
`arp -a`

`ip` see neighbor table. add routes

answers questions
what are the net interfaces, ips, subnets, broadcast address??
how do i add routes?
### Load testing
`tcpreplay` replays traffic from packet capture fire
```bash
tcpdump -i eth0 -w traffic.pcap
tcpreplay -i eth0 httptraffic.pcap
```

`wrk2` Send Http load

`wrk2 -t1 -c10 -d60 -R100 -L http://$IP` threads connections duration Requests

`iperf3`Send TCP or UDP traffic. Similar to wrk2 but allows UDP

`nuttcp`

### Benchmarking
`siege`

BPF/eBPF potentical for new programs

**source:** Digital ocean talk Handy Linux networking tools

#### Flush DNS by resetting the network DEBIAN based
`sudo /etc/init.d/networking restart`
#### inspect TCP socket states e.g. 443
`ss -nta '( dport = :443 )'`

`netstat` is a great tool for monitoring network connections.
#### netstat statistics
`netstat --statistics`
#### Find ports in use
``` bash
netstat -tulpn
# The -t option checks for TCP connections.
# The -u option checks for UDP connections.
# The -l option tells netstat to list only LISTENING connections. If you want to see all connections, use the -a option instead.
# The -p option shows the PID id of the process.
# The -n option shows numerical addresses, instead of trying to resolve host, port, or user names.
```
#### Find user behind a process
`sudo netstat -tulpe | grep 8090`

#### Test connectivity to a port

`nc -vvz $host $port` <br>

#### Check server status
`sudo netstat -tuple | grep smtp`

#### Check Any URL and get output in Text

`curl -l localhost:80` <br>

#### Get listening ports

`ss -tulwn`

#### Get a report with nmap. install it first `sudo snap install nmap`
`nmap -sV -p- localhost`

### The `ip` command
- Show / manipulate routing
`ip route show`
`ip route list`
- Show / manipulate devices
`cat /etc/network/interfaces`
- Policy routing
- Tunnels
#### Restart Name Service Cache Process
`sudo service nscd restart`

#### Create a Symbolic Link

``` bash
SOURCE_FILE=/home/ubuntu/.local/bin/docker-compose
SYMBOLIC_LINK_PATH=/usr/bin/docker-compose
sudo ln --symbolic $SOURCE_FILE $SYMBOLIC_LINK_PATH
```

##### Check Timestamp for last updated packages in package manager apt

`ls -l /var/lib/apt/periodic/update-stamp`<br>

##### History of commands executed in the current session

`history` <br>

##### Create a random password

```bash
randompass=$(dd status=none bs=24 count=1 if=/dev/urandom | \
base64 | tr /= _)
```

##### Get stats info about a file

`stat --help`
`stat $FILE`

#### get text between quotes in a text file. Options
``` bash
echo Source_File.txt | grep $REGEX_PATTERN
grep "'.*'" -o references-get-between-quoutes.txt > result_1855.txt

PATTERN='".*"'
grep -o $PATTERN raw_file.txt > result_file_$(date)_.txt
```

##### interactive process viewer

`htop`

#### Check Disk Usage

`df -h`<br>

##### See who is connected and Display the load average (uptime output)

`w -u`

##### Get the user login history

`last $USERNAME`

##### print the user name who are all currently logged in the current host

`users`

#### List Users in Linux

``` bash
less /etc/passwd
```

##### Info in `/etc/passwd`

Each line in the file has seven fields delimited by colons that contain the following information:

- User name:Encrypted password (x means that the
- password is stored in the /etc/shadow file).
- User ID number (UID).:User’s group ID number (GID)
- Full name of the user (GECOS)
- User home directory.
- Login shell (defaults to /bin/bash).

#### Display only the username

```bash
awk -F: '{ print $1}' /etc/passwd
cut -d: -f1 /etc/passwd
```

#### Get a List of all Users
Each user has a numeric user ID called UID. If not specified when creating a new user with the useradd command, the UID will be automatically selected from the /etc/login.defs file depending on the UID_MIN and UID_MIN values.

```bash
getent passwd
getent passwd | cut -d: -f1
```

#### Set a new password Root
```bash
sudo passwd $USERNAME
```

#### Set a new password Your own
`passwd`

#### To check the UID_MIN and UID_MIN values on your system, you can use the following command:

```bash
grep -E '^UID_MIN|^UID_MAX' /etc/login.defs
```

#### The command below will list all normal users in our Linux system:

```bash
getent passwd {1000..60000}
```

#### generic version of command above

```bash
eval getent passwd {$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)..$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)}
```

#### print only the usernames

```bash
eval getent passwd {$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)..$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)} | cut -d: -f1
```

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

##### Remove directory
`rm -rf $DIR_PATH`

#### Search for execution of a command in the history

`COMMAND=who ; history | grep $COMMAND`

#### set max map count
`sudo sysctl -w vm.max_map_count=262144`

##### Show contents in tree view
`tree ~`

#### If using GIO Gnome Input/Output
`gio tree`
# Terminals

### more in the [Bash Section](/devops-tools/bash)

#### most used commands in Bash History
```bash
history | \
awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count\*100 "% " a;}' | \
grep -v "./" | column -c3 -s " " -t | \
sort -nr | nl | head -n10
```

#### Script to list files, directories, executables, and links from a given Workspace directory

#### with `find`

`find . -maxdepth 1 -type f -print`

#### Script usage= `lsf` lists files, `lsd` lists directories, `lsx` lists executables, `lsl` lists links.

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

```bash
sudo bash -c "cat > $FILE_PATH"<<EOF
Lots of content and text
foo
bar
EOF
```

#### Create a function to show files in current dir

```bash
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
```

#### Clear Bash terminal Screen
 - `clear`
 - `CTRL + L`

#### exit from terminal
`exit`

##### Change permissions of a file based on permissions of other file
`RFILE=reference_file ; sudo chmod --reference=\$RFILE`

##### Change ownership of all files inside current dir to a given group
`GROUP_NAME=common ; sudo chown :\$GROUP_NAME \*`

## CURL Client URL

#### Download a file and save it with a custom name

`curl -o custom_file.tar.gz https://testdomain.com/testfile.tar.gz`

#### Get HTTP headers. use the `-I` or the `— head` option

`curl -I https://www.google.com`

#### Ignore invalid certs `-k or --insecure`

`curl -k https://localhost/my_test_endpoint`

#### Make a POST request. JSON `-H 'Content-Type: application/json'`

`curl --data "param1=test1&param2=test2" http://test.com`

#### Specify the type of request

```bash
# updating the value of param2 to be test 3 on the record id
curl -X 'PUT' -d '{"param1":"test1","param2":"test3"}' \http://test.com/1
```

#### Include the Basic Auth:

`curl -u <user:password> https://my-test-api.com/endpoint1`

#### Update name resolution

`curl --resolve www.test.com:80:localhost http://www.test.com/`

#### Check service health
`curl -Is http://www.google.com`

#### Upload a file

`curl -F @field_name=@path/to/local_file <upload_URL>`

#### Timing Curl connection

`curl -w "%{time_total}\n" -o /dev/null -s www.test.com`

## PDF Operations Tools
### PDF tool kit

##### Recursively find inside pdfs

`find . -iname '*.pdf' -exec pdfgrep "Title of File to search " {} +` <br>
`pdfgrep -r "Title of PDF to find"` <br>

#### Get info about the pdf toolkit

`info pdftk` <br>

#### Get info about PDF_FILE

`pdftk $PDF_FILE.pdf dump_data_utf8 | grep InfoValue:`<br>

#### extract a range of pages from a pdf file

`pdftk source.pdf cat 5-10 output ExtractedOutput_p5-10.pdf`

#### split specific pages from the source file, for example page 5, page 6, and page 10

`pdftk source.pdf cat 5 6 10 output SplittedOutput.pdf`
---

# Windows products (micro\$oft)
## Windows - & WinServer
win10 (unfortunately) Powershell

Executed in Powershell 7 in windows 10 that runs as a VM inside Linux ubuntu 18.

### Networking

##### Get your Public IP Address

`(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content`

#### Flush DNS and restart networking
Open a terminal or powershell window as Admin
```dotnetcli
ipconfig /flushdns
ipconfig /registerdns
ipconfig /release
ipconfig /renew
netsh winsock reset

echo " Restart the computer "
```

##### Restart Network IPV6 associated
`netsh int ipv6 reset reset.log`
- Disable any active virtual private network (VPN) connection.
- Restore the firewall defaults

### Disable the IP Helper service
This features attempts to manage some aspects of IPv6 connectivity. To disable it:
1. Press Windows key+R, then type services.msc in the displayed window Run box, and select OK.
2. A list of Windows system services will be shown.
3. Scroll through the list and locate the service named IP Helper > right-click the service name > Properties.
4. In the Startup type drop-down list, choose Disabled, then select OK.
5. Restart your system
6. check to see if the IPv6 connection now works as expected.

#### Clean-up network devices

`netcfg -d`

#### Verify that DNS name resolution is working correctly

`nslookup "host"`

##### Extracted from some old notes

``` powershell
attrib = configurations for files and folders
netstat -nao = network statistics
netsat -ano | find str "PID"

sc = services command
sc delete "serviceName"
sfc /scannow || System File Checker
pathping  "ip" || determine whether the router is performing slowly or dropping packets.
fciv.exe [Commands] <Options> || File Checksum Integrity Verifier install as plugin first.
```

### Windows Nice [Terminal](https://docs.microsoft.com/en-us/windows/terminal/get-started#installation)

#### Windows terminal with vertical panes. 2nd pane is WSL

`wt split-pane --vertical wsl`

---

#### VPN

OpenVPN set [up in ubuntu](https://tecadmin.net/install-openvpn-client-on-ubuntu/)

### Open SSH

- [official OpenSSH](https://www.openssh.com/)
- [SSH Academy](https://www.ssh.com/ssh/ssh-academy)

#### Great docs at [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-configure-custom-connection-options-for-your-ssh-client#general-tweaks-and-connection-items)

- Use a config ssh custom file to ease connectivity
- Make sure you are clear PuTTY will create keys with a `priv.ppk` format in windows vs Linux Open SSH key `id_rsa`

## SSH Key Management

### Key generation

#### Generate SSH Key pair

#### Add a SSH key to ssh-agent

``` bash
ssh-add -k ~/.ssh/id_rsa
ssh-keygen -t rsa
```

#### Get content of default name of Public Key

`cat ~/.ssh/id_rsa.pub`<br>

#### Add an SSH key to a remote Server
Read Public SSH key, ssh to \$REMOTE_HOST with root user and run a command to create a directory ssh and add the public key to authorized_keys file

``` bash
COMMAND="mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
cat ~/.ssh/id_rsa.pub | \
ssh root@$REMOTE_HOST $COMMAND
```

# Git
system to manage and store source code. Keeps track of changes to the files. Text files only.
## Git Administration/Operation
- use `@` instead of `HEAD`

GitOps reading from a [medium post @omar Shakari](https://medium.com/better-programming/git-commands-to-live-by-349ab1fe3139)

#### Delete Remote Branches
`git push <remote> -d <branch>`

OR

`git push <remote> :<branch>`

`git push origin :my-awesome-feature`

#### Change remote URL if you change your repository’s name
`git remote set-url <remote> <newurl>`

`git remote set-url origin github.com/myusername/my-repo`

##### Stash Individual Files
`git stash push -- <filepath(s)>`

Example:

`git stash push -- src/index.js README.md`

##### Show Content of Most Recent Stash

`git stash show -p [stash@{<n>}]`

**Explanation:**

`-p` to see the actual content of the stash. Omitting it will show only the file names.

`stash@{<n>}` allows us to specify a certain stash, denoted by `n` ( 0 being the most recent one ).

`git stash show -p stash@{1}`

#### Check Out File From Another Branch
`git checkout <branch> -- <path(s)>`

`git checkout another-branch src/file.js`

#### Working with 2 branches
`git worktree add <path> <branch>`

- when you no longer need the branch:
`git worktree remove [-f] <path>`

**Example:**
1. `git worktree add my-other-awesome-feature ../my-other-awesome-feature`
1. `git worktree remove ../my-other-awesome-feature`

**Explanation:** Creates a linked working tree (i.e., another directory on the file system associated with the repo) called `my-other-awesome-feature`, one level above your current working directory, with the specified branch checked out.

#### Show Commit Content shows changes introduced by a commit
`git show COMMIT`

Alternatively, to see the changes between two specific commits run

`git diff COMMIT_A COMMIT_B`

`git diff HEAD~ HEAD`

#### Compare Files Between Branches/Commits

`git diff <commit-a> <commit-b> -- <path(s)>`
`git diff 0659bdc e6c7c0d -- src/flair.py`

#### Reset a Single File to Most Recent Commit
`git checkout [<commit>] -- <path(s)>`

`git checkout -- README.md`

#### Change Last Commit Message
`git commit --amend [-m '<message>']`

If the old commit had already been pushed, you’ll need to additionally run

`git push --force-with-lease <remote> <branch>`

**Note:** As a general rule, and especially if you’re working with others, it’s important to be careful when making any changes to already pushed commits.

#### Change a Specific Commit Message
`git rebase -i COMMIT`

`git rebase -i HEAD~3`

#### Delete Last Commit but Keep the Changes
`git reset HEAD^`

#### Unstage a File
`git reset HEAD <path>`

#### Remove Ignored Files From Remote
later decided to `.gitignore` them, the files will nevertheless persist in your remote repository. To remedy this

`git rm`

is the tool for the job.

`git rm [-r] [-n] --cached <path(s)>`

Then, simply add, commit, and push

#### Hard reset of branch
`git reset --hard `

#### show GPG signatures used in a repo
`git log --show-signature`

#### Find local GIT repos

`sudo find -name HEAD -execdir test -e refs -a -e objects -a -e config \; -printf %h\\n`
<br>

#### Get help with any git command
`git init --help`

`git COMMAND --help`
#### Clone a Git Repo

`git clone git@github.com:elastic/stack-docker.git`
`git status`
`git branch`
`git info`

#### Basic Git config set up

``` bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

#### Instruct Git to use GPG2 instead of GPG as the signing program
`git config --global gpg.program gpg2`

#### Test by signing some text with `gpg` and `gpg2`
`echo "test" | gpg2 --clearsign`

#### Set variable for GPG and terminal usage
`export GPG_TTY=$(tty)`

### Git Analysis/Reporting
#### Get git global info
`git config --global --list`

#### List all remote branches
`git branch -r`

#### List remote active branches
`git ls-remote --heads origin`
#### Get info about commits for a given user

``` bash
git_user="git_user"
git_date="Sat Aug 30 2021"
git log --oneline -5 --author $git_user --before $git_date
```

#### Get a histogram for a gitdiff

`git diff --histogram`

#### Prints out just the subject line

`git log --oneline`

#### Groups commits by user, again showing just the subject line for concision

`git shortlog`

#### Switch to previous branch
`git checkout -`

#### Add small patches to a commit
`git add -p`

#### Find the last working commit by basically using binary search.
``` BASH
git bisect start

# for a commit that you know is working correctly
git bisect good

# for a commit that you know is NOT working correctly
git bisect bad
```

#### Ammend a commit
```bash
git commit --amend

git push -f
```

#### Change a commit message that was made

``` bash
#n is the number of commits to go back
git rebase -i HEAD~n

# best to use git cherry-pick

## then
edit

git push -f
```
#### List of common commands
``` bash
git init
git clone
git branch
git checkout
git status
git fetch
git pull
git add
git commit
git push
git remote
git merge
git log
git stash
git reset
git config
```

## Git implementations: Bitbucket
 Atlassian support [docs](https://support.atlassian.com/bitbucket-cloud/docs/change-the-remote-url-to-your-repository/)

- get detailed info
`git remote --verbose`

- get extra info about remote

`git remote show origin`

- Update the remote URL with git remote set-url using the current and new remote URLs.
`git remote set-url origin git@bitbucket.org:tutorials/tutorials.git`

#### see the list of git stashes
`git stash list`

#### reset the current HEAD or changes of your local branch to a specific state.
`git reset [FILE_PATH]`
# Programming Languages

## Java

- todo add short details description
- todo add main links

### OpenJDK

##### update-alternative set version for Java

update-alternatives --config java

### Oracle Java

## Python

# DataBases

## MariaDB (MySQL open source Fork)

## Oracle MySQL

#### Connect to DB with mysql command utilities

``` BASH
HOST=localhost; USER=mysql
mysql -h $HOST -u $USER -p
```

#### To check the default character set for a particular database DB_NAME

``` SQL
SELECT SCHEMA_NAME, DEFAULT_CHARACTER_SET_NAME
       FROM INFORMATION_SCHEMA.SCHEMATA
       WHERE SCHEMA_NAME='DB_NAME';
```

## AWS RDS MySQL engine


## PostgreSQL
#### Check this super [PostgreSQL Cheat sheet](https://www.postgresqltutorial.com/postgresql-cheat-sheet/)


#### Access the PostgreSQL server from psql with a specific user:
`psql -U [username]`

> Once in the console:

#### Check version
`SELECT version();`

#### dump DB and create the DB in the script
`pg_dump -U postgres -W -C -d example_backups > ~/db_backup.sql`

#### back up my entire PostgreSQL cluster and save it in the entire_cluster.sql file
`pg_dumpall -U postgres -W -f ~/Example_Dumps/Cluster_Dumps/entire_cluster.sql`

> avoid system asking for too many pass by using ~/`.pgpass file.`

syntax
`hostname:port:database:username:password`

## Microsoft SQL Server

# Operating Systems

## Linux Ubuntu

### System settings

#### **Get** dimendions of Display

`xdpyinfo | grep dim`

### Nautilus operations

#### Show hidden files Keyboard shortcut

`CTRL + H`

#### Show Path Location Keyboard shortcut

`CTRL + L`

#### Switch between the Icons and List formats

`CTRL + 1 | CTRL + 2`


#### Search for files

`CTRL + F`

#### Delete File(s)

`CTRL + delete`

#### permanently delete

`Shift + Delete`
(You should never delete your Home directory, as doing so will most likely erase all your GNOME configuration files and possibly prevent you from logging in. Many personal system and program configurations are stored under your home directory.)

# Docker
`docker version` <br>
`docker volume ls` <br>
`docker system df`<br>

#### Search for an app or project containing given strings

`docker search nagios`

#### Stop All Containers

`docker stop $(docker ps --quiet)`

#### Clean up Everything including volumes

`docker system prune --all --force --volumes`

#### Show containers that have an exposed port then sort

`docker ps --filter expose=0-65535/tcp | sort -u -k7`

#### List labels for a given docker container source: https://gist.github.com/steve-jansen

```bash
CONTAINER=ID or container name
docker inspect --format \
    '{{ range $k, $v := .Config.Labels -}}
    {{ $k }}={{ $v }}
    {{ end -}}' $CONTAINER
```

#### Get IP of a given container

`docker inspect -f ‘{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}’ $CONTAINER_NAME_OR_ID` <br>

#### List commands used to create a given image

```bash
MY_IMG=
docker history $MY_IMG | awk 'NR>1 {print $1}' | xargs docker inspect --format '{{ ((index .ContainerConfig.Cmd ) 0) }}'
```

### YQ for yaml processing

```bash
echo 'yq() {
  docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
}' | tee -a ~/.bashrc && source ~/.bashrc
```

## Docker-Compose
Orchestrates docker containers.

#### Install Docker-Compose
```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
##### Get docker compose version
`docker-compose version` <br>
##### Validate docker compose configuration
##### Validate config and Build docker-compose stack
`docker-compose config` <br>
`docker-compose build` <br>
##### Execute a docker-compose with verbosity
`docker-compose --verbose up --detach` <br>
`docker-compose images` <br>
`docker-compose -f setup.yml up --remove-orphans` <br>
`docker-compose --verbose top` <br>
`docker-compose --verbose ps` <br>
`docker-compose --verbose stats` <br>


``` bash
DOCKER_COMPOSE_FILE=/opt/docker-compose.yaml
SERVICE_NAME="NameInsideDockerCompose"
```

#### check status of the cocker-compose stack
`docker-compose -f $DOCKER_COMPOSE_FILE ps`

#### check logs
`docker-compose -f $DOCKER_COMPOSE_FILE logs`
#### tail/get  log in format log-yyy-mm-dd. The log lives in a special path in the container. Piped to `less`
`docker-compose -f $DOCKER_COMPOSE_FILE exec SERVICE_NAME cat "logs/log-$(env TZ="NZT" date +%Y-%m-%d).php" | less`

#### pipe contents of a supervisord.log to `less` from within the container to the host shell 
`docker-compose -f $DOCKER_COMPOSE_FILE exec SERVICE_NAME cat "logs/supervisord.log" | less`
# Kubernetes K8S

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


## [Image Magick](https://imagemagick.org/index.php)
### Image operations with ImageMagick

#### easily-resize-images

```bash
# percentage
convert  -resize 50% source.png dest.jpg

# Specific size
SIZE="1024X768"
convert -resize $SIZE source.png destination.jpg
```