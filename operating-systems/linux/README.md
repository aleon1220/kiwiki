[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Linux Introduction
<details>
<summary> Linux General Intro 📝 </summary>

Linux operating system, open-source philosophy, and the kernel.

The Outline here is a mirror from the [Linux foundation material](https://training.linuxfoundation.org/training/introduction-to-linux)

[edx.org](https://training.linuxfoundation.org/training/introduction-to-linux) and the book Modern Operating Systems by [Andrew Tanenbaum](https://www.amazon.com/stores/author/B000AQ1UBW/allbooks) 

## OS Basics

### CLI Shell keyboard shortcuts
- `CTRL + W`  cuts the word to the left of the cursor
- `CTRL + A`  moves cursor to beginning of line. A first letter of the alphabet
- `CTRL + E`  moves cursor to End of line
- `CTRL + E + X` for Complex multiline commands opens editor. 
check the `echo $EDITOR` variable

```bash
# beginner suggest to use nano
export EDITOR="vim"
```

- `CTRL + U`  cuts everything to the left of the cursor
- `CTRL + K`  cuts everything to the right of the cursor
- `CTRL + L`  clears the screen

- `Alt  + D`  cuts the word to the right of the cursor

### Shell navigation
#### toggle current/previous dir
```bash
cd -
```

#### list the directory stack
```bash
dirs -v
```

#### `pushd` and `popd` add & remove directories from stack

```bash
pushd $DIR
popd
```

##### Show dir contents in tree view
> some distros dont have `tree`

```bash
tree $HOME
```

#### Show contents of a directory in a tree format with `gio` Gnome Input/Output

```bash
gio tree
```

#### Create a directory and run a command

```bash
cd /home/ws/test ; ls -ltha
```

## System diagnostics
info about a server

#### Get info about the linux distro
Local IP, hostname and Architecture type

```bash
hostname -I ; hostname ; getconf LONG_BIT
```

#### Linux distro Debian system info
```bash
lsb_release -a
```

#### Check the hidden directories and files in the HOME dir
```bash
ls --all $HOME
```

print user and group info
```bash
id
```

#### Check bash customizations current user

```bash
less ~/.bashrc
```

#### Get info about linux version

```bash
cat /etc/os-release
```

#### read system identification information message

```bash
less /etc/issue
```

#### Debian/ubuntu get detailed info

```bash
lsb_release -a
```

#### Red Hat Enterprise Linux info

```bash
cat /etc/redhat-release
```

#### Query system control settings
```bash
hostnamectl
```

##### Info about system

```bash
uname -a
```

## Systemd Systemctl

#### List all loaded service units

```bash
systemctl list-units -all | grep loaded | awk '{print $1;}'
```

#### List loaded services

```bash
systemctl list-units -all | grep service | grep loaded | awk '{print $1;}'
```

#### List all enabled units

```bash
systemctl list-unit-files| grep enabled | awk '{print $1;}' > enabled.txt
```

#### Check status of services
```bash
LIST_SERVICES="nginx supervisor php7.2-fpm"
sudo systemctl status $LIST_SERVICES
sudo service jenkins status
```

#### Check if service is Active

```bash
systemctl is-active $APP_SERVICE
```

#### check date control
```bash
timedatectl status
```

#### edit a service

```bash
sudo systemctl edit --full cron.service
```

#### List enabled services export to text file

```bash
systemctl list-unit-files | grep service | grep enabled | awk '{print $1;}' > enabled.txt
```

#### Services with state loaded
3 commands to find the diff
```bash
systemctl list-units -all | grep service | grep loaded | awk '{print $1;}' > loaded.txt
```

#### Diff ops to find missing services
Quick glance of missing

```bash
# Diff the files
diff -y loaded.txt enabled.txt

diff -y loaded.txt enabled.txt | grep '<'
```

## File Operations
#### Move `DIR1` to `DIR_DESTINATION`

```bash
mv $DIR1 $DIR_DESTINATION
```

#### Copy files from Local to Remote Server

Define the local and remote paths in env vars. Perform the copy

```bash
scp -r "$LOCAL_PATH" ubuntu@"$REMOTE_HOST_SERVER":"$REMOTE_SERVER_PATH"
```

#### Create a file and add content to it

```bash
FILE_PATH="/home/ubuntu/.bash_functions"

sudo bash -c "cat > $FILE_PATH"<<EOF
Content foobar text here
another line foo
EOF
```

### File Permissions & Ownership
##### Change permissions of a file based on permissions of other file

```bash
REFERENCE_FILE="a_file.txt"
TARGETING_FILE="a_target_file_to_copy_permissions.txt"

sudo chmod --reference="$REFERENCE_FILE" "$TARGETING_FILE"
```

##### Change ownership of all files in current dir to a given group

```bash
GROUP_NAME="common" 
sudo --recursive "$GROUP_NAME" *
```
</details>

---
<!-- end of expand Introduction-->

# Linux Filesystem Tree Layout

<details>
<summary> Linux General Intro 📝 </summary>
Filesystem Hierarchy Standard (FHS), detailing the purpose of directories like `/etc`, `/var`, `/home`, `/bin`

</details>
<!-- end of expand -->

# Linux Graphical Interface
<details>
<summary> GUI </summary>

single Graphical Interface / Desktop section, GUIs, UIs

#### X windows var

```bash
echo $XDG_CURRENT_DESKTOP
```

#### Check X system settings
```bash
less /etc/X11/xorg.conf
```

#### Get dimensions of Display

```bash
xdpyinfo | grep dim
```

</details>
<!-- end of expand GUI -->

# User Group Environment & Account Management

<details>

<summary> User Account Management </summary>
Covers shell customization, environment variables, aliases, and startup scripts like .bashrc.

2024-06-12 migrating Win11 laptops with WSL 
- Migrate `~/.ssh`
- Migrate `~/.bashrc`

#### List Users in Linux
```bash
sudo less /etc/passwd
```

##### Create a user
```bash
useradd newUserName
```

##### Get the user login history
```bash
last $USERNAME
```

##### Print users name currently logged in the host
```bash
users
```

Each line in the file `etc/passwd` has seven fields delimited by colons that contain the following information:

- User name:
- password Encrypted. x means is stored in the `/etc/shadow` file
- User ID number (UID).:User’s group ID number (GID)
- Full name of the user (GECOS)
- User home directory
- Login shell (defaults to /bin/bash)

#### Display only the username

```bash
awk -F: '{ print $1}' /etc/passwd
cut -d: -f1 /etc/passwd
```

#### List all Users A-Z
Each user has a numeric user ID called UID.

If UID is not specified when creating a new user with the `useradd` command, the UID will be automatically selected from the `/etc/login.defs` file depending on the **UID_MIN** and **UID_MIN** values.

```bash
getent passwd | cut -d: -f1 | sort
```

#### check type of terminal
```bash
printf "%s\n" $TERM
```

#### Set a new password for user `root`
```bash
sudo passwd $USERNAME
```
- successful output
```bash
passwd: password updated successfully
```

##### edit sudo users

```bash
sudo visudo
```

#### Check the UID_MIN and UID_MIN values on your system

```bash
grep -E '^UID_MIN|^UID_MAX' /etc/login.defs
```

#### List all normal users

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

##### Print the logged-in user

```bash
id -un
```

##### get a list of all usernames that are currently logged

```bash
who | cut -d' ' -f1 | sort | uniq
```

#### Create variable formatted with current date **YYYY-MM-DD_HHMM**

```bash
APP_VERSION="Test-$(date +%F_%H%M)"
```

</details>
<!-- end of expand user management -->

# Package Management Systems

<details>

<summary> Linux Package Management </summary>
System Configuration overview of how software is distributed, repositories, and dependency resolution

depends on the Linux distro 

* dnf
* apt
* zypper

## APT
Debian/Ubuntu package manager

#### Auto remove Obsolete packages

```bash
sudo apt autoremove
```

#### update and then Upgrade packages

```bash
sudo apt update ; sudo apt upgrade --yes
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

</details>
<!-- end of expand -->

---

# Processes & Scheduling

<details>
<summary> Linux Processes </summary>

Process Monitoring, scheduling

#### find the HTTPD user in a web server
```bash
HTTPDUSER=$(ps axo "user,comm" | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1)
```

#### see every process forest format
```bash
ps -e --forest
```

#### Find the process that consumes more CPU

```bash
ps -eo pid,%cpu,%mem,args --sort -%cpu
```

#### Sort processes by memory

```bash
ps aux --sort=-%mem
```

#### View with a process tree

```bash
ps xfa | less
```

##### Interactive process viewer

```bash
htop
```

#### print a line and pipe it to a command

In this case the content of a `DockerFile` is echoed first then piped to `docker build` to create a docker image.

```bash
echo -e 'FROM busybox\nRUN echo "hello world"' | docker build -
```

#### run a command, append config file

```bash
docker build -<<EOF
FROM busybox
RUN echo "hello world"
EOF
```

#### run command in the background & log output to a file
`nohup` runs the given COMMAND with hangup signals ignored, so that the command can continue running in the background after you log out.

```bash
nohup $COMMAND_OR_SCRIPT > out_$(date).txt
```

</details>
<!-- end of expand processes -->

# Monitoring & Performance



<details>

<summary> Memory management </summary>


## Memory Monitoring, Usage & Swap
RAM usage and managing swap space (virtual memory on disk)

## I/O Monitoring
Input Output Ops
Monitoring input/output statistics for disks to identify performance bottlenecks.

## traffic capture

## load testing

## benchmarking

</details>
<!-- end of expand Section -->

# Containers Overview
<details>
<summary> Compute containers </summary>

</details>
<!-- end of expand Containers -->

# Linux Filesystems & the VFS

<details>
<summary> Linux file systems   </summary>

How the kernel handles different filesystem types via the Virtual Filesystem Switch (VFS).
Hard drives, volumes, SSDs, mounts, filesystem, etc

### EXT4 Filesystem
the default Linux filesystem, including journaling and inodes

### Compute Storage

Process for Linux + `LVM` + `ext3`

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

- Check system Disk File usage
storage info. Confirm mounted file system now have more space.

```bash
df --human-readable
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
```

#### Show ID of Block devices Debian
```bash
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

## Disk Partitioning

<details>
<summary> Disk partitioning </summary>
Dividing storage devices into logical sections (partitions)

</details>
<!-- end of expand Disk Partitioning -->


## Logical Volume Management (LVM)

<details>

Abstraction layer allowing flexible resizing and spanning of filesystems across multiple physical disks.
</details>
<!-- end of expand LVM -->

</details>
<!-- end of expand filesystems-->

# System & Boot

<details>

## Kernel Services & Configuration
Managing kernel parameters at runtime without rebooting using `sysctl`

##  Kernel Modules
Managing pieces of code (drivers) that can be loaded into or unloaded from the kernel on demand.
`lsmod`

## Devices and udev

Linux interacts with hardware devices via the /dev directory and the udev device manager.

#### Monitor udev events in real-time while plugging in a device.
```bash
udevadm monitor
```

## Booting
Managing the system startup process and services

## System init

<details>

todo: check-visually

</details>
<!-- end of expand -->

</details>
<!-- end of expand System & Boot -->

# Network Operations
<details>

## Network Addresses
Understanding IP addressing (IPv4/IPv6), subnets, and assigning addresses to interfaces.
Command: Show IP addresses assigned to all interfaces.

ip addr show

## Network Devices Configuration
Configuring network interfaces, gateways, and DNS using tools like NetworkManager or ip.

```bash
nmcli device status
```

#### Bring a network interface up.
```bash
sudo ip link set eth0 
```

Accessing a service, DNS
`whois` = servers

#### Query DNS
DNS queries and shows associated records
```bash
DOMAIN="airnewzealand.co.nz"
dig $DOMAIN
```

#### DNS Lookup force every section, include the query itself, and show statistics
```bash
DOMAIN="airnewzealand.co.nz"
dig $DOMAIN ANY +qr +question +answer +authority +additional +stats +multiline
```

#### Alternative to dig. It doesn't use the system local DNS.
```bash
nslookup $DOMAIN
```

#### Check packets hop and route
```bash
traceroute $DOMAIN
```

### Network Probing

Which TCP or UDP ports are open.

Can i open a TCP connection to this destination?

#### Port scanning TCP SYN

```bash
nmap -sS localhost
```

#### Sends ICMP pings. checks latency

```bash
ping $DOMAIN
ping6 $DOMAIN
```

#### netcat verbose but dont send test data port 80

```bash
nc -vz $DOMAIN 80
```

`telnet` a complete protocol

```bash
tcdump -i eth0 icmp
```

#### Examine the IPv4 TCP-based sockets that are listening for connections on your system
don't resolve service names

```bash
ss --ipv4 --listening --tcp --numeric
```

#### Examine the IPv6 TCP-based sockets that are listening for connections on your system

```bash
ss --ipv6 -tln
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

#### Send Http load
```bash
wrk2
``` 

Threads connections duration Requests

```bash
wrk2 -t1 -c10 -d60 -R100 -L http://$IP
```

#### Send TCP or UDP traffic. Similar to wrk2 allows UDP

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

#### Show operate manipulate routing

```bash
ip route show
```

#### List routes

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
curl --verbose --list-only $HOST
```

#### Specify the type of request
update the value of the key value mapping for the record id 1

```bash
curl -X 'PUT' -d '{"param1":"test1","param2":"test3"}' \http://test.com/1
```

#### call endpoint with Basic Auth

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

## VPN
TODO add linux VPN content

## Firewalls

</details>
<!-- end of expand Networking -->

# Backup Recovery Methods

<details>
Strategies for data archiving and synchronization using tools like tar and rsync.
</details>
<!-- end of expand -->

# Linux Security Modules

<details>
Mandatory Access Control (MAC) via SELinux or AppArmor

</details>
<!-- end of expand -->

# Troubleshooting  & Diagnostics

<details>

Techniques for troubleshooting unbootable systems, resetting root passwords, rescue disks

## Debugging Logs

#### Analyse Logs. Logs named 3 to 31.gz month. Month like Feb 2020 and print

```bash
zcat access.log.{3..31}.gz | grep -E 'Feb/2020' | awk '{print $1}' | sort -u | less
```

## System Rescue

#### Check and repair a filesystem
> only run on unmounted disks
```bash
sudo fsck /dev/sda1
```

</details>
<!-- end of expand -->

---

# Linux Distros
<details> 

<summary> Linux distributions🐧 </summary>

## Ubuntu
### System settings Nautilus 💻 🖥️💡 ⚙ 🛠️ 
#### Launch file explorer Nautilus as super user admin

```bash
sudo nautilus
```

#### operation Keyboard shortcuts

(Tux literal)

- Show hidden files Keyboard shortcut

```bash
CTRL + H
```

- Show Path Location Keyboard shortcut

```bash
CTRL + L
```

- Switch between the Icons and List formats

```bash
CTRL + 1 | CTRL + 2
```

- Search for files

```bash
CTRL + F
```

- Delete File(s)

```bash
CTRL + delete
```

- Permanently delete
```bash
Shift + Delete
```

- Never delete the Home directory, doing so will most likely erase all your GNOME configuration files and possibly prevent you from logging in.

</details>
<!-- end of expand -->

# Terminal Shells
<details>
<summary> Linux shells </summary>

## Bash
The Bash Shell and bash Scripting
refer to the Bash page

#### set bash as default shell for **myUser**
```bash
TARGET_USER="myUser"
sudo chsh -s /bin/bash $TARGET_USER
```

## Fish

## Zshell

</details>
<!-- end of expand Shells-->

---

# Section

<details>
<summary> TODO Title 📝 </summary>
TODO ADD details
</details>
<!-- end of expand -->

Top-level suggestions:

Introduction 
System & Boot,
Files & Storage, 
Processes & Memory, 
Networking, Security & Rescue, 
Package & System Management, 
Shells & UX, 
Distributions 

 References [x]

Place related tags as children, e.g. under Files & Storage place #linux-filesystem-tree-layout, #linux-filesystems--the-vfs, #ext4-filesystem, #disk-partitioning, #logical-volume-management-lvm, #compute-storage.

Create Monitoring & Performance with subtopics: #process-monitoring, #memory-monitoring-usage--swap, #io-monitoring, #traffic-capture, #load-testing, #benchmarking.

Turn #todo into a living project board: #todo: prioritize, #todo: write-first-draft, #todo: needs-review rather than one catch-all tag.

---

# References
- [cyberciti reload-sysctl-conf](https://www.cyberciti.biz/faq/reload-sysctl-conf-on-linux-using-sysctl)
- taxonomy & main structure from [LinuxFoundationX Introduction to Linux](https://www.edx.org/learn/linux/the-linux-foundation-introduction-to-linux)
- [Linux CheatSheet](https://www.linuxtrainingacademy.com/linux-ip-command-networking-cheat-sheet/)
- [Digital ocean talk Handy Linux networking tools](https://www.digitalocean.com/community/tech-talks/handy-networking-tools-and-how-to-use-them)
- OpenVPN [setup in ubuntu](https://tecadmin.net/install-openvpn-client-on-ubuntu/)
- [powerful unix commands for troubleshooting](https://medium.com/better-programming/5-powerful-unix-commands-for-easier-troubleshooting-dd619d5e173a)

[Back to top](#)

---

# todo: prioritise

<details>
move to the different category folders the different commands found in this page

## Section TODO:reuse-template
<details>
<summary> TODO Title  </summary>

TODO add detail
</details>
<!-- end of expand -->



## Text Editors

## User Environment

## Printing

#### Reload system configs

The settings are read from all of the following system configuration files

1. `/run/sysctl.d/*.conf`
2. `/etc/sysctl.d/*.conf`
3. `/usr/local/lib/sysctl.d/*.conf`
4. `/usr/lib/sysctl.d/*.conf`
5. `/lib/sysctl.d/*.conf`
6. `/etc/sysctl.conf`

```bash
sudo sysctl --system
```

#### Xclip to capture the clipboard when copying

```bash
cat ~/.ssh/id_rsa.pub | xclip -sel clip
```

#### Check a dir with a parameter. Double check `info stat`

```bash
stat %A $DIR
```

##### Maintain symbolic links determining default commands. 
Show installed Apps

```bash
update-alternatives --get-selections
```

##### Find where the command is installed

```bash
COMMAND="pip"
which $COMMAND
```

##### Create an alias `ee` with a command to go to a specific directory

```bash
alias ee='cd /home/ws/projects/ee/test'
```

## Compression/Decompression
### Tar
#### Decompress verbose

```bash
tar -zxvf archive-name.tar.gz /decompression/path/directory/
```
### Zip

```bash
zip  --recurse-paths work-log-years.zip directory1/ directory2/
```

#### Compress directories and files
```bash
zip -r compressedFileName.zip file1 file2 dir1/ file3
```
#### Decompress to current directory
```bash
unzip work-log-years.zip
```

####  batch extract all files to a specific directory
```bash
for i  in  $(find . –name “*.zip”–type f)
do
unzip –d $i /data/www/img/
done
```

#### Create a directory YYYY-MM-DD format
during testing is helpful to name files and directories

```bash
folder_name="$(date +%F)"
mkdir --parents --verbose $folder_name && cd $folder_name
```

#### Create a parent directory with 2 directories inside (Single line)
```bash
mkdir -p $HOME/example.com/server1/{httpd,dnsqmasq}
```

## Find/Search operations

```bash
find [where to start searching] [-options] [expression]
```

#### Search for the text **dataToFind** in markdown files

```bash
find ./ -type f -name "*.md" -exec grep 'dataToFind'  {} \;
```

#### Find file named LICENSE current directory and up to subdirectory level

```bash
find . -maxdepth 2 -name LICENSE
```

#### Find directories matching a String
```bash
-type d -name '*myServices*'
```

### Grep
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

#### Show GPG keys in the keyring for signing apps

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

## Debugging Linux Systems
> mostly Ubuntu/Debian based distros

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

#### List directory with extensions

```bash
ls -xl ${DIR_PATH}
```

#### lists open files for current user

```bash
lsof -u $USER
```
```
#### use sudo to change user
```bash
sudo su - OTHER_USER
```

#### End all processes for a target user

```bash
kill -9 $(lsof -t -u $TARGET_USER)
```

#### Read from a file in a specific line e.g. 4

```bash
less +4 -N show-time.sh
```

## Handle Logs

#### Commong logs in linux

- `/var/log/message`
Contains global system messages, including the messages that are logged during system startup. Includes mail, cron, daemon, kern, auth, etc.

- `/var/log/auth.log`
Authentication logs

- `/var/log/kern.log`
Kernel logs

- `/var/log/cron.log`
Crond logs

#### Check System Logs Journal Control
```bash
journalctl -xe
```

#### Obtain Log output from oldest to newest

```bash
journalctl -r
```

#### Show Logs within a Time Range

```bash
journalctl --since "2022-01-30 15:10:10"
journalctl --until "2022-12-24 00:05:50"
```

#### List System Boots

```bash
journalctl --list-boots
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

#### Reduce the size of your journals to 2GiB
Clean Up Archived Logs
```bash
journalctl --vacuum-size=2G
```

#### Remove archived journal files with dates older than the specified relative time

```bash
journalctl --vacuum-time=1years
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

#### Check System Disk Usage

```bash
df -h
```

##### See who is connected and Display the load average (uptime output)

```bash
w -u
```

##### Scan full disk and analyze it using tool `ncdu`

```bash
sudo ncdu /
```

##### Remove directory forcefully

```bash
COMMAND=who ; history | grep $COMMAND
```

#### Find in history matching 2 strings
useful when user knows the 2 stings used in a command.
Regex `.*` matches any sequence of characters
```bash
history | grep 'cd.*TESTS'
```

#### Set max map count

```bash
sudo sysctl -w vm.max_map_count=262144
```

#### History top 20 commands in bash_history
```bash
cat ~/.bash_history | grep -v ^# | awk '{print $1}' | sort | uniq -c | sort -nr | head -20
```

#### History 10 Most used commands
the format used is 
| column No | procId | percentage usage | command |

```bash
history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " "CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n10
```

#### List all files in a current directory

```bash
find . -maxdepth 1 -type f -print
```

#### Script usage
`lsf` lists files
`lsd` lists directories
`lsx` lists executables
`lsl` lists links

#### start command background

```bash
rescuetime &
```