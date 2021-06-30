<h1>KIWIKI</h1> <br>
<h2>Information Technology Wiki</h2> <br>

> <h3> work by @aleon1220. A Colombian adopted by Kiwis since 2017</h3>

---

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

# Inbox
Os hillman website. Iframe to include in website
```html
<iframe src="http://www.marketplaceleaders.org/a/" style="overflow:hidden" marginheight="0" marginwidth="0" frameborder="0" width="100%" height="100%"></iframe>
Read more: http://www.marketplaceleaders.org/tgif/api/#ixzz6pzkOZ8Wi
```

``` bash
BUCKET_NAME=< enter bucket Name >
sed -i -r "s/^BUCKET_NAME=.*/BUCKET_NAME=$BUCKET_NAME/" /home/ubuntu/sftp-shim.config
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


### Process for Linux + LVM + ext3
Example: LVM volume group myvg, mounted volume name `uservol1` and disk device in Linux is `/dev/sdf`

Allocate the disk to the VM. (In Amazon Management Console, Create the EBS volume, write down its ID, and allocate it to the instance)

The EC2 instance should have some udev rules for creating the device node. So you should see a new disk in `/dev/sd*`

Log in on the instance and check that the EBS volume is visible, eg fdisk -l `/dev/sdf`, `cat /proc/partitions`, run `blkid`

Create partition table if needed: fdisk / sfdisk

Initialize for LVM use: pvcreate /dev/sdf

Add the disk (physical volume) to the LVM volume group vgextend
myvg /dev/sdf

Grow the Volume size: lvextend -L +1024G /dev/myvg/uservol1
Grow the ext3/ext4 file system: resize2fs /dev/myvg/uservol1
Check (df -h) and you should see that the mounted file system now have more space.

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

#### Show ID of devices
```bash
sudo blkid

# Ubuntu
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

### ZFS File System
ZFS is a complex ayet powerful FileSystem


sudo systemctl enable zfs-import-scan.service
zpool get cachefile fix zfs-import-cache 

#### ZFS service not starting run the below commands:
zpool set cachefile=/etc/zfs/zpool.cache <pool>
systemctl restart zfs-import-cache.service

#### To ensure the zfs module is installed for the running kernel run the below command:
modinfo zfs

To ensure the zfs module is running, run the below command:
lsmod | grep zfs
## `ZFS` **Pool Related Commands**

