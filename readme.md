# Wiki Information Technology
it happened in 2020-04-28. For years i have been collecting snippets on linux, solaris, C, Java, Docker, Kubernetes, etc.
Then a google docs file was inside of a google drive folder. I accidentally deleted the folder and later on i emptied the bin. I truly dislike that. 
I got in touch with google support to no avail. 
I still hope i can recover my file.

Dont rely on the cloud 100%. Have local copies of your digital material.

# Introduction
2020-04-28 I just lost years of work on setting a nice Information Technology Wiki. Now i will start a new one in github.
It will have categories and then subcategories with functionalites.

# Terminals

## Bash

### Networking
## Linux
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

# Docker-Compose

# Kubernetes
