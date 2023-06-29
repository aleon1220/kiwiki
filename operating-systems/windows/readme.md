# Windows
Command prompt & power shell
> Executed in WSL, Powershell 7 windows 10
WSL is a virtualization layer that runs Linux distros in windows 10 and windows 11

## Get Windows License
``` cmd
wmic path SoftwareLicensingService get OA3xOriginalProductKey
```

## WSL Windows Subsystem Linux
### Install
``` powershell
wsl --install
```

## PowerShell

### Networking

##### Get your Public IP Address
``` powershell
(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content
```

#### Restart the Hyper-v service
Encounter a WSL2 error
``` powershell
Restart-Service vmcompute
```

## Command Prompt 

### Network commands for cmd
#### Flush DNS and restart networking
Open a terminal or powershell window as Admin
``` dotnetcli
ipconfig /flushdns
ipconfig /registerdns
ipconfig /release
ipconfig /renew
netsh winsock reset

echo " Restart the computer "
```

#### network statistics. Find by Process ID

``` powershell
netstat -nao
netsat -ano | find str "PID"
```

##### Restart Network IPV6 associated
``` powershell
netsh int ipv6 reset reset.log
```

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

#### Determine whether the router is performing slowly or dropping packets.
``` powershell
pathping  "IP"
```

#### File Checksum Integrity Verifier (Install as plugin first)
``` powershell
fciv.exe [Commands] <Options>
```

#### Set Configurations for files and folders
``` powershell
attrib
```

### Dealing with services
#### Services command

``` powershell
sc
sc delete "SERVICENAME"
```

#### Scan with System File Checker
``` powershell
sfc /scannow
```

#### Measure execution of a command aka windows form of `time`
``` powershell
Measure-Command { echo hi }
```

### Windows Nice [Terminal](https://docs.microsoft.com/en-us/windows/terminal/get-started#installation)

#### Windows terminal with vertical panes. 2nd pane is WSL
``` powershell
wt split-pane --vertical wsl
```

---

[Back to top](#)

[Kiwiki Home](/../../)