# zpool create datapool c0t0d0	Create a basic pool named datapool
# zpool create -f datapool c0t0d0	Force the creation of a pool
# zpool create -m /data datapool c0t0d0	Create a pool with a different mount point than the default.
# zpool create datapool raidz c3t0d0 c3t1d0 c3t2d0	Create RAID-Z vdev pool
# zpool add datapool raidz c4t0d0 c4t1d0 c4t2d0	Add RAID-Z vdev to pool datapool
# zpool create datapool raidz1 c0t0d0 c0t1d0 c0t2d0 c0t3d0 c0t4d0 c0t5d0	Create RAID-Z1 pool
# zpool create datapool raidz2 c0t0d0 c0t1d0 c0t2d0 c0t3d0 c0t4d0 c0t5d0	Create RAID-Z2 pool
# zpool create datapool mirror c0t0d0 c0t5d0	Mirror c0t0d0 to c0t5d0
# zpool create datapool mirror c0t0d0 c0t5d0 mirror c0t2d0 c0t4d0	disk c0t0d0 is mirrored with c0t5d0 and disk c0t2d0 is mirrored withc0t4d0
# zpool add datapool mirror c3t0d0 c3t1d0	Add new mirrored vdev to datapool
# zpool add datapool spare c1t3d0	Add spare device c1t3d0 to the datapool
## zpool create -n geekpool c1t3d0	Do a dry run on pool creation
Show Pool Information
# zpool status -x	Show pool status
# zpool status -v datapool	Show individual pool status in verbose mode
# zpool list	Show all the pools
# zpool list -o name,size	Show particular properties of all the pools (here, name and size)
# zpool list -Ho name	Show all pools without headers and columns
File-system/Volume related commands
# zfs create datapool/fs1	Create file-system fs1 under datapool
# zfs create -V 1gb datapool/vol01	Create 1 GB volume (Block device) in datapool
# zfs destroy -r datapool	destroy datapool and all datasets under it.
# zfs destroy -fr datapool/data	destroy file-system or volume (data) and all related snapshots
Set ZFS file system properties
# zfs set quota=1G datapool/fs1	Set quota of 1 GB on filesystem fs1
# zfs set reservation=1G datapool/fs1	Set Reservation of 1 GB on filesystem fs1
# zfs set mountpoint=legacy datapool/fs1	Disable ZFS auto mounting and enable mounting through /etc/vfstab.
# zfs set sharenfs=on datapool/fs1	Share fs1 as NFS
# zfs set compression=on datapool/fs1	Enable compression on fs1
File-system/Volume related commands
# zfs create datapool/fs1	Create file-system fs1 under datapool
# zfs create -V 1gb datapool/vol01	Create 1 GB volume (Block device) in datapool
# zfs destroy -r datapool	destroy datapool and all datasets under it.
# zfs destroy -fr datapool/data	destroy file-system or volume (data) and all related snapshots
Show file system info
# zfs list	List all ZFS file system
# zfs get all datapool”	List all properties of a ZFS file system
Mount/Umount Related Commands
# zfs set mountpoint=/data datapool/fs1	Set the mount-point of file system fs1 to /data
# zfs mount datapool/fs1	Mount fs1 file system
# zfs umount datapool/fs1	Umount ZFS file system fs1
# zfs mount -a	Mount all ZFS file systems
# zfs umount -a	Umount all ZFS file systems
ZFS I/O performance
# zpool iostat 2	Display ZFS I/O Statistics every 2 seconds
# zpool iostat -v 2	Display detailed ZFS I/O statistics every 2 seconds
ZFS maintenance commands
# zpool scrub datapool	Run scrub on all file systems under data pool
# zpool offline -t datapool c0t0d0	Temporarily offline a disk (until next reboot)
# zpool online	Online a disk to clear error count
# zpool clear	Clear error count without a need to the disk
Import/Export Commands
# zpool import	List pools available for import
# zpool import -a	Imports all pools found in the search directories
# zpool import -d	To search for pools with block devices not located in /dev/dsk
# zpool import -d /zfs datapool	Search for a pool with block devices created in /zfs
# zpool import oldpool newpool	Import a pool originally named oldpool under new name newpool
# zpool import 3987837483	Import pool using pool ID
# zpool export datapool	Deport a ZFS pool named mypool
# zpool export -f datapool	Force the unmount and deport of a ZFS pool
Snapshot Commands
# zfs snapshot datapool/fs1@12jan2014	Create a snapshot named 12jan2014 of the fs1 filesystem
# zfs list -t snapshot	List snapshots
# zfs rollback -r datapool/fs1@10jan2014	Roll back to 10jan2014 (recursively destroy intermediate snapshots)
# zfs rollback -rf datapool/fs1@10jan2014	Roll back must and force unmount and remount
# zfs destroy datapool/fs1@10jan2014	Destroy snapshot created earlier
# zfs send datapool/fs1@oct2013 &gt /geekpool/fs1/oct2013.bak	Take a backup of ZFS snapshot locally
# zfs receive anotherpool/fs1 &lt /geekpool/fs1/oct2013.bak	Restore from the snapshot backup backup taken
# zfs send datapool/fs1@oct2013 | zfs receive anotherpool/fs1	Combine the send and receive operation
# zfs send datapool/fs1@oct2013 | ssh node02 “zfs receive testpool/testfs”	Send the snapshot to a remote system node02
Clone Commands
# zfs clone datapool/fs1@10jan2014 /clones/fs1	Clone an existing snapshot
# zfs destroy datapool/fs1@10jan2014	Destroy clone

### Install [ZF on Linux](http://download.zfsonlinux.org/epel/zfs-release.el6.noarch.rpm)

#### For RedHat and Fedora distros
`yum install kernel-devel zfs`

## ZFS management

`zfs-stat -A`

`rpm -aq | grep zfs`

`zfs version`

`zfs list`

`cat /proc/spl/kstat/zfs/arcstats`

`mount -t zfs /dev/xvdf /media/atl`

`zfs mount`

`zfs get all`

`dmesg | grep -i zfs`

