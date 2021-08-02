<h1>KIWIKI</h1> <br>
<h2>Information Technology Wiki</h2> <br>

> <h4> work by @aleon1220. A Colombian adopted by Kiwis since 2016</h3>

---
- [About KIWIKI Project](#about-kiwiki-project)
  - [Repository Categories](#repository-categories)
  - [Introduction](#introduction)
  - [The Computer as a modern day to day tool](#the-computer-as-a-modern-day-to-day-tool)
  - [The CLI Shell](#the-cli-shell)
    - [CLI Shell keyboard shortcuts](#cli-shell-keyboard-shortcuts)
  - [General Info](#general-info)
  - [3. Storage](#3-storage)
    - [Process for Linux + `LVM` + `ext3`](#process-for-linux--lvm--ext3)
  - [ZFS File System](#zfs-file-system)
    - [Install ZFS on Linux](#install-zfs-on-linux)
    - [RedHat and Fedora distros](#redhat-and-fedora-distros)
    - [ZFS management](#zfs-management)
  - [`ZFS` **Pool Related Commands**](#zfs-pool-related-commands)
    - [`ZFS` File-system/Volume related commands](#zfs-file-systemvolume-related-commands)
    - [`ZFS` File-system/Volume related commands](#zfs-file-systemvolume-related-commands-1)
    - [`ZFS` Mount/Umount Related Commands](#zfs-mountumount-related-commands)
    - [`ZFS` I/O performance](#zfs-io-performance)
    - [`ZFS` maintenance commands](#zfs-maintenance-commands)
    - [`ZFS` Import/Export Commands](#zfs-importexport-commands)
    - [`ZFS` Snapshot Commands](#zfs-snapshot-commands)
    - [`ZFS` Clone Commands](#zfs-clone-commands)
    - [ZFS References](#zfs-references)
  - [General Linux Bash Commands](#general-linux-bash-commands)
  - [Systemd Systemctl](#systemd-systemctl)
  - [Compression/Decompression of files](#compressiondecompression-of-files)
  - [Find/Search operations](#findsearch-operations)
  - [Package Management](#package-management)
    - [APT](#apt)
  - [Debugging Linux Systems (mostly Ubuntu)](#debugging-linux-systems-mostly-ubuntu)
    - [Explore System Processes](#explore-system-processes)
    - [System Logs](#system-logs)
    - [Networking](#networking)
    - [Network Probing](#network-probing)
    - [Traffic capture](#traffic-capture)
    - [Network management](#network-management)
    - [Load testing](#load-testing)
    - [Benchmarking](#benchmarking)
    - [The `ip` command](#the-ip-command)
- [Terminals](#terminals)
    - [more in the Bash Section](#more-in-the-bash-section)
  - [CURL Client URL](#curl-client-url)
  - [PDF Operations Tools](#pdf-operations-tools)
    - [PDF tool kit](#pdf-tool-kit)
- [Windows products (micro\$oft)](#windows-products-microoft)
  - [Windows - & WinServer](#windows----winserver)
  - [Moved to windows/readme](#moved-to-windowsreadme)
    - [Open SSH](#open-ssh)
  - [SSH Key Management](#ssh-key-management)
    - [Key generation](#key-generation)
- [Git](#git)
    - [Git basic challenge/Demo](#git-basic-challengedemo)
  - [Git Administration/Operation](#git-administrationoperation)
    - [Git Analysis/Reporting](#git-analysisreporting)
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
    - [Tool YQ for YAML processing](#tool-yq-for-yaml-processing)
- [Docker Containers](#docker-containers)
    - [List the containers of an instance and show 4 attributes in table format](#list-the-containers-of-an-instance-and-show-4-attributes-in-table-format)
    - [Building Docker Images Dockerfile](#building-docker-images-dockerfile)
    - [Docker Exit Codes](#docker-exit-codes)
  - [Docker-Compose](#docker-compose)
- [Kubernetes K8S](#kubernetes-k8s)
  - [Kubectl commands frequently used](#kubectl-commands-frequently-used)
  - [Minikube](#minikube)
  - [Image Magick](#image-magick)
    - [Image operations with ImageMagick](#image-operations-with-imagemagick)
- [Inbox](#inbox)
---
> **END of Table of contents**
---

# About KIWIKI Project

This project is a collection of CLI reusable commands.

The wiki is going to be divided into subcategories.

## Repository Categories

1. [AWS](./aws/readme.md)
1. [Azure](./azure/readme.md)
1. devops-tools
   - Jenkins
   - Terraform
2. gradle
3. javascript
4. LDAP
5. productivity-tools
   - rescueTime
   - VsCode
6. programming-languages
7. Regular [expressions](./regex/readme.md)
8. Security
9. windows

## Introduction

- **2020-04-28=** I lost years of work on setting a nice Information Technology Wiki. I am starting a new one here

For years i have been collecting snippets on linux, solaris, C, Java, Docker, Kubernetes, etc.
I used a `.txt` file, then a google docs file. I managed to delete the google docs file from its google drive folder. I accidentally deleted the folder and later on I emptied the bin. I truly dislike that...

I got in touch with google support to no avail. :-(
I still hope I can recover my file (there was no way to recover the file)

Don't rely on the cloud 100%. Have local copies of your digital material.

- **2020-11-10=** I confirm that i lost my google docs wiki file. I should have been more careful.
- **2021-04-07=** processing inbox category. Moved intro below About Project

## The Computer as a modern day to day tool

A Computer as a tool has a CPU processor, memory RAM, storage in form of a drive, connectivity via network card or wifi, graphics visualization via a monitor. The operating system has tools to manage and interact with all the described above.

The categories are:
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

``` bash
Type a Long command, e.g. add loops or some complex parsing logic. You need more editing power so you press

                      ctrl + e + x

Editors VIM(or Nano or VI etc.) opens with your command you had typed so far already in the buffer
```
## General Info
Get quick diagnostic about a server

#### OS type, Local IP, hostname and Architecture type
``` bash
lsb_release -a ; hostname -I ; hostname ; getconf LONG_BIT
```
#### What are the services enabled and running?


#### List of software installed from [A-Z]

#### Check the hidden directories and files in the HOME dir
``` bash
todo $HOME
```

#### Check bash customizations in the current user
``` bash
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
``` bash
fdisk -l /dev/sdf
```

- check the partitions
``` bash
cat /proc/partitions
```

- Check the Block ID, Type and label of the system devices
``` bash
blkid
```

- Create partition table if needed:
``` bash
fdisk /
sfdisk
```

- Initialize for LVM use
``` bash
pvcreate /dev/sdf
```

- Add the disk (physical volume) to the LVM volume group vgextend
``` bash
myvg /dev/sdf
```

- Grow the Volume size
``` bash
lvextend -L +1024G /dev/myvg/uservol1
```

- Grow the `ext3/ext4` file system
``` bash
resize2fs /dev/myvg/uservol1`
```

- Check system info and you should see that the mounted file system now have more space.
``` bash
df -h
```

#### View your available disk devices, mount points (if applicable) to help you determine the correct device name to use
``` bash
lsblk
```

#### Get information about all of the devices attached to the instance

``` bash
sudo lsblk -f
```

#### Get manufacturer details for the device in a given format
``` bash
lsblk -io NAME,TYPE,SIZE,MOUNtPOINT,FSTYPE,MODEL
```

#### DMI table decoder
``` bash
dmidecode | grep UUID
```

#### Get/set SATA/IDE device parameters
``` bash
DEVICE="/dev/nvme1n1" hdparm -tT --direct DEVICE
```

#### Get information about a specific device, such as its file system type.  If the output shows simply data, there is no filesystem in the device

``` bash
DEVICE_CHECK="/dev/xvdf"*
sudo file -s $DEVICE_CHECK
```

##### Confirm mounted loop device kernel module
``` bash
lsmod | grep loop
```

##### Info about mount the loop device kernel module
``` bash
modprobe loop
```

#### Show ID of Block devices
```bash
sudo blkid

# Ubuntu
sudo lsblk -o +UUID
```

##### Mount an ISO file as loop device
``` bash
mount -o loop -t iso9660 <path/to/iso/file> /media/cdrom
```

#### Mount all filesystems
The file that keeps track of mounted devices is `/etc/fstab`

``` bash
sudo mount -a
```

#### Check status of important services
``` bash
timedatectl status
sudo systemctl edit --full cron.service
sudo systemctl status nginx supervisor php7.2-fpm
sudo service jenkins status
```

## ZFS File System

ZFS is a complex and yet powerful storage FileSystem

### Install [ZFS on Linux](http://download.zfsonlinux.org/epel/zfs-release.el6.noarch.rpm)

### RedHat and Fedora distros
#### Install `ZFS` Packages
``` bash
yum install kernel-devel zfs
```

### ZFS management
#### Get statistics of All
``` bash
zfs-stat -A
```

#### List `ZFS` Tanks
``` bash
zfs list | grep tank
```

#### Check if `ZFS` package is installed
``` bash
rpm -aq | grep zfs
```

``` bash
zfs version
```

``` bash
zfs list
```

``` bash
cat /proc/spl/kstat/zfs/arcstats
```

``` bash
zfs get all
```

``` bash
dmesg | grep -i zfs
```
#### Enable ZFS functions and obtain ZFS info
``` bash
sudo systemctl enable zfs-import-scan.service
zpool get cachefile fix zfs-import-cache
```

#### ZFS service not starting run the below commands
``` bash
zpool set cachefile=/etc/zfs/zpool.cache <pool>
systemctl restart zfs-import-cache.service
```

#### Make sure `ZFS` module is installed for the running Linux Kernel
``` bash
modinfo zfs
```

#### Ensure the ZFS module is running
``` bash
lsmod | grep zfs
```

## `ZFS` **Pool Related Commands**

#### Create a basic pool named `c0t0d0`
``` bash
zpool create datapool c0t0d0
```
#### Force the creation of a pool
``` bash
zpool create -f datapool c0t0d0
```
#### Create a pool with a different mount point than the default
``` bash
zpool create -m /data datapool c0t0d0
```
#### Create RAID-Z vdev pool todo_ADD references
``` bash
zpool create datapool raidz c3t0d0 c3t1d0 c3t2d0
```
#### Add RAID-Z vdev to pool datapool todo_ADD references
``` bash
zpool add datapool raidz c4t0d0 c4t1d0 c4t2d0 
```
#### Create RAID-Z1 pool todo_ADD references
``` bash
zpool create datapool raidz1 c0t0d0 c0t1d0 c0t2d0 c0t3d0 c0t4d0 c0t5d0
```
#### Create RAID-Z2 pool todo_ADD references
``` bash
zpool create datapool raidz2 c0t0d0 c0t1d0 c0t2d0 c0t3d0 c0t4d0 c0t5d0
```
#### Mirror c0t0d0 to c0t5d0
``` bash
zpool create datapool mirror c0t0d0 c0t5d0
```
#### Mirrors=Disk `c0t0d0` is mirrored with `c0t5d0` ; disk `c0t2d0` is mirrored with `c0t4d0`
``` bash
zpool create datapool mirror c0t0d0 c0t5d0 mirror c0t2d0 c0t4d0
```
#### Add new mirrored vdev to datapool
``` bash
zpool add datapool mirror c3t0d0 c3t1d0
```
#### Add spare device c1t3d0 to the datapool
``` bash
zpool add datapool spare c1t3d0
```
#### Do a dry run on pool creation
``` bash
zpool create -n geekpool c1t3d0
```
#### Show Pool Information status
``` bash
zpool status -x
```
#### Show individual pool status in verbose mode
``` bash
zpool status -v datapool
```
#### Show all the pools
``` bash
zpool list
```
#### Show particular properties of all the pools (name, size)
``` bash
zpool list -o name,size
```
#### Show all pools without headers and columns
``` bash
zpool list -Ho name
```
### `ZFS` File-system/Volume related commands

#### Create file-system fs1 under datapool
``` bash
zfs create datapool/fs1
```
#### Create 1 GB volume (Block device) in datapool
``` bash
zfs create -V 1gb datapool/vol01
```
#### Destroy datapool and all datasets under it
``` bash
zfs destroy -r datapool
```
#### Destroy file-system or volume (data) and all related snapshots
``` bash
zfs destroy -fr datapool/data
```
#### Set ZFS file system properties

#### Set quota of 1 GB on filesystem fs1
``` bash
zfs set quota=1G datapool/fs1
```

#### Set Reservation of 1 GB on filesystem `fs1`
``` bash
zfs set reservation=1G datapool/fs1
```
#### Disable ZFS auto mounting and enable mounting through config file `/etc/vfstab`
``` bash
zfs set mountpoint=legacy datapool/fs1
```
#### Share fs1 as NFS
``` bash
zfs set sharenfs=on datapool/fs1
```
#### Enable compression on `fs1`
``` bash
zfs set compression=on datapool/fs1
```
### `ZFS` File-system/Volume related commands

#### Create file-system `fs1` under datapool
``` bash
zfs create datapool/fs1
```
#### Create 1 GB volume (Block device) in datapool
``` bash
zfs create -V 1gb datapool/vol01
```
#### Destroy datapool and all datasets under it
``` bash
zfs destroy -r datapool
```
#### Destroy file-system or volume (data) and all related snapshots
``` bash
zfs destroy -fr datapool/data
```
#### List all ZFS file system
``` bash
zfs list
```
#### List all properties of a ZFS file system
``` bash
zfs get all datapool
```
### `ZFS` Mount/Umount Related Commands

#### Set the mount-point of file system fs1 to /data
``` bash
zfs set mountpoint=/data datapool/fs1
```
#### Mount fs1 file system
``` bash
zfs mount datapool/fs1
```
#### Mount with options todo_Add options explanation
``` bash
mount -t zfs /dev/xvdf /media/atl
```
#### Unmount ZFS file system fs1
``` bash
zfs umount datapool/fs1 
```
#### Mount all ZFS file systems
``` bash
zfs mount -a

# Direct binary
/sbin/zfs mount -a
```

#### Mount all with arguments
``` bash
zfs mount -O -a
```

#### Umount all ZFS file systems
``` bash
zfs umount -a
```
### `ZFS` I/O performance

#### Display ZFS I/O Statistics every 2 seconds
``` bash
zpool iostat 2
```
#### Display detailed ZFS I/O statistics every 2 seconds
``` bash
zpool iostat -v 2
```
### `ZFS` maintenance commands

#### Run scrub on all file systems under data pool
``` bash
zpool scrub datapool
```
#### Temporarily offline a disk (until next reboot)
``` bash
zpool offline -t datapool c0t0d0
```
#### Online a disk to clear error count
``` bash
zpool online
```
#### Clear error count without a need to the disk
``` bash
zpool clear
```
### `ZFS` Import/Export Commands

#### List pools available for import
``` bash
zpool import
```
#### Imports all pools found in the search directories
``` bash
zpool import -a
```
#### Search for pools with block devices not located in `/dev/dsk`
``` bash
zpool import -d
```
#### Search for a pool with block devices created in `/zfs`
``` bash
zpool import -d /zfs datapool
```
#### Import a pool originally named oldpool under new name newpool
``` bash
zpool import oldpool newpool
```
#### Import pool using `pool_ID`
``` bash
zpool import 3987837483
```
#### Deport a ZFS pool named mypool
``` bash
zpool export datapool
```
#### Force the unmount and deport of a ZFS pool
``` bash
zpool export -f datapool
```
### `ZFS` Snapshot Commands

#### Create a snapshot named 12jan2014 of the fs1 filesystem
``` bash
zfs snapshot datapool/fs1@12jan2014
```
#### List snapshots
``` bash
zfs list -t snapshot
```
#### Roll back to Jan 10 2020 (recursively destroy intermediate snapshots)
``` bash
zfs rollback -r datapool/fs1@10jan2020
```
#### Roll back: force unmount and remount
``` bash
zfs rollback -rf datapool/fs1@10jan2020
```
#### Destroy snapshot created earlier
``` bash
zfs destroy datapool/fs1@10jan2020
```
#### Take a backup of ZFS snapshot locally
``` bash
zfs send datapool/fs1@oct2019 &gt /geekpool/fs1/oct2019.bak
```
#### Restore from the snapshot backup backup taken
``` bash
zfs receive anotherpool/fs1 &lt /geekpool/fs1/oct2013.bak
```
#### Combine the `send` and `receive` operation
``` bash
zfs send datapool/fs1@oct2019 | zfs receive anotherpool/fs1
```
#### Send the snapshot to a remote system `node02`
``` bash
zfs send datapool/fs1@oct2019 | ssh node02 “zfs receive testpool/testfs”
```
### `ZFS` Clone Commands

#### Clone an existing snapshot
``` bash
zfs clone datapool/fs1@10jan2014 /clones/fs1
```
#### Destroy clone
``` bash
zfs destroy datapool/fs1@10jan2020
```

### ZFS References
- [Solaris ZFS command line reference (Cheat sheet)](https://www.thegeekdiary.com/solaris-zfs-command-line-reference-cheat-sheet/)
- [Solaris ZFS : How to replace a failed disk in rpool (x86)](https://www.thegeekdiary.com/solaris-zfs-how-to-replace-a-failed-disk-in-rpool-x86/)
- [Solaris ZFS : How to Offline / Online / Detach / Replace device in a storage pool](https://www.thegeekdiary.com/solaris-zfs-how-to-offline-online-detach-replace-device-in-a-storage-pool/)
- [How to Backup and Restore ZFS root pool in Solaris 10](https://www.thegeekdiary.com/how-to-backup-and-restore-zfs-root-pool-in-solaris-10/)
- [Solaris ZFS : How to Create / Rename / Rollback / Destroy a ZFS Snapshot](https://www.thegeekdiary.com/solaris-zfs-how-to-create-rename-rollback-destroy-a-zfs-snapshot/)
- [How to replace a disk under ZFS in Solaris](https://www.thegeekdiary.com/how-to-replace-a-disk-under-zfs-in-solaris/)
- [Solaris ZFS : How to Create and Manage Mirrored Storage Pools](https://www.thegeekdiary.com/solaris-zfs-how-to-create-and-manage-mirrored-storage-pools/)
- [How To Increase rpool Size On Solaris 11 (Requires a Reboot)](https://www.thegeekdiary.com/how-to-increase-rpool-size-on-solaris-11-requires-a-reboot/)
- [How to Configure iSCSI targets on Solaris 10](https://www.thegeekdiary.com/how-to-configure-iscsi-targets-on-a-solaris-10)
- [How To Use ‘zpool split’ to Split rpool in solaris 11 (x86/x64)](https://www.thegeekdiary.com/how-to-use-zpool-split-to-split-rpool-in-solaris-11-x86x64/)
- [How to mount the zfs rpool while booted from CD SPARC](https://www.thegeekdiary.com/how-to-mount-the-zfs-rpool-while-booted-from-cd-sparc/)


## General Linux Bash Commands

#### Get info about linux version


``` bash
cat /etc/os-release
```
#### get pretty print version


``` bash
less /etc/issue
```
#### Debian/ubuntu get version

``` bash
lsb_release -a
hostnamectl
```

##### Info about system
``` bash
uname -a
```
## Systemd Systemctl

#### Check status of a Service
``` bash
systemctl status APP_SERVICE

# system control status nginx
systemctl status nginx
```
#### Check if service is Active
``` bash
systemctl is-active nginx
```
#### List all loaded service units
``` bash
systemctl list-units -all | grep loaded | awk '{print $1;}'
```
#### List all enabled units
``` bash
systemctl list-unit-files| grep enabled | awk '{print $1;}' > enabled.txt
```


#### List all loaded services
Make sure that all the services we use are in the startup script

``` bash
systemctl list-units -all | grep service | grep loaded | awk '{print $1;}'
```
#### List all enabled services
``` bash
systemctl list-unit-files | grep service | grep enabled | awk '{print $1;}' > enabled.txt
```
#### Find the list of services that are loaded but not enabled

``` bash
systemctl list-units -all | grep service | grep loaded | awk '{print $1;}' > loaded.txt

systemctl list-unit-files | grep service | grep enabled | awk '{print $1;}' > enabled.txt

# Diff the files
diff -y loaded.txt enabled.txt
```

#### Diff the missing services. Quick glance of missing
``` bash
diff -y loaded.txt enabled.txt | grep '<'
```

#### `pushd` and `popd` to jump between directories
``` bash
pushd $DIR
popd
```

#### Analyse Logs. Logs named 3 to 31.gz month. Month like Feb 2020 and print

``` bash
zcat access.log.{3..31}.gz | grep -E 'Feb/2020' | awk '{print $1}' | sort -u | less
```

#### Xclip to capture the clipboard when copying
``` bash
cat ~/.ssh/id_rsa.pub | xclip -sel clip
```

``` bash
xclip
```

#### X windows var
``` bash
echo $XDG_CURRENT_DESKTOP
```

#### Check a dir with a parameter. Double check `info stat`
``` bash
stat %A $DIR
```

#### nohup execution

`nohup` runs the given COMMAND with hangup signals ignored, so that the command can continue running in the background after you log out.


``` bash
nohup $COMMAND_OR_SCRIPT > out_$(date).txt
```

#### Echo a string an pipe it to a command

In this case the content of a `DockerFile` is echoed first then piped to `docker build` to create a docker image.

``` bash
echo -e 'FROM busybox\nRUN echo "hello world"' | docker build -
docker build -<<EOF
FROM busybox
RUN echo "hello world"
EOF
```

##### Maintain symbolic links determining default commands. Show installed Apps

``` bash
update-alternatives --get-selections
```

##### Get info about current user
``` bash
id
```

##### Edit sudo users
``` bash
sudo visudo
```

##### Move `DIR1` to `DIRDestiny`
``` bash
sudo mv $DIR1 $DIRDestiny
```

##### Find where the command is installed

``` bash
which COMMAND

which pip
```

##### Create an alias with a command to go to a specific directory
``` bash
alias ee='cd /home/ws/02-projects/ee/test-env/eenz' <br>

ee
```

#### Copy files from Local to Remote Server
Define the local and remote paths in env vars. Perform the copy

``` bash
scp -r $LOCAL_PATH/sftp-shim ubuntu@$REMOTE_HOST_SERVER:$REMOTE_SERVER_PATH
echo "cd $PWD"
```

## Compression/Decompression of files

#### With Tar
``` bash
tar -czvf name-of-archive.tar.gz /path/to/directory-or-file
```

#### With Zip

``` bash
zip -r compressedFileName.zip file1 file2 dir1/ file3
```
#### Create a parent directory with 2 directories inside (Single line)
``` bash
mkdir -p $HOME/example.com/server1/{httpd,dnsqmasq}
```
## Find/Search operations

#### Find files containing specific text
``` bash
grep -iRl "TEXT-TO-FIND" ./
```
##### Common Flags for `grep`

``` bash
-i - ignore text case
-R - recursively search files in subdirectories.
-l - show file names instead of file contents portions.
```

`./` As the last parameter, the path to the folder containing files you want to search for text.

You can use the full path of the folder.
``` bash
grep -iRl "TEXT" /home/user/Documents
```

#### Find the value of `THING_NAME` and replaces the value in a given config file
``` bash
THING_NAME=< enter bucket Name >
sed -i -r "s/^THING_NAME=.*/THING_NAME=$THING_NAME/" /home/ubuntu/sftp-shim.config
```

#### Searches for ???? in the current directory
``` bash
grep -Eri health_url .
```
#### Find directories modified within the past 10 days
``` bash
find . -maxdepth 1 -type d -mtime -10  -printf '%f\n'
```

#### It should find the HTTPD user in a web server. 
`ps` command behaves weirdly

``` bash
HTTPDUSER=$(ps axo "user,comm" | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1)
```
## Package Management

### APT

ubuntu package manager

#### Fetch packages from Repo
``` bash
sudo apt update
```
#### Auto remove Obsolete packages
``` bash
sudo apt autoremove
```
#### Upgrade packages
``` bash
sudo apt upgrade --yes
```
#### List a package by name. e.g. python
``` bash
sudo apt list | grep python
```
#### List installed packages
``` bash
sudo apt list --installed
```
#### Fix broken install packages
``` bash
sudo apt --fix-broken install
```
#### Purge a package
``` bash
sudo apt-get purge unattended-upgrades
```
#### Install a Debian Package
``` bash
sudo dpkg -i $DEBIAN_PKG
```
#### Check if Periodic updates are enabled
``` bash
cat /etc/apt/apt.conf.d/10periodic
```
#### Get packages from repo and find given string
``` bash
dpkg --get-selections | grep PACKAGE_TO_FIND
```
#### list snap packages installed
``` bash
snap list
```
## Debugging Linux Systems (mostly Ubuntu)

A very important set of skills when something goes wrong and is important to get quick info.
This can become a small DIY project to manage desktop and cloud servers.


``` bash
ls -lth /var/log/ | sort --month-sort
```

#### Check the system log
``` bash
less /var/log/syslog
```

#### Create empty file in given path
``` bash
touch /home/user/new_empty_file.txt
```

``` bash
less /etc/X11/xorg.conf
```

#### List directory with extensions
``` bash
ls -xl ${DIR_PATH}
```

- Article [medium.com Troubleshooting](https://medium.com/better-programming/5-powerful-unix-commands-for-easier-troubleshooting-dd619d5e173a)

#### lists all open files belonging to all active processes
``` bash
lsof
```

#### lists open files for current user
``` bash
lsof -u $USER
```

#### End all processes for a target user
``` bash
kill -9 $(lsof -t -u $TARGET_USER)
```

#### Retrieve processes running on a specified range
``` bash
lsof -i :8090-9090
```

### Explore System Processes

#### Find the process that consumes more CPU
``` bash
ps -eo pid,%cpu,%mem,args --sort -%cpu
```

#### Sort processes by memory
``` bash
ps aux --sort=-%mem
```

#### Unuseful view with a process tree
``` bash
ps xfa | less
```

#### Read from a file in a specific line e.g. 4
``` bash
less +4 -N show-time.sh
```

### System Logs

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
``` bash
sudo journalctl
```
#### Check system logs
``` bash
journalctl -xe
```
#### Obtain Log output from oldest to newest
``` bash
journalctl -r
```
#### Monitor New Log Messages
``` bash
journalctl -f
```
#### Show Logs within a Time Range
``` bash
journalctl --since "2018-08-30 14:10:10"
journalctl --until "2018-09-02 12:05:50"
```

#### List boots in the System
``` bash
journalctl --list-boots
```

#### Show Logs for a Specific Boot
``` bash
journalctl -b
```

#### Show Logs for a systemd Service
``` bash
journalctl -u $SERVICE_NAME
```
#### View Kernel Messages
``` bash
journalctl -k
```
#### change Output Format to json-pretty
``` bash
journalctl -o json-pretty
```
#### Manually Clean Up Archived Logs

#### Reduce the size of your journals to 2GiB
``` bash
journalctl --vacuum-size=2G
```
#### Remove archived journal files with dates older than the specified relative time
``` bash
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
``` bash
nmap -sS localhost
```
#### Sends ICMP pings. checks latency
``` bash
ping/ping6
```
#### Test port 80 netcat

``` bash
nc -lvz 80
```

`telnet` a complete protocol
``` bash
tcdump -i eth0 icmp
```

#### Examine the IPv4 TCP-based sockets that are listening for connections on your system
``` bash
ss -4 -tln
```

#### Examine the IPv6 TCP-based sockets that are listening for connections on your system
``` bash
ss -6 -tln
```

#### Creating Unix Domain Sockets
``` bash
socat unix-listen:/tmp/stream.sock,fork /dev/null&
socat unix-recvfrom:/tmp/datagram.sock,fork /dev/null&
```

#### examine unix domain sockets
``` bash
ss -xln
```
#### Connect to an UNIX Socket
``` bash
nc -U -z /tmp/stream.sock
```

- The `-U` tells netcat that it is connecting to a Unix Domain Socket
- The `-z` option ensures that netcat only connects to a socket, without sending any data
- The `/tmp/stream.sock` is the address of the socket on the filesystem

#### Simulate traffic in IPV4 and IPV6

``` bash
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

#### Check arp cache

``` bash
arp -a
```

`ip` see neighbor table. add routes

- Answers questions
what are the net interfaces, ips, subnets, broadcast address??
how do i add routes?

### Load testing

`tcpreplay` replays traffic from packet capture fire

``` bash
tcpdump -i eth0 -w traffic.pcap
tcpreplay -i eth0 httptraffic.pcap
```

`wrk2` Send Http load

Threads connections duration Requests

``` bash
wrk2 -t1 -c10 -d60 -R100 -L http://$IP
```

#### Send TCP or UDP traffic. Similar to wrk2 but allows UDP
``` bash
iperf3
```

#### ????
``` bash
nuttcp
```
### Benchmarking

`siege`
``` bash

```
BPF/eBPF potentical for new programs

**source:** Digital ocean talk Handy Linux networking tools

#### Flush DNS by resetting the network DEBIAN based
``` bash
sudo /etc/init.d/networking restart
```
#### Inspect TCP socket states e.g. 443
``` bash
ss -nta '( dport = :443 )'
```

`netstat` is a great tool for monitoring network connections.

#### Netstat statistics
``` bash
netstat --statistics
```
#### Find ports in use
``` bash
netstat -tulpn
```

- The `-t` option checks for TCP connections.
- The `-u` option checks for UDP connections.
- The `-l` option tells netstat to list only LISTENING connections. If you want to see all connections, use the -a option instead.
- The `-p` option shows the PID id of the process.
- The `-n` option shows numerical addresses, instead of trying to resolve host, port, or user names.

#### Make sure the `firewalld` service is enabled
``` bash
ll /usr/lib/systemd/system | grep firewalld

ll /etc/systemd/system | grep firewalld
systemctl status firewalld

sudo systemctl enable firewalld
sudo systemctl restart firewalld
sudo systemctl status firewalld
```

#### Install netcat in Fedora/Redhat
``` bash
yum install -y nc
```
#### CentOS Linux Open Port 8080 on the firewall
``` bash
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
```

#### Find user behind a process
``` bash
sudo netstat -tulpe | grep 8090
```
#### Test connectivity to a port

`nc -vvz $host $port` <br>
``` bash

```
#### Check server status

`sudo netstat -tuple | grep smtp`
``` bash

```
#### Check Any URL and get output in Text

`curl -l localhost:80` <br>
``` bash

```
#### Get listening ports

`ss -tulwn`
``` bash

```
#### Get a report with nmap. install it first `sudo snap install nmap`

`nmap -sV -p- localhost`
``` bash

```
### The `ip` command

- Show / manipulate routing
`ip route show`
``` bash

```
`ip route list`
``` bash

```
- Show / manipulate devices
`cat /etc/network/interfaces`
``` bash

```
- Policy routing
- Tunnels

#### Restart Name Service Cache Process

`sudo service nscd restart`
``` bash

```

#### Create a Symbolic Link

``` bash
SOURCE_FILE=/home/ubuntu/.local/bin/docker-compose
SYMBOLIC_LINK_PATH=/usr/bin/docker-compose
sudo ln --symbolic $SOURCE_FILE $SYMBOLIC_LINK_PATH
```

##### Check Timestamp for last updated packages in package manager apt

`ls -l /var/lib/apt/periodic/update-stamp`<br>
``` bash

```

##### History of commands executed in the current session

`history` <br>
``` bash

```

##### Create a random password

``` bash
randompass=$(dd status=none bs=24 count=1 if=/dev/urandom | \
base64 | tr /= _)
```

##### Get stats info about a file

`stat --help`
``` bash

```
`stat $FILE`
``` bash

```

#### get text between quotes in a text file. Options

``` bash
echo Source_File.txt | grep $REGEX_PATTERN
grep "'.*'" -o references-get-between-quoutes.txt > result_1855.txt

PATTERN='".*"'
grep -o $PATTERN raw_file.txt > result_file_$(date)_.txt
```

##### Interactive process viewer

`htop`
``` bash

```

#### Check Disk Usage

`df -h`<br>
``` bash

```
##### See who is connected and Display the load average (uptime output)

`w -u`
``` bash

```
##### Get the user login history

`last $USERNAME`
``` bash

```
##### print the user name who are all currently logged in the current host

`users`
``` bash

```
#### List Users in Linux

``` bash
less /etc/passwd
```

##### Info in `/etc/passwd`

``` bash

```

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

``` bash
getent passwd
getent passwd | cut -d: -f1
```

#### Set a new password Root

```bash
sudo passwd $USERNAME
```

#### Set a new password Your own

`passwd`
``` bash

```
#### To check the UID_MIN and UID_MIN values on your system, you can use the following command

``` bash
grep -E '^UID_MIN|^UID_MAX' /etc/login.defs
```

#### The command below will list all normal users in our Linux system

``` bash
getent passwd {1000..60000}
```

#### generic version of command above

``` bash
eval getent passwd {$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)..$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)}
```

#### Print only the usernames

``` bash
eval getent passwd {$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)..$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)} | cut -d: -f1
```

##### print the loggedin user name

`id -un`
``` bash

```
##### get the list of the usernames who are currently logged in

`who`
``` bash

```
##### get a list of all usernames that are currently logged

`who | cut -d' ' -f1 | sort | uniq`
``` bash

```
##### Launch file explorer Nautilus as super user admin

`sudo nautilus`
``` bash

```
##### Scan full disk and analyze it

`sudo ncdu /`
``` bash

```
##### Remove directory

`rm -rf $DIR_PATH`
``` bash

```
#### Search for execution of a command in the history

`COMMAND=who ; history | grep $COMMAND`
``` bash

```
#### set max map count

`sudo sysctl -w vm.max_map_count=262144`
``` bash

```
##### Show contents in tree view

`tree ~`
``` bash

```
#### If using GIO Gnome Input/Output

`gio tree`
``` bash

```
# Terminals

### more in the [Bash Section](/devops-tools/bash)

#### most used commands in Bash History

``` bash
history | \
awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count\*100 "% " a;}' | \
grep -v "./" | column -c3 -s " " -t | \
sort -nr | nl | head -n10
```

#### Script to list files, directories, executables, and links from a given Workspace directory

#### with `find`

`find . -maxdepth 1 -type f -print`
``` bash

```
#### Script usage= `lsf` lists files, `lsd` lists directories, `lsx` lists executables, `lsl` lists links

#### start a process in the background

`COMMAND="rescuetime"`
`$COMMAND &`
``` bash

```

#### Create a testing version with the date. No space in generated date

`APP_VERSION="vtest-"$(date +%F_%H%M)`<br>
``` bash

```
#### Create a file with content in a given path

`FILE_PATH=/home/ubuntu/.bash_functions`
``` bash

```
#### Create a dir and run a command in 1 line

`cd $DIR1; $(COMMAND)`
``` bash

```
#### Create a file and add content to it

``` bash
sudo bash -c "cat > $FILE_PATH"<<EOF
Lots of content and text
foo
bar
EOF
```

#### Create a function to show files in current dir

``` bash
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
``` bash

```
##### Change permissions of a file based on permissions of other file

`RFILE=reference_file ; sudo chmod --reference=\$RFILE`
``` bash

```
##### Change ownership of all files inside current dir to a given group

`GROUP_NAME=common ; sudo chown :\$GROUP_NAME \*`
``` bash

```
## CURL Client URL

#### Download a file and save it with a custom name

`curl -o custom_file.tar.gz https://testdomain.com/testfile.tar.gz`
``` bash

```
#### Get HTTP headers. use the `-I` or the `— head` option

`curl -I https://www.google.com`
``` bash

```
#### Ignore invalid certs `-k or --insecure`

`curl -k https://localhost/my_test_endpoint`
``` bash

```
#### Make a POST request. JSON `-H 'Content-Type: application/json'`

`curl --data "param1=test1&param2=test2" http://test.com`
``` bash

```
#### get the HTTP headers and verbose mode

`curl --head --verbose HOST`
``` bash

```
#### simplified view

curl --list-only $HOST
``` bash

```
#### Specify the type of request

``` bash
# updating the value of param2 to be test 3 on the record id
curl -X 'PUT' -d '{"param1":"test1","param2":"test3"}' \http://test.com/1
```

#### Include the Basic Auth

`curl -u <user:password> https://my-test-api.com/endpoint1`
``` bash

```
#### Update name resolution

`curl --resolve www.test.com:80:localhost http://www.test.com/`
``` bash

```
#### Check service health

`curl -Is http://www.google.com`
``` bash

```
#### Upload a file

`curl -F @field_name=@path/to/local_file <upload_URL>`
``` bash

```
#### Timing Curl connection

`curl -w "%{time_total}\n" -o /dev/null -s www.test.com`
``` bash

```
## PDF Operations Tools

### PDF tool kit

##### Recursively find inside pdfs

`find . -iname '*.pdf' -exec pdfgrep "Title of File to search " {} +` <br>
``` bash

```
`pdfgrep -r "Title of PDF to find"` <br>
``` bash

```
#### Get info about the pdf toolkit

`info pdftk` <br>
``` bash

```
#### Get info about PDF_FILE

`pdftk $PDF_FILE.pdf dump_data_utf8 | grep InfoValue:`<br>
``` bash

```
#### extract a range of pages from a pdf file

`pdftk source.pdf cat 5-10 output ExtractedOutput_p5-10.pdf`
``` bash

```
#### split specific pages from the source file, for example page 5, page 6, and page 10

`pdftk source.pdf cat 5 6 10 output SplittedOutput.pdf`
``` bash

```
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
``` bash

```
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
``` bash

```
#### Delete remote branch (short form `:`)

`git push <remote> :<branch>`
``` bash

```

`git push origin :my-awesome-feature`
``` bash

```
#### Remove remote branches that were deleted (merged) on BitBucket

``` bash
git config fetch.prune true 
```

#### Change remote URL if you change your repository’s name

`git remote set-url <remote> <newurl>`
``` bash

```
`git remote set-url origin github.com/myusername/my-repo`
``` bash

```
##### Stash Individual Files

`git stash push -- <filepath(s)>`
``` bash

```
- Example:

`git stash push -- src/index.js README.md`
``` bash

```
##### Show Content of Most Recent Stash

`git stash show -p [stash@{<n>}]`
``` bash

```
**Explanation:**

`-p` to see the actual content of the stash. Omitting it will show only the file names.

`stash@{<n>}` allows us to specify a certain stash, denoted by `n` ( 0 being the most recent one ).

`git stash show -p stash@{1}`

#### Check Out File From Another Branch

`git checkout <branch> -- <path(s)>`
``` bash

```
`git checkout another-branch src/file.js`
``` bash

```
#### Working with 2 branches

`git worktree add <path> <branch>`
``` bash

```
- when you no longer need the branch:
`git worktree remove [-f] <path>`
``` bash

```

**Example:**

1. `git worktree add my-other-awesome-feature ../my-other-awesome-feature`
1. `git worktree remove ../my-other-awesome-feature`

**Explanation:** Creates a linked working tree (i.e., another directory on the file system associated with the repo) called `my-other-awesome-feature`, one level above your current working directory, with the specified branch checked out.

#### Show Commit Content shows changes introduced by a commit

`git show COMMIT`
``` bash

```
Alternatively, to see the changes between two specific commits run

`git diff COMMIT_A COMMIT_B`
``` bash

```
`git diff HEAD~ HEAD`
``` bash

```
#### Compare Files Between Branches/Commits

`git diff <commit-a> <commit-b> -- <path(s)>`
``` bash

```
`git diff 0659bdc e6c7c0d -- src/flair.py`
``` bash

```
#### Reset a Single File to Most Recent Commit

`git checkout [<commit>] -- <path(s)>`
``` bash

```
`git checkout -- README.md`
``` bash

```
#### Change Last Commit Message

`git commit --amend [-m '<message>']`
``` bash

```
If the old commit had already been pushed, you’ll need to additionally run

`git push --force-with-lease <remote> <branch>`
``` bash

```
**Note:** As a general rule, and especially if you’re working with others, it’s important to be careful when making any changes to already pushed commits.

#### Change a Specific Commit Message

`git rebase -i COMMIT`
``` bash

```
`git rebase -i HEAD~3`
``` bash

```
#### Delete Last Commit but Keep the Changes

`git reset HEAD^`
``` bash

```
#### Unstage a File

`git reset HEAD <path>`
``` bash

```
#### Remove Ignored Files From Remote

later decided to `.gitignore` them, the files will nevertheless persist in your remote repository. To remedy this

`git rm`
``` bash

```
is the tool for the job.

`git rm [-r] [-n] --cached <path(s)>`
``` bash

```
Then, simply add, commit, and push

#### Hard reset of branch

`git reset --hard`
``` bash

```
#### show GPG signatures used in a repo

`git log --show-signature`
``` bash

```
#### Find local GIT repos

`sudo find -name HEAD -execdir test -e refs -a -e objects -a -e config \; -printf %h\\n`
``` bash

```
<br>

#### Get help with any git command

`git init --help`
``` bash

```
`git COMMAND --help`
``` bash

```
#### Clone a Git Repo

`git clone git@github.com:elastic/stack-docker.git`
``` bash

```
`git status`
``` bash

```
`git branch`
``` bash

```
`git info`
``` bash

```

#### Basic Git config set up

``` bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

#### Git TLS Certificates

Git uses a file named ca-bundle.crt to list all the trusted certificates. We can find that file by typing the following in a terminal window:

`git config --list --show-origin`
``` bash

```
`git config --global http.sslCAInfo`
``` bash

```
#### Instruct Git to use GPG2 instead of GPG as the signing program

`git config --global gpg.program gpg2`
``` bash

```
#### Test by signing some text with `gpg` and `gpg2`

`echo "test" | gpg2 --clearsign`
``` bash

```
#### Set variable for GPG and terminal usage

`export GPG_TTY=$(tty)`
``` bash

```
### Git Analysis/Reporting

#### Get git global info

`git config --global --list`
``` bash

```
#### List all remote branches

`git branch -r`
``` bash

```
#### List remote active branches

`git ls-remote --heads origin`
``` bash

```
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
``` bash

```
#### Prints out just the subject line

`git log --oneline`
``` bash

```
#### Groups commits by user, again showing just the subject line for concision

`git shortlog`
``` bash

```
#### Switch to previous branch

`git checkout -`
``` bash

```
#### Add small patches to a commit

`git add -p`
``` bash

```
#### Find the last working commit by basically using binary search

``` bash
git bisect start

# for a commit that you know is working correctly
git bisect good

# for a commit that you know is NOT working correctly
git bisect bad
```

#### Ammend a commit

``` bash
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

#### Run a query to obtain Project User name, User key, Repo name and Repo Slug
``` sql
SELECT 
       prj.name AS "Project / User Name"
     , prj.project_key AS "Project / User Key"
     , rep.name AS "Repository Name"
     , rep.slug AS "Repository Slug"
FROM repository rep 
INNER JOIN project prj ON rep.project_id = prj.id
ORDER BY prj.name, rep.name
```
- [Bitbucket Knowlege Base](https://confluence.atlassian.com/bitbucketserverkb/how-to-obtain-a-list-of-all-projects-and-repositories-from-bitbucket-database-975027747.html)
- Get detailed info
`git remote --verbose`
``` bash

```
- get extra info about remote

`git remote show origin`
``` bash

```
- Update the remote URL with git remote set-url using the current and new remote URLs.
`git remote set-url origin git@bitbucket.org:tutorials/tutorials.git`
``` bash

```
#### see the list of git stashes

`git stash list`
``` bash

```
#### reset the current HEAD or changes of your local branch to a specific state

`git reset [FILE_PATH]`
``` bash

```
# Programming Languages

## Java

- todo add short details description
- todo add main links

### OpenJDK

##### update-alternative set version for Java

update-alternatives --config java
``` bash

```
### Oracle Java

## Python

# DataBases

## MariaDB (MySQL open source Fork)

## Oracle MySQL

#### Connect to DB with mysql command utilities

``` bash
HOST="localhost"; USER="mysql"
mysql -h $HOST -u $USER -p
```

#### Check the default character set for a particular database DB_NAME

``` SQL
SELECT SCHEMA_NAME, DEFAULT_CHARACTER_SET_NAME
       FROM INFORMATION_SCHEMA.SCHEMATA
       WHERE SCHEMA_NAME='DB_NAME';
```

## AWS RDS MySQL engine

## PostgreSQL

#### Check this super [PostgreSQL Cheat sheet](https://www.postgresqltutorial.com/postgresql-cheat-sheet/)

#### Access the PostgreSQL server from psql with a specific user

`psql -U [username]`
``` bash

```
> Once in the console:

#### Check version

`SELECT version();`
``` bash

```
#### dump DB and create the DB in the script
``` bash
pg_dump -U postgres -W -C -d example_backups > ~/db_backup.sql
```
#### back up my entire PostgreSQL cluster and save it in the entire_cluster.sql file

`pg_dumpall -U postgres -W -f ~/Example_Dumps/Cluster_Dumps/entire_cluster.sql`
``` bash

```
> avoid system asking for too many pass by using ~/`.pgpass file.`

syntax
`hostname:port:database:username:password`

## Microsoft SQL Server

# Operating Systems

## Linux Ubuntu

### System settings

#### **Get** dimensions of Display

`xdpyinfo | grep dim`
``` bash

```
### Nautilus operations

#### Show hidden files Keyboard shortcut

`CTRL + H`
``` bash

```
#### Show Path Location Keyboard shortcut

`CTRL + L`
``` bash

```
#### Switch between the Icons and List formats

`CTRL + 1 | CTRL + 2`
``` bash

```
#### Search for files

`CTRL + F`
``` bash

```
#### Delete File(s)
``` bash
CTRL + delete
```
#### Permanently delete
``` bash
Shift + Delete
```
(You should never delete your Home directory, as doing so will most likely erase all your GNOME configuration files and possibly prevent you from logging in. Many personal system and program configurations are stored under your home directory.)

### Tool YQ for YAML processing

``` bash
echo 'yq() {
  docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
}' | tee -a ~/.bashrc && source ~/.bashrc
```

# Docker Containers
``` bash
docker version
```
#### List Docker volumes
``` bash
docker volume ls
```
#### Check Docker system disk usage
``` bash
docker system df
```

### List the containers of an instance and show 4 attributes in table format

``` bash
docker container ls --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"
```

#### Docker Hub Search for an app or project containing given strings
``` bash
docker search IMAGE_TO_SEARCH
```

#### Example of setting credentials for another Docker registry e.g. [Artifactory.com](https://www.jfrog.com/confluence/display/JFROG/Using+Docker+V1#UsingDockerV1-3.SettingUpAuthentication)
``` bash
vim ~/.docker/config.json
```

#### Modify the `config.json` settings
``` json
{
    "auths" :{
        "https://artprod.company.com" : {
            "auth": "<USERNAME>:<PASSWORD> (converted to base 64)",
                "email": "youremail@email.com"
        },
        "https://artdev.company.com" : {
            "auth": "<USERNAME>:<PASSWORD> (converted to base 64)",
                "email": "youremail@email.com"
        }
    }
}
```

### Building Docker Images Dockerfile
#### Use docker cache busting
Install latest version of a package in 1 layer
``` bash
RUN apt-get update && apt-get install -y \
    nginx \
    vim
```

#### Use docker cache busting and version pinning and clean up the `apt` cache 
Gets specific package version with the latest minor releases

`apt cache` is not stored in a layer so you obtain a smalley docker image size

``` bash
RUN apt-get update && apt-get install -y \
    package-bar=2.5.* \
    package-baz=5.0.* \
    package-foo=1.3.* \
&& rm -rf /var/lib/apt/lists/*
```
#### Stop All Containers quietly

``` bash
docker stop $(docker ps --quiet)
```

#### Copy a file from host machine path to Docker container path
``` bash
FILE_HOST_PATH="/home/ubuntu/InternalCertificate.crt"
CONTAINER_PATH="/var/atlassian/application-data/bitbucket/"
CONTAINER_NAME="my-docker-container"
docker cp $FILE_HOST_PATH $CONTAINER_NAME:$CONTAINER_PATH
```

#### Examples of running docker containers
``` bash
docker run --restart always --name train-schedule -p 8080:8080 --detach aleon1220/train-schedule:9 node app.js

docker run --name some-nginx -d -p 9080:80
```

#### List all containers that exited
``` bash
docker ps --filter "status=exited"
```


#### Inspect Exitcode by container ID
``` bash
docker inspect <container-id> --format='{{.State.ExitCode}}'
```

#### Clean up Everything including volumes
``` bash
docker system prune --all --force --volumes
```

#### Show containers that have an exposed port then sort

`docker ps --filter expose=0-65535/tcp | sort -u -k7`
``` bash

```
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
``` bash

```
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
``` bash

```
#### Check logs since a given time until a given time

`docker logs CONTAINER --since 2021-06-15T00:00 --until 2021-06-15T00:10 | less`
``` bash

```
### Docker Exit Codes

Common exit codes associated with docker containers are:

- Exit `Code 0`: Absence of an attached foreground process
- Exit `Code 1`: Indicates failure due to application error
- Exit `Code 137`: Indicates failure as container received SIGKILL (Manual intervention or ‘oom-killer’ [OUT-OF-MEMORY])
- Exit `Code 139`: Indicates failure as container received SIGSEGV
- Exit `Code 143`: Indicates failure as container received SIGTERM

#### Perform security scan on Docker file with third party Snyk

docker scan --file Dockerfile --exclude-base docker-scan:e2e
``` bash

```
source (<https://docs.docker.com/engine/scan/?utm_source=docker&utm_medium=inproductad&utm_campaign=totw-docker-scan#how-to-scan-images>)

## Docker-Compose

Orchestrates docker containers.

#### Install Docker-Compose

``` bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

##### Get docker compose version

`docker-compose version` <br>
``` bash

```
##### Validate docker compose configuration

##### Validate config and Build docker-compose stack

`docker-compose config` <br>
``` bash

```
`docker-compose build` <br>
``` bash

```
##### Execute a docker-compose with verbosity

`docker-compose --verbose up --detach` <br>
``` bash

```
`docker-compose images` <br>
``` bash

```
`docker-compose -f setup.yml up --remove-orphans` <br>
``` bash

```
`docker-compose --verbose top` <br>
``` bash

```
`docker-compose --verbose ps` <br>
``` bash

```
`docker-compose --verbose stats` <br>
``` bash

```

``` bash
DOCKER_COMPOSE_FILE=/opt/docker-compose.yaml
SERVICE_NAME="NameInsideDockerCompose"
```

#### Check status of the docker-compose stack
``` bash
docker-compose -f $DOCKER_COMPOSE_FILE ps
```
#### Check logs

`docker-compose -f $DOCKER_COMPOSE_FILE logs`
``` bash

```
#### tail/get  log in format log-yyy-mm-dd. The log lives in a special path in the container. Piped to `less`

`docker-compose -f $DOCKER_COMPOSE_FILE exec SERVICE_NAME cat "logs/log-$(env TZ="NZT" date +%Y-%m-%d).php" | less`
``` bash

```
#### pipe contents of a supervisord.log to `less` from within the container to the host shell

`docker-compose -f $DOCKER_COMPOSE_FILE exec SERVICE_NAME cat "logs/supervisord.log" | less`
``` bash

```
# Kubernetes K8S

## Kubectl commands frequently used

`kubectl get pods` <br>
``` bash

```
`kubectl get deployments.apps --show-*` <br>
``` bash

```
`kubectl get deployments.apps --show-labels` <br>
``` bash

```
`kubectl create -f wishlist-deployment.yaml` <br>
``` bash

```
`kubectl get rs` <br>
``` bash

```
`kubectl get deployments` <br>
``` bash

```
`helm install --name "wishlist-chart" -f values.yaml .` <br>
``` bash

```

## Minikube

`minikube version` <br>
``` bash

```
`minikube status` <br>
``` bash

```
`minikube update-check` <br>
``` bash

```
`minikube update` <br>
``` bash

```
`minikube upgrade` <br>
``` bash

```
`kubectl version` <br>
``` bash

```
`minikube start` <br>
``` bash

```
`minikube status` <br>
``` bash

```
`minikube stop` <br>
``` bash

```

#### Start minikube if using the Microsoft hyperV

`minikube start --vm-driver=hyper`
``` bash

```
## [Image Magick](https://imagemagick.org/index.php)

### Image operations with ImageMagick

#### Easily-resize-images with percentage

``` bash
# percentage
convert -resize 50% source.png dest.jpg
```

#### Specific resize value
``` bash
SIZE="1024X768"
convert -resize $SIZE source.png destination.jpg
```
---
# Inbox

Os hillman website. Iframe to include in website

``` html
<iframe src="http://www.marketplaceleaders.org/a/" style="overflow:hidden" marginheight="0" marginwidth="0" frameborder="0" width="100%" height="100%"></iframe>
Read more: http://www.marketplaceleaders.org/tgif/api/#ixzz6pzkOZ8Wi
```