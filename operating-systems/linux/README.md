## General Linux Server commands
Get quick diagnostic about a server

#### Get info about the linux distro
OS type, Local IP, hostname and Architecture type

```bash
lsb_release -a ; hostname -I ; hostname ; getconf LONG_BIT
```
#### Check the hidden directories and files in the HOME dir

```bash
todo $HOME
```

#### Check bash customizations in the current user

```bash
id

less ~/.bashrc
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
### Debugging Logs
#### Analyse Logs. Logs named 3 to 31.gz month. Month like Feb 2020 and print

```bash
zcat access.log.{3..31}.gz | grep -E 'Feb/2020' | awk '{print $1}' | sort -u | less
```

#### Xclip to capture the clipboard when copying

```bash
cat ~/.ssh/id_rsa.pub | xclip -sel clip
```

#### Check a dir with a parameter. Double check `info stat`

```bash
stat %A $DIR
```

##### Maintain symbolic links determining default commands. Show installed Apps

```bash
update-alternatives --get-selections
```

##### Edit sudo users

```bash
sudo visudo
```

##### Move `DIR1` to `DIR_DESTINATION`

```bash
sudo mv $DIR1 $DIR_DESTINATION
```

##### Find where the command is installed

```bash
which COMMAND

which pip
```

##### Create an alias with a command to go to a specific directory

```bash
alias ee='cd /home/ws/02-projects/ee/test' <br>

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

#### List directory with extensions

```bash
ls -xl ${DIR_PATH}
```

- Article [medium.com Troubleshooting](https://medium.com/better-programming/5-powerful-unix-commands-for-easier-troubleshooting-dd619d5e173a)

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

##### Show dir contents in tree view

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
awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " "CMD[a]/count*100 "% " a;}' | \
grep -v "./" | column -c3 -s " " -t | \
sort -nr | nl | head -n10
```

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
CTRL + D
```

##### Change permissions of a file based on permissions of other file

```bash
REF_FILE="a_file.txt" ; sudo chmod --reference=\$REF_FILE
```

##### Change ownership of all files inside dir to a given linux group

```bash
GROUP_NAME="common" ; sudo chown :\$GROUP_NAME \*
```

---
# Operating Systems

## Linux Ubuntu

### System settings

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