### ZFS References
Solaris ZFS command line reference (Cheat sheet) https://www.thegeekdiary.com/solaris-zfs-command-line-reference-cheat-sheet/
Solaris ZFS : How to replace a failed disk in rpool (x86) https://www.thegeekdiary.com/solaris-zfs-how-to-replace-a-failed-disk-in-rpool-x86/
Solaris ZFS : How to Offline / Online / Detach / Replace device in a storage pool https://www.thegeekdiary.com/solaris-zfs-how-to-offline-online-detach-replace-device-in-a-storage-pool/
How to Backup and Restore ZFS root pool in Solaris 10 https://www.thegeekdiary.com/how-to-backup-and-restore-zfs-root-pool-in-solaris-10/
Solaris ZFS : How to Create / Rename / Rollback / Destroy a ZFS Snapshot https://www.thegeekdiary.com/solaris-zfs-how-to-create-rename-rollback-destroy-a-zfs-snapshot/
How to replace a disk under ZFS in Solaris https://www.thegeekdiary.com/how-to-replace-a-disk-under-zfs-in-solaris/
Solaris ZFS : How to Create and Manage Mirrored Storage Pools https://www.thegeekdiary.com/solaris-zfs-how-to-create-and-manage-mirrored-storage-pools/
How To Increase rpool Size On Solaris 11 (Requires a Reboot) https://www.thegeekdiary.com/how-to-increase-rpool-size-on-solaris-11-requires-a-reboot/
How to Configure iSCSI targets on Solaris 10 https://www.thegeekdiary.com/how-to-configure-iscsi-targets-on-a-solaris-10/
How To Use ‘zpool split’ to Split rpool in solaris 11 (x86/x64) https://www.thegeekdiary.com/how-to-use-zpool-split-to-split-rpool-in-solaris-11-x86x64/
How to mount the zfs rpool while booted from CD [SPARC] https://www.thegeekdiary.com/how-to-mount-the-zfs-rpool-while-booted-from-cd-sparc/


`zfs list|grep tank`

`/sbin/zfs mount -a`

zfs mount -O -a
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
## Compression/Decompression of files
`tar -czvf name-of-archive.tar.gz /path/to/directory-or-file`

`zip -r compressedFileName.zip file1 file2 dir1/ file3 `

#### Create a parent directory with 2 directories inside (Single line)
`mkdir -p $HOME/example.com/server1/{httpd,dnsqmasq}`

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

#### list with extensions
`ls -xl ${DIR_PATH}`

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

#### Check system logs
`journalctl -xe`

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

#### examine the IPv4 TCP-based sockets that are listening for connections on your system
`ss -4 -tln`

#### Examine the IPv6 TCP-based sockets that are listening for connections on your system
`ss -6 -tln`

#### Creating Unix Domain Sockets
``` bash
socat unix-listen:/tmp/stream.sock,fork /dev/null&
socat unix-recvfrom:/tmp/datagram.sock,fork /dev/null&
```

#### examine unix domain sockets
`ss -xln`

#### connect to an unix socket
nc -U -z /tmp/stream.sock
The -U tells netcat that it is connecting to a Unix Domain Socket.
The -z option ensures that netcat only connects to a socket, without sending any data.
The /tmp/stream.sock is the address of the socket on the filesystem.

#### Simulate traffic in IPV4 and IPV6
``` bash
socat TCP4-LISTEN:8080,fork /dev/null&
socat TCP6-LISTEN:8080,ipv6only=1,fork /dev/null&
```

`socat` can listen on any available port on a system, so any port from 0 to 65535 is a valid parameter for the socket option.

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

#### get the HTTP headers and verbose mode
`curl --head --verbose HOST`

#### simplified view
curl --list-only $HOST
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
Moved to [windows/readme](./windows/readme.md)
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

### Git basic challenge/Demo
Goal is to create a git repo at a linux location, Add changes to a source-code file, commit changes, create a develop branch with new changes and finally merge from develop --> main
#### initialize and operate a git repo at `/var/save/repo`
``` bash
mkdir -pv /var/save/repo | cd /var/save/repo
git init

Initialized empty Git repository in /var/save/repo/.git/
```
#### Create a develop branch (clones main references)
``` bash
git checkout -b develop
```

#### Check what branches are available in the repo
``` bash
git branch
* master
  test
```

#### Check the log to see info about all commits
``` bash
git log
commit 4c569ff830048206717d62544efbd288f85005e3 (HEAD -> master, test)
Author: hackerrank <me@hackerrank.com>
Date:   Mon Jun 28 22:02:25 2021 +0000

    Added commit03
    Signed-off-by: hackerrank <me@hackerrank.com>

commit cf10ff6b4ceee54c4c92ae72ba58c612d990b9cc
Author: hackerrank <me@hackerrank.com>
Date:   Mon Jun 28 22:02:04 2021 +0000

    Added commit02
    Signed-off-by: hackerrank <me@hackerrank.com>

commit 360dba467b0605ab8235954a7fcde81a5645df9f
Author: hackerrank <me@hackerrank.com>
Date:   Mon Jun 28 22:00:58 2021 +0000

    Commit01 on test
    Signed-off-by: hackerrank <me@hackerrank.com>

commit 3ca19596ebb32aa611a6625f184e37735a5f5156
Author: hackerrank <me@hackerrank.com>
Date:   Mon Jun 28 21:57:08 2021 +0000

    Adding initial files git repo
    
    - code tested
    Signed-off-by: hackerrank <me@hackerrank.com>
[70][22:06:12] ubuntu@taskserver:[/var/save/my-repo]
```

