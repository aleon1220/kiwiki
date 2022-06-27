<h1>KIWIKI</h1> <br>
<h2>Information Technology Wiki</h2> <br>

> <h4> work by @aleon1220. A Colombian adopted by Kiwis since 2016</h3>

---

- [About KIWIKI Project](#about-kiwiki-project)
  - [Repository Categories](#repository-categories)
  - [Introduction](#introduction)
  - [The Computer, a modern Tool](#the-computer-a-modern-tool)
  - [The CLI Shell](#the-cli-shell)
    - [CLI Shell keyboard shortcuts](#cli-shell-keyboard-shortcuts)
  - [Auto Docs: image of file categories](#auto-docs-image-of-file-categories)
  - [General Info](#general-info)
  - [3. Storage](#3-storage)
    - [Process for Linux + `LVM` + `ext3`](#process-for-linux--lvm--ext3)
  - [Systemd Systemctl](#systemd-systemctl)
  - [Compression/Decompression of files](#compressiondecompression-of-files)
  - [Find/Search operations](#findsearch-operations)
  - [Package Management](#package-management)
    - [APT](#apt)
  - [Debugging Linux Systems (mostly Ubuntu)](#debugging-linux-systems-mostly-ubuntu)
    - [Explore System Processes](#explore-system-processes)
  - [Handling Logs](#handling-logs)
    - [Networking](#networking)
    - [Network Probing](#network-probing)
    - [Traffic capture](#traffic-capture)
    - [Network management](#network-management)
    - [Load testing](#load-testing)
    - [Benchmarking](#benchmarking)
    - [The `ip` command](#the-ip-command)
- [Terminals](#terminals)
  - [CURL Client URL](#curl-client-url)
  - [PDF Operations Tools](#pdf-operations-tools)
    - [PDF tool kit](#pdf-tool-kit)
- [Windows products (micro\$oft) Moved to windows/readme](#windows-products-microoft-moved-to-windowsreadme)
    - [Open SSH](#open-ssh)
  - [SSH Key Management](#ssh-key-management)
    - [Key generation](#key-generation)
- [Git Moved to Git](#git-moved-to-git)
- [Programming Languages](#programming-languages)
  - [Java Moved to Programming-languages &gt; Java](#java-moved-to-programming-languages--java)
  - [Python Moved to Programming-languages &gt; python](#python-moved-to-programming-languages--python)
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
    - [Tool YQ for YAML processing](#tool-yq-for-yaml-processing)
  - [Docker see](#docker-see)
  - [Image Magick](#image-magick)
    - [Image operations with ImageMagick](#image-operations-with-imagemagick)

---

> **END of Table of contents**

---

# About KIWIKI Project

This project is a collection of CLI reusable commands.

## Repository Categories

1. Cloud Providers
   1. [AWS](./aws/readme.md)
   2. [Azure](./azure/readme.md)
   3. [Google Cloud Engine](./gce/readme.md)
2. devops-tools
   - Jenkins
   - Terraform
3. gradle
4. javascript
5. LDAP
6. productivity-tools
   - rescueTime
   - VsCode
7. programming-languages
8. Regular [expressions](./regex/readme.md)
9. Security
10. windows

## Introduction

- **2020-04-28=** I lost years of work on setting a nice Information Technology Wiki. I am starting a new one here

For years i have been collecting snippets on linux, solaris, C, Java, Docker, Kubernetes, etc.
I used a `.txt` file, then a google docs file. I managed to delete the google docs file from its google drive folder. I accidentally deleted the folder and later on I emptied the bin. I truly dislike that...

I got in touch with google support to no avail. I waited and hoped I could recover my file (there was no way to recover the file). Don't rely on the cloud 100%. Have local copies of your digital material.

- **2020-11-10=** I confirm that i lost my google docs wiki file. I should have been more careful.
- **2021-04-07=** processing inbox category. Moved intro below About Project

## The Computer, a modern Tool

A Computer has a CPU processor, memory RAM, storage in form of a drive, connectivity via network card or wifi, graphics visualization via a monitor. The operating system has tools to manage and interact with all the described above.

Categories

- **General Info**

1. Processing
2. Memory
3. Storage
4. Networking
5. Graphics

## The CLI Shell

there are many: bash, fish, Zshell

### CLI Shell keyboard shortcuts

- `ctrl + a`  moves cursor to beginning of line (a alphabet or first letter)
- `ctrl + e`  moves cursor to end of line (Is also kinda close to letter `a` in the US keyboard)
- `ctrl + w`  cuts the word to the left of the cursor.
- `alt  + d`  cuts the word to the right of the cursor.
- `ctrl + k`  cuts everything to the right of the cursor.
- `ctrl + u`  cuts everything to the left of the cursor.
- `ctrl + y`  pastes back what you have just cut.
- `ctrl + l`  clear  the screen
- `ctrl + e + x` explanation below

```bash
Type a Long command, e.g. add loops or some complex parsing logic. You need more editing power so you press

                      ctrl + e + x

Editors VIM(or Nano or VI etc.) opens with your command you had typed so far already in the buffer
```

## Auto Docs: image of file categories

#### Demo for one Java WebApp

[Octo-repo Demo Java WebApp](https://octo-repo-visualization.vercel.app/?repo=aleon1220%2Fmulti-cloud-WebApp-Attendance)

## General Info

Get quick diagnostic about a server

#### OS type, Local IP, hostname and Architecture type

```bash
lsb_release -a ; hostname -I ; hostname ; getconf LONG_BIT
```

#### What are the services enabled and running?

#### List of software installed from [A-Z]

#### Check the hidden directories and files in the HOME dir

```bash
todo $HOME
```

#### Check bash customizations in the current user

```bash
id

less ~/.bashrc
```

## 3. Storage

Hard drives, volumes, SSDs, mounts, filesystem, etc

### Process for Linux + `LVM` + `ext3`

LVM volume group myvg, mounted volume name `uservol1` and disk device in Linux is `/dev/sdf`

Allocate the disk to the VM. (In Amazon Management Console, Create the EBS volume, write down its ID, and allocate it to the instance)
The EC2 instance should have some udev rules for creating the device node. So you should see a new disk in `/dev/sd*`

Log in on the instance and check that the EBS volume is visible,

```bash
fdisk -l /dev/sdf
```

- check the partitions

```bash
cat /proc/partitions
```

- Check the Block ID, Type and label of the system devices

```bash
blkid
```

- Create partition table if needed:

```bash
fdisk /
sfdisk
```

- Initialize LVM

```bash
pvcreate /dev/sdf
```

- Add the disk (physical volume) to the LVM volume group vgextend

```bash
myvg /dev/sdf
```

- Grow the Volume size

```bash
lvextend -L +1024G /dev/myvg/uservol1
```

- Grow the `ext3/ext4` file system

```bash
resize2fs /dev/myvg/uservol1`
```

- Check system info and you should see that the mounted file system now have more space.

```bash
df -h
```

#### View your available disk devices, mount points (if applicable) to help you determine the correct device name to use

```bash
lsblk
```

#### Get information about the devices attached to the instance

```bash
sudo lsblk -f
```

#### Get manufacturer details for the device in a given format

```bash
lsblk -io NAME,TYPE,SIZE,MOUNtPOINT,FSTYPE,MODEL
```

#### Get `UUID` of the device (expensive command)

```bash
sudo blkid $DEVICE_REPORT_PORTAL_DATA | sed -n 's/.*UUID=\"\([^\"]*\)\".*/\1/p'
```

#### Get `UUID` of the device

```bash
DEVICE="/dev/nvme1n1"
# short format flags
sudo blkid -s UUID -o value $DEVICE
```

#### Get `UUID` of the device using long format flags

```bash
sudo blkid --match-tag UUID --output value $DEVICE
```

#### Make an USB bootable with a debian ISO

```bash
USB_DRIVE="/dev/sda"
ISO_PATH="/home/ws/01-inbox/debian/debian-11.0.0-amd64-DVD-1.iso"

sudo umount $USB_DRIVE
sudo dd bs=4M if=$ISO_PATH of=$USB_DRIVE conv=fdatasync status=progress
```

- Output of above in Ubuntu 20.04

```bash
sudo dd bs=4M if=/home/ws/01-inbox/debian/debian-11.0.0-amd64-DVD-1.iso of=/dev/sda conv=fdatasync status=progress
3946840064 bytes (3.9 GB, 3.7 GiB) copied, 328 s, 12.0 MB/s
941+1 records in
941+1 records out
3947823104 bytes (3.9 GB, 3.7 GiB) copied, 596.281 s, 6.6 MB/s
```

#### DMI table decoder

```bash
dmidecode | grep UUID
```

#### Get/set SATA/IDE device parameters

```bash
DEVICE="/dev/nvme1n1"
hdparm -tT --direct $DEVICE
```

#### Get information about a specific device, such as its file system type.  If the output shows simply data, there is no filesystem in the device

```bash
DEVICE_CHECK="/dev/xvdf"*
sudo file -s $DEVICE_CHECK
```

##### Confirm mounted loop device kernel module

```bash
lsmod | grep loop
```

##### Info about mount the loop device kernel module

```bash
modprobe loop
```

#### Show ID of Block devices

```bash
sudo blkid

# Ubuntu
sudo lsblk -o +UUID
```

##### Mount an ISO file as loop device

```bash
mount -o loop -t iso9660 <path/to/iso/file> /media/cdrom
```

#### Mount all filesystems

The file that keeps track of mounted devices is `/etc/fstab`

```bash
sudo mount -a
```

#### Check status of linux services

```bash
timedatectl status
sudo systemctl edit --full cron.service
sudo systemctl status nginx supervisor php7.2-fpm
sudo service jenkins status
```

#### Get info about linux version

```bash
cat /etc/os-release
```

#### Get pretty print version

```bash
less /etc/issue
```

#### Debian/ubuntu get detailed info

```bash
lsb_release -a
hostnamectl
```

##### Info about system

```bash
uname -a
```

## Systemd Systemctl

#### Check status of a Service

```bash
systemctl status APP_SERVICE

# system control status nginx
systemctl status nginx
```

#### Check if service is Active

```bash
systemctl is-active nginx
```

#### List all loaded service units

```bash
systemctl list-units -all | grep loaded | awk '{print $1;}'
```

#### List all enabled units

```bash
systemctl list-unit-files| grep enabled | awk '{print $1;}' > enabled.txt
```

#### List all loaded services

Make sure that all the services we use are in the startup script

```bash
systemctl list-units -all | grep service | grep loaded | awk '{print $1;}'
```

#### List all enabled services

```bash
systemctl list-unit-files | grep service | grep enabled | awk '{print $1;}' > enabled.txt
```

#### Find the list of services that are loaded but not enabled

```bash
systemctl list-units -all | grep service | grep loaded | awk '{print $1;}' > loaded.txt

systemctl list-unit-files | grep service | grep enabled | awk '{print $1;}' > enabled.txt

# Diff the files
diff -y loaded.txt enabled.txt
```

#### Diff the missing services. Quick glance of missing

```bash
diff -y loaded.txt enabled.txt | grep '<'
```

#### `pushd` and `popd` to jump between directories

```bash
pushd $DIR
popd
```

#### Reload system configs

The settings are read from all of the following system configuration files:

1. /run/sysctl.d/*.conf
2. /etc/sysctl.d/*.conf
3. /usr/local/lib/sysctl.d/*.conf
4. /usr/lib/sysctl.d/*.conf
5. /lib/sysctl.d/*.conf
6. /etc/sysctl.conf

   [source cyberciti](https://www.cyberciti.biz/faq/reload-sysctl-conf-on-linux-using-sysctl/)

```bash
sudo sysctl --system
```

#### Analyse Logs. Logs named 3 to 31.gz month. Month like Feb 2020 and print

```bash
zcat access.log.{3..31}.gz | grep -E 'Feb/2020' | awk '{print $1}' | sort -u | less
```

#### Xclip to capture the clipboard when copying

```bash
cat ~/.ssh/id_rsa.pub | xclip -sel clip
```

```bash
xclip
```

#### X windows var

```bash
echo $XDG_CURRENT_DESKTOP
```

#### Check a dir with a parameter. Double check `info stat`

```bash
stat %A $DIR
```

#### nohup execution

`nohup` runs the given COMMAND with hangup signals ignored, so that the command can continue running in the background after you log out.

```bash
nohup $COMMAND_OR_SCRIPT > out_$(date).txt
```

#### Echo a string an pipe it to a command

In this case the content of a `DockerFile` is echoed first then piped to `docker build` to create a docker image.

```bash
echo -e 'FROM busybox\nRUN echo "hello world"' | docker build -
docker build -<<EOF
FROM busybox
RUN echo "hello world"
EOF
```

##### Maintain symbolic links determining default commands. Show installed Apps

```bash
update-alternatives --get-selections
```

##### Edit sudo users

```bash
sudo visudo
```

##### Move `DIR1` to `DIRDestiny`

```bash
sudo mv $DIR1 $DIRDestiny
```

##### Find where the command is installed

```bash
which COMMAND

which pip
```

##### Create an alias with a command to go to a specific directory

```bash
alias ee='cd /home/ws/02-projects/ee/test/eenz' <br>

ee
```

#### Copy files from Local to Remote Server

Define the local and remote paths in env vars. Perform the copy

```bash
scp -r $LOCAL_PATH/sftp-shim ubuntu@$REMOTE_HOST_SERVER:$REMOTE_SERVER_PATH
echo "cd $PWD"
```

## Compression/Decompression of files

#### Decompress with Tar

```bash
tar -czvf name-of-archive.tar.gz /path/to/directory-or-file
```

#### Decompress with Zip

```bash
zip -r compressedFileName.zip file1 file2 dir1/ file3
```

#### Create a parent directory with 2 directories inside (Single line)

```bash
mkdir -p $HOME/example.com/server1/{httpd,dnsqmasq}
```

## Find/Search operations

```bash
find [where to start searching] [-options] [expression]
```

#### Search for the text ‘data’ within files that ends with md

```bash
find ./ -type f -name "*.md" -exec grep 'data'  {} \;
```

#### Find the file ‘LICENSE’ in just the current directory and 1 subdirectory level

```bash
find . -maxdepth 2 -name LICENSE
```

#### Find files containing specific text

```bash
grep -iRl "TEXT-TO-FIND" ./
```

##### Common Flags for `grep`

```bash
-i - ignore text case
-R - recursively search files in subdirectories.
-l - show file names instead of file contents portions.
```

`./` As the last parameter, the path to the folder containing files you want to search for text.

You can use the full path of the folder.

```bash
grep -iRl "TEXT" /home/user/Documents
```

#### Find the value of `THING_NAME` and replaces the value in a given config file

```bash
THING_NAME=< enter bucket Name >
sed -i -r "s/^THING_NAME=.*/THING_NAME=$THING_NAME/" /home/ubuntu/sftp-shim.config
```

#### Searches for (short form `-Eri`) string health_url in the current directory

```bash
grep --extended-regexp --recursive --ignore-case "health_url" .
```

#### Find directories modified within the past 10 days

```bash
find . -maxdepth 1 -type d -mtime -10  -printf '%f\n'
```

#### It should find the HTTPD user in a web server
```bash
HTTPDUSER=$(ps axo "user,comm" | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1)
```

## Package Management

### APT

Ubuntu package manager

#### Fetch packages from Repo

```bash
sudo apt update
```

#### Auto remove Obsolete packages

```bash
sudo apt autoremove
```

#### Upgrade packages

```bash
sudo aptupdate ; sudo apt upgrade --yes
```

#### List a package by name e.g. python

```bash
sudo apt list | grep python
```

#### List installed packages

```bash
sudo apt list --installed
```

#### Fix broken install packages

```bash
sudo apt --fix-broken install
```

#### Reinstall a package (better than removing or purging)

```bash
sudo apt install --reinstall $PACKAGE_NAME
```

#### Purge a package

```bash
sudo apt-get purge unattended-upgrades
```

#### Show GPG keys in the keyring

```bash
apt-key list
```

#### Remove PPA repository record

```bash
sudo add-apt-repository --remove ppa:PPA_Name/ppa
```

#### Remove a PPA from the source list in the terminal

```bash
sudo rm -i /etc/apt/sources.list.d/PPA_Name.list
```

#### Install a Debian Package

```bash
sudo dpkg -i $DEBIAN_PKG
```

#### Check if Periodic updates are enabled

```bash
cat /etc/apt/apt.conf.d/10periodic
```

#### Get packages from repo and find given string

```bash
dpkg --get-selections | grep PACKAGE_TO_FIND
```

#### list snap packages installed

```bash
snap list
```

## Debugging Linux Systems (mostly Ubuntu)

A very important set of skills when something goes wrong and is important to get quick info.
This can become a small DIY project to manage desktop and cloud servers.

```bash
ls -lth /var/log/ | sort --month-sort
```

#### Check the system log

```bash
less /var/log/syslog
```

#### Create empty file in given path

```bash
touch /home/user/new_empty_file.txt
```

```bash
less /etc/X11/xorg.conf
```

#### List directory with extensions

```bash
ls -xl ${DIR_PATH}
```

- Article [medium.com Troubleshooting](https://medium.com/better-programming/5-powerful-unix-commands-for-easier-troubleshooting-dd619d5e173a)

#### lists all open files belonging to all active processes

```bash
lsof
```

#### lists open files for current user

```bash
lsof -u $USER
```

#### Retrieve processes running on a specified port range

```bash
lsof -i :8090-9090
```

#### End all processes for a target user

```bash
kill -9 $(lsof -t -u $TARGET_USER)
```

### Explore System Processes

#### Find the process that consumes more CPU

```bash
ps -eo pid,%cpu,%mem,args --sort -%cpu
```

#### Sort processes by memory

```bash
ps aux --sort=-%mem
```

#### Unuseful view with a process tree

```bash
ps xfa | less
```

#### Read from a file in a specific line e.g. 4

```bash
less +4 -N show-time.sh
```

## Handling Logs

#### Commong logs in linux

`/var/log/message`

Contains global system messages, including the messages that are logged during system startup. Includes mail, cron, daemon, kern, auth, etc.

`/var/log/auth.log`

Authentication logs

`/var/log/kern.log`

Kernel logs

`/var/log/cron.log`

Crond logs

#### Check System Logs Journal Control

##### command for viewing logs collected by systemd

#### Obtain Log output with admin permissions

```bash
sudo journalctl
```

#### Check system logs

```bash
journalctl -xe
```

#### Obtain Log output from oldest to newest

```bash
journalctl -r
```

#### Monitor New Log Messages

```bash
journalctl -f
```

#### Show Logs within a Time Range

```bash
journalctl --since "2021-08-30 14:10:10"
journalctl --until "2022-09-02 12:05:50"
```

#### List SystemBoots

```bash
journalctl --list-boots
```

#### Show Logs for a Specific Boot

```bash
journalctl -b
```

#### Show Logs for a systemd Service

```bash
journalctl -u $SERVICE_NAME
```

#### View Kernel Messages

```bash
journalctl -k
```

#### change Output Format to json-pretty

```bash
journalctl -o json-pretty
```

#### Manually Clean Up Archived Logs

#### Reduce the size of your journals to 2GiB

```bash
journalctl --vacuum-size=2G
```

#### Remove archived journal files with dates older than the specified relative time

```bash
journalctl --vacuum-time=1years
```

### Networking

Commands and useful cheat sheet used in networking

##### Check this awesome Cheat sheet

[CheatSheet](https://www.linuxtrainingacademy.com/linux-ip-command-networking-cheat-sheet/)

Accessing a service
`whois` = servers
`dig DOMAIN` = DNS queries and shows associated records
`nslookup` = alternative to dig. It doesnt use the system local DNS.
`traceroute DOMAIN` = packets hop

### Network Probing

Which TCP or UDP ports are open.

Can i open a TCP connection to this destination?

#### Port scanning TCP,UDP ports open or closed

```bash
nmap -sS localhost
```

#### Sends ICMP pings. checks latency

```bash
ping/ping6
```

#### Test port 80 netcat

```bash
nc -lvz 80
```

`telnet` a complete protocol

```bash
tcdump -i eth0 icmp
```

#### Examine the IPv4 TCP-based sockets that are listening for connections on your system

```bash
ss -4 -tln
```

#### Examine the IPv6 TCP-based sockets that are listening for connections on your system

```bash
ss -6 -tln
```

#### Creating Unix Domain Sockets

```bash
socat unix-listen:/tmp/stream.sock,fork /dev/null&
socat unix-recvfrom:/tmp/datagram.sock,fork /dev/null&
```

#### examine unix domain sockets

```bash
ss -xln
```

#### Connect to an UNIX Socket

```bash
nc -U -z /tmp/stream.sock
```

- The `-U` tells netcat that it is connecting to a Unix Domain Socket
- The `-z` option ensures that netcat only connects to a socket, without sending any data
- The `/tmp/stream.sock` is the address of the socket on the filesystem

#### Simulate traffic in IPV4 and IPV6

```bash
socat TCP4-LISTEN:8080,fork /dev/null&
socat TCP6-LISTEN:8080,ipv6only=1,fork /dev/null&
```

- `socat` can listen on any available port on a system, so any port from 0 to 65535 is a valid parameter for the socket option.

### Traffic capture

`tcpdump` traffic capture uses bpf filters
`tcpdump -i eth0 -vvv -d dst $IP`
`wireshark`

### Network management

`ifconfig` see info about interfaces. get your IP address

`route -n` routing info. Routing table

#### Check ARP cache

```bash
arp -a
```

`ip` see neighbor table. add routes

- Answers questions
  what are the net interfaces, ips, subnets, broadcast address??
  how do i add routes?

### Load testing

`tcpreplay` replays traffic from packet capture fire

```bash
tcpdump -i eth0 -w traffic.pcap
tcpreplay -i eth0 httptraffic.pcap
```

`wrk2` Send Http load

Threads connections duration Requests

```bash
wrk2 -t1 -c10 -d60 -R100 -L http://$IP
```

#### Send TCP or UDP traffic. Similar to wrk2 but allows UDP

```bash
iperf3
```

#### Network performance measurement tool

```bash
nuttcp
```

### Benchmarking

```bash
info siege
```

BPF/eBPF potential for new programs

**source:** Digital ocean talk Handy Linux networking tools

#### Flush DNS by resetting the network DEBIAN based

```bash
sudo /etc/init.d/networking restart
```

#### Inspect TCP socket states e.g. 443

```bash
ss -nta '( dport = :443 )'
```

`netstat` is a great tool for monitoring network connections.

#### Netstat statistics

```bash
netstat --statistics
```

#### Find ports in use

```bash
netstat -tulpn
```

- The `-t` option checks for TCP connections.
- The `-u` option checks for UDP connections.
- The `-l` option tells netstat to list only LISTENING connections. If you want to see all connections, use the -a option instead.
- The `-p` option shows the PID id of the process.
- The `-n` option shows numerical addresses, instead of trying to resolve host, port, or user names.

#### Make sure the `firewalld` service is enabled

```bash
ll /usr/lib/systemd/system | grep firewalld

ll /etc/systemd/system | grep firewalld
systemctl status firewalld

sudo systemctl enable firewalld
sudo systemctl restart firewalld
sudo systemctl status firewalld
```

#### Install netcat in Fedora/Redhat

```bash
yum install -y nc
```

#### CentOS Linux Open Port 8080 on the firewall

```bash
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
```

#### Find user behind a process

```bash
sudo netstat -tulpe | grep 8090
```

#### Test connectivity to a port

```bash
nc -vvz $host $port
```

#### Check server status

```bash
sudo netstat -tuple | grep smtp
```

#### Check Any URL and get output in Text

```bash
curl -l localhost:80
```

#### Get listening ports

```bash
ss -tulwn
```

#### Get a report with nmap. install it first `sudo snap install nmap`

```bash
nmap -sV -p- localhost
```

### The `ip` command

#### - Show / manipulate routing

```bash
ip route show
```

#### - Show List of routes

```bash
ip route list
```

#### - Show / manipulate devices

```bash
cat /etc/network/interfaces
```

- Policy routing
- Tunnels

#### Restart Name Service Cache Process

```bash
sudo service nscd restart
```

#### Create a Symbolic Link

```bash
SOURCE_FILE=/home/ubuntu/.local/bin/docker-compose
SYMBOLIC_LINK_PATH=/usr/bin/docker-compose
sudo ln --symbolic $SOURCE_FILE $SYMBOLIC_LINK_PATH
```

##### Check Timestamp for last updated packages in package manager apt

```bash
ls -l /var/lib/apt/periodic/update-stamp
```

##### History of commands executed in the current session

```bash
history
```

##### Create a random password

```bash
randompass=$(dd status=none bs=24 count=1 if=/dev/urandom | \
base64 | tr /= _)
```

##### Get stats info about a file

```bash
stat $FILE

# Help with the command
stat --help
```

#### Get text between quotes in a text file. Options

```bash
echo Source_File.txt | grep $REGEX_PATTERN
grep "'.*'" -o references-get-between-quoutes.txt > result_1855.txt

PATTERN='".*"'
grep -o $PATTERN raw_file.txt > result_file_$(date)_.txt
```

##### Interactive process viewer

```bash
htop
```

#### Check System Disk Usage

```bash
df -h
```

##### See who is connected and Display the load average (uptime output)

```bash
w -u
```

##### Get the user login history

```bash
last $USERNAME
```

##### Print the user name who are all currently logged in the current host

```bash
users
```

#### List Users in Linux

```bash
sudo less /etc/passwd
```

Each line in the file `etc/passwd` has seven fields delimited by colons that contain the following information:

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

#### Get a List of all Users in a Linux System

Each user has a numeric user ID called UID. If not specified when creating a new user with the useradd command, the UID will be automatically selected from the /etc/login.defs file depending on the UID_MIN and UID_MIN values.

```bash
getent passwd
getent passwd | cut -d: -f1
```

#### Set a new password for user `root`

```bash
sudo passwd $USERNAME
```

#### Set a new password for your own user

```bash
passwd
```

#### Check the UID_MIN and UID_MIN values on your system, you can use the following command

```bash
grep -E '^UID_MIN|^UID_MAX' /etc/login.defs
```

#### The command below will list all normal users in our Linux system

```bash
getent passwd {1000..60000}
```

#### Generic info about users from a Linux system

```bash
eval getent passwd {$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)..$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)}
```

#### Print only the usernames in a Linux System

```bash
eval getent passwd {$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)..$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)} | cut -d: -f1
```

##### Print the loggedin user name

```bash
id -un
```

##### Get the list of the usernames who are currently logged in

```bash
who
```

##### get a list of all usernames that are currently logged

```bash
who | cut -d' ' -f1 | sort | uniq
```

##### Launch file explorer Nautilus as super user admin

```bash
sudo nautilus
```

##### Scan full disk and analyze it using tool `ncdu`

```bash
sudo ncdu /
```

##### Remove directory forcefully

```bash
rm -rf $DIR_PATH
```

#### Search for execution of a given command in the history

```bash
COMMAND=who ; history | grep $COMMAND
```

#### Set max map count

```bash
sudo sysctl -w vm.max_map_count=262144
```

##### Show contents in tree view

```bash
tree $HOME
```

#### Sho contents of a directory in a tree format with `gio` Gnome Input/Output

```bash
gio tree
```

# Terminals

> ## more in the [Bash Section](/devops-tools/bash)

#### Most used commands in Bash History

```bash
history | \
awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count\*100 "% " a;}' | \
grep -v "./" | column -c3 -s " " -t | \
sort -nr | nl | head -n10
```

#### Script to list files, directories, executables, and links from a given Workspace directory

#### List all files in a current directory

```bash
find . -maxdepth 1 -type f -print
```

#### Script usage= `lsf` lists files, `lsd` lists directories, `lsx` lists executables, `lsl` lists links

#### start a process in the background

```bash
COMMAND="rescuetime"
$COMMAND &
```

#### Create a string with the current date in the format **YYYY-MM-DD_HHMM**

```bash
APP_VERSION="vtest-"$(date +%F_%H%M)
```

#### Create a dir and run a command in 1 line

```bash
`cd $DIR1; $(COMMAND)`
```

#### Create a file and add content to it

```bash
FILE_PATH=/home/ubuntu/.bash_functions

sudo bash -c "cat > $FILE_PATH"<<EOF
Content and text here
foobar
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

#### Exit from terminal

```bash
exit
```

##### Change permissions of a file based on permissions of other file

```bash
REF_FILE="a_file.txt" ; sudo chmod --reference=\$REF_FILE
```

##### Change ownership of all files inside dir to a given linux group

```bash
GROUP_NAME="common" ; sudo chown :\$GROUP_NAME \*
```

## CURL Client URL

#### Download a file and save it with a custom name

```bash
curl -o custom_file.tar.gz https://testdomain.com/testfile.tar.gz
```

#### Get HTTP headers. use the `-I` or the `— head` option

```bash
curl -I https://www.google.com
```

#### Ignore invalid certs `-k or --insecure`

```bash
curl -k https://localhost/my_test_endpoint
```

#### Make a POST request.

If using **JSON** `-H 'Content-Type: application/json'`

```bash
curl --data "param1=test1&param2=test2" http://test.com
```

#### get the HTTP headers and verbose mode

```bash
curl --head --verbose HOST
```

#### Simplified view

```bash
curl --list-only $HOST
```

#### Specify the type of request

```bash
# updating the value of param2 to be test 3 on the record id
curl -X 'PUT' -d '{"param1":"test1","param2":"test3"}' \http://test.com/1
```

#### Include the Basic Auth

```bash
curl -u <user:password> https://my-test-api.com/endpoint1
```

#### Update name resolution

```bash
curl --resolve www.test.com:80:localhost http://www.test.com/
```

#### Check service health

```bash
curl -Is http://www.google.com
```

#### Upload a file
```bash
curl -F @field_name=@path/to/local_file <upload_URL>
```

#### Timing Curl connection

```bash
curl -w "%{time_total}\n" -o /dev/null -s www.test.com
```

## PDF Operations Tools

### PDF tool kit

##### Recursively find inside PDFs

```bash
find . -iname '*.pdf' -exec pdfgrep "PDF text content to find " {} +
```

#### Using `pdfgrep`

```bash
pdfgrep -r "PDF text content to find"
```

#### Get info about the pdf toolkit

```bash
info pdftk
```

#### Find string *InfoValue* in the metadata of `PDF_FILE`

```bash
PDF_FILE="a_pdf_file.pdf"
pdftk $PDF_FILE.pdf dump_data_utf8 | grep InfoValue:
```

#### Extract a range of pages from a PDF file

```bash
pdftk source.pdf cat 5-10 output ExtractedOutput_p5-10.pdf
```

#### Split specific pages from the source file, for example page 5, page 6, and page 10

```bash
pdftk source.pdf cat 5 6 10 output SplittedOutput.pdf
```

---

# Windows products (micro\$oft) Moved to [windows/readme](./windows/readme.md)
> Executed in Powershell 7 in windows 10 that runs as a VM inside Linux ubuntu 18
  
---

#### VPN

OpenVPN [setup in ubuntu](https://tecadmin.net/install-openvpn-client-on-ubuntu/)

### Open SSH

- [Official OpenSSH](https://www.openssh.com/)
- [SSH Academy](https://www.ssh.com/ssh/ssh-academy)

#### Great docs at [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-configure-custom-connection-options-for-your-ssh-client#general-tweaks-and-connection-items)

- Use a config `SSH` custom file to ease connectivity
- Make sure you are clear PuTTY will create keys with a `priv.ppk` format in windows vs Linux Open SSH key `id_rsa`

## SSH Key Management

### Key generation

#### Generate SSH Key pair

The key below will use 4096 encryption

```bash
SSH_KEY_EMAIL="person@example.com"

ssh-keygen -t rsa -b 4096 -C "$SSH_KEY_EMAIL"
```

#### Add a SSH key to ssh-agent

```bash
ssh-add -k ~/.ssh/id_rsa
ssh-keygen -t rsa
```

#### Get content of default name of Public Key

```bash
cat ~/.ssh/id_rsa.pub
```

#### Add an SSH key to a remote Server

Read Public SSH key, ssh to \$REMOTE_HOST with root user and run a command to create a directory ssh and add the public key to authorized_keys file

```bash
COMMAND="mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
cat ~/.ssh/id_rsa.pub | \
ssh root@$REMOTE_HOST $COMMAND
```

# Git Moved to [Git](./git/readme.md)

# Programming Languages

## Java Moved to [Programming-languages &gt; Java](./programming-languages/java/readme.md)

## Python Moved to [Programming-languages &gt; python](./programming-languages/python/readme.md)

# DataBases

## MariaDB (MySQL open source Fork)

## Oracle MySQL

#### Connect to a DB with mysql command utilities

```bash
HOST="localhost"; USER="mysql"
mysql -h $HOST -u $USER -p
```

#### Check the default character set for a particular database DB_NAME

```SQL
SELECT SCHEMA_NAME, DEFAULT_CHARACTER_SET_NAME
       FROM INFORMATION_SCHEMA.SCHEMATA
       WHERE SCHEMA_NAME='DB_NAME';
```

## AWS RDS MySQL engine

MySQL has a cloud behaviuour in AWS or any other cloud provider

## PostgreSQL

#### Check this super [PostgreSQL Cheat sheet](https://www.postgresqltutorial.com/postgresql-cheat-sheet/)

#### Access the PostgreSQL server from psql with a specific user

```bash
psql -U [username]
```

> Once in the `psql` console

#### Check DB version

```bash
SELECT version();
```

#### Dump DB and create a restore script

```bash
pg_dump -U postgres -W -C -d example_backups > ~/db_backup.sql
```

#### back up my entire PostgreSQL cluster and save it in the entire_cluster.sql file

```bash
pg_dumpall -U postgres -W -f ~/Example_Dumps/Cluster_Dumps/entire_cluster.sql
```

> Avoid system asking for the password by using a PostgreSQL config file at  `$HOME/.pgpass`

- `pgpass` Syntax

```bash
hostname:port:database:username:password
```

## Microsoft SQL Server

# Operating Systems

## Linux Ubuntu

### System settings

#### **Get** dimensions of Display

```bash
xdpyinfo | grep dim
```

### Nautilus operations

#### Show hidden files Keyboard shortcut

```bash
CTRL + H
```

#### Show Path Location Keyboard shortcut

```bash
CTRL + L
```

#### Switch between the Icons and List formats

```bash
CTRL + 1 | CTRL + 2
```

#### Search for files

```bash
CTRL + F
```

#### Delete File(s)

```bash
CTRL + delete
```

#### Permanently delete

```bash
Shift + Delete
```

(Never delete your Home directory, as doing so will most likely erase all your GNOME configuration files and possibly prevent you from logging in.
Many personal system and program configurations are stored under your home directory.)

### Tool YQ for YAML processing

```bash
echo 'yq() {
  docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
}' | tee -a ~/.bashrc && source ~/.bashrc
```

## [Docker see](./containers/readme.md)

## [Image Magick](https://imagemagick.org/index.php)

### Image operations with ImageMagick

#### Resize-images with percentage

```bash
# percentage
convert -resize 50% source.png dest.jpg
```

#### Resize an image with a specific value

```bash
SIZE="1024X768"
convert -resize $SIZE source.png destination.jpg
```

[Back to top](#)