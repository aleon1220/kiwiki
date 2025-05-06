[Kiwiki Home](/../../)
[Back to Main Page](./readme.md)

# Windows
Command prompt cmd & powershell PowerShell
> Executed in
- WSL
- Powershell 7
- windows 10
- windows 11

WSL is a virtualization layer that runs Linux distros in windows 10+

## Common CLI Actions
#### learn more about commands and their usage
```powershell
Get-Help Get-ChildItem
```

#### list directories simple
```powershell
ls | ForEach-Object { $_.Name }
```

## Get Windows License
```cmd
wmic path SoftwareLicensingService get OA3xOriginalProductKey
```

### Networking

##### Get your Public IP Address
```powershell
(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content
```
### WSL management
WSL Windows Subsystem Linux
### Install
```powershell
wsl --install
```
#### Restart the Hyper-v service
Encounter a WSL2 error
> Logon failure: the user has not been granted the requested logon type at this computer.
> Error code: Wsl/Service/CreateInstance/CreateVm/0x80070569

``` powershell
Restart-Service vmcompute
```


#### WSL off
``` powershell
wsl --shutdown
```

#### Restarting WSL2
- tested in Win10
``` powershell
Restart-Service LxssManager
```

## Network
#### Flush DNS and restart networking
Open a terminal or powershell window as Admin
```dotnetcli
ipconfig /flushdns
ipconfig /registerdns
ipconfig /release
ipconfig /renew
netsh winsock reset

echo "Restart the computer"
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
```cmd
netcfg -d
``` 

#### Verify that DNS name resolution is working correctly
```cmd
nslookup host
```

#### Determine whether the router is performing slowly or dropping packets.
```powershell
pathping  $IP
```

#### File Checksum Integrity Verifier 
Install as plugin first
```powershell
fciv.exe [Commands] <Options>
```

#### Set Configurations for files and folders
```powershell
attrib
```

### Services
#### delete service
``` powershell
sc delete "SERVICENAME"
```
### FileSystem
#### Scan with System File Checker
``` powershell
sfc /scannow
```

#### Measure execution of a command aka windows form of linux `time`
``` powershell
Measure-Command { echo hi }
```

### Windows [Terminal](https://docs.microsoft.com/en-us/windows/terminal/get-started#installation)

#### Windows terminal with vertical panes. 2nd pane is WSL
``` powershell
wt split-pane --vertical wsl
```

---

[Back to top](#)

[Kiwiki Home](/../../)