#### Verifying commits in `develop`
``` bash
git rev-list --date-order --abbrev-commit --reverse HEAD

3ca1959
360dba4
cf10ff6
4c569ff
[74][22:07:50] ubuntu@taskserver:[/var/save/repo]
```

#### Perform the merge develop --> main
``` bash
git merge develop
Updating 3ca1959..4c569ff
Fast-forward
 Hello.java | 3 +++
 1 
 file changed, 3 insertions(+)
```
#### Verifying commits in `main`
``` bash
git rev-list --date-order --abbrev-commit --reverse HEAD

3ca1959
360dba4
cf10ff6
4c569ff
```
## Git Administration/Operation
#### branch was created in the past and changes either had been added or removed in the destination branch `main | develop` 
``` bash
git fetch
git merge origin/develop
```

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

#### Git TLS Certificates
Git uses a file named ca-bundle.crt to list all the trusted certificates. We can find that file by typing the following in a terminal window:

`git config --list --show-origin`

`git config --global http.sslCAInfo`

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
#### Create a local branch for testing
``` bash
git checkout -b devops/ID-01-functionality
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

#### **Get** dimensions of Display

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

### Tool YQ for YAML processing

```bash
echo 'yq() {
  docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
}' | tee -a ~/.bashrc && source ~/.bashrc
```

# Docker Containers
`docker version` <br>
`docker volume ls` <br>
`docker system df`<br>

### List the containers of an instance and show 4 attributes in table format
``` bash
docker container ls --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"
```

#### Docker Hub Search for an app or project containing given strings

`docker search nagios`

#### Stop All Containers quietly
``` bash
docker stop $(docker ps --quiet)
```

#### List all containers that exited
`docker ps --filter "status=exited"`

#### Inspect Exitcode by container ID
`docker inspect <container-id> --format='{{.State.ExitCode}}'`

#### Clean up Everything including volumes

`docker system prune --all --force --volumes`

#### Show containers that have an exposed port then sort

`docker ps --filter expose=0-65535/tcp | sort -u -k7`

#### List labels for a given docker container [source](https://gist.github.com/steve-jansen)

``` bash
CONTAINER="ID or container name"
docker inspect --format \
    '{{ range $k, $v := .Config.Labels -}}
    {{ $k }}={{ $v }}
    {{ end -}}' $CONTAINER
```

#### Get IP of a given container

`docker inspect -f ‘{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}’ $CONTAINER_NAME_OR_ID` <br>

#### List commands used to create a given image

``` bash
MY_IMG="ubuntu"
docker history $MY_IMG | awk 'NR>1 {print $1}' | xargs docker inspect --format '{{ ((index .ContainerConfig.Cmd ) 0) }}'
```
#### Before checking issues with the app, check issues with the docker engine
``` bash
/var/log/daemon.log          = Debian distributions;
/var/log/messages            = RHEL and Oracle Linux;
journalctl -u docker.service = Ubuntu 16.04+ and CentOS 7/8
/var/log/upstart/docker.log  = for Ubuntu distributions still using upstart;
AppData/Local                = Windows operating systems;
```
#### Check logs of a container and choose a timeframe
`docker logs CONTAINER --since 15m`

#### Check logs since a given time until a given time
`docker logs CONTAINER --since 2021-06-15T00:00 --until 2021-06-15T00:10 | less`


### Docker Exit Codes
Common exit codes associated with docker containers are:
- Exit `Code 0`: Absence of an attached foreground process
- Exit `Code 1`: Indicates failure due to application error
- Exit `Code 137`: Indicates failure as container received SIGKILL (Manual intervention or ‘oom-killer’ [OUT-OF-MEMORY])
- Exit `Code 139`: Indicates failure as container received SIGSEGV
- Exit `Code 143`: Indicates failure as container received SIGTERM

#### Perform security scan on Docker file with third party Snyk
docker scan --file Dockerfile --exclude-base docker-scan:e2e

source (https://docs.docker.com/engine/scan/?utm_source=docker&utm_medium=inproductad&utm_campaign=totw-docker-scan#how-to-scan-images)
## Docker-Compose
Orchestrates docker containers.

#### Install Docker-Compose
``` bash
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
#### Start minikube if using the Microsoft hyperV
`minikube start --vm-driver=hyper`

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