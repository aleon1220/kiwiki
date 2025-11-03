[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Windows
Command prompt cmd & powershell PowerShell
> Executed using windows terminal with WSL:
- Powershell 7
- windows 10
- windows 11

WSL is a virtualization layer that runs Linux distros in windows 10+

## Handling compressed files
#### decompress a .zip file
```powershell
Expand-Archive -Path .\compressedData.zip -DestinationPath .\decompressedFiles
``` 

# Admin tasks
#### Get OS info verbose
```powershell
Get-ComputerInfo | Select-Object Os* | Format-List
```

#### start a session running as Admin
```powershell
Start-Process powershell -Verb runAs
```

## Common CLI Actions
#### learn more about commands and their usage
```powershell
Get-Help Get-ChildItem
```
#### which AD groups i am part of?
```powershell
whoami /groups | Format-List
```

#### list directories simple
```powershell
ls | ForEach-Object { $_.Name }
```

## get Windows License
```cmd
wmic path SoftwareLicensingService get OA3xOriginalProductKey
```

### Networking

##### get your Public IP Address
```powershell
(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content
```
### WSL management
WSL Windows Subsystem Linux
### install WSL
```powershell
wsl --install
```
#### restart the Hyper-v service
Encounter a WSL2 error
> Logon failure: the user has not been granted the requested logon type at this computer.
> Error code: Wsl/Service/CreateInstance/CreateVm/0x80070569

```powershell
Restart-Service vmcompute
```

#### restart WSL2
- tested in Win10
```powershell
Restart-Service LxssManager
```

#### shutdown WSL
```powershell
wsl --shutdown
```
---

## Network
#### Flush DNS and restart networking
Open a terminal or powershell window as Admin
```dotnetcli
echo "Restart the computer"
ipconfig /all
```

#### purges the DNS Resolver cache.
```cmd
ipconfig /flushdns
```

#### refreshes all DHCP leases and re-registers DNS names
```cmd
ipconfig /registerdns
```

#### releases the current DHCP lease
```cmd
ipconfig /release
```

#### obtain new lease
re-connect computer to network
```cmd
ipconfig /renew
```

#### network statistics 
```powershell
netstat -nao
```

#### netstats fby Process ID
```powershell
netsat -ano | find str "PID"
```

##### restart Network IPV6 associated
```powershell
netsh int ipv6 reset reset.log
```
- Disable any active virtual private network (VPN) connection.
- Restore the firewall defaults

### Disable the IP Helper service
This features attempts to manage some aspects of IPv6 connectivity. To disable it:
1. Press `Windows key+R` type services.msc in the displayed window Run box, and select OK.
2. A list of Windows system services will be shown.
3. Scroll through the list and locate the service named IP Helper > right-click the service name > Properties.
4. In the Startup type drop-down list, choose Disabled, then select OK.
5. Restart your system
6. check to see if the IPv6 connection now works as expected.

#### Clean-up network devices
```cmd
netcfg -d
```

#### resets Sockets (Winsock) catalog to default state
can help resolve network connectivity issues
```cmd
netsh winsock reset
```

#### verify that DNS name resolution is working correctly
```cmd
$hostToLookUP = "andres.nz"
nslookup $hostToLookUP
```

#### determine whether the router is performing slowly or dropping packets
```powershell
pathping  $IP
```

#### set Configurations for files and folders
```powershell
attrib
```

### Service Control Manager
#### queries the extended status for a service
or enumerates the status for types of services.
```cmd
sc queryex
```

#### delete service
```powershell
sc delete $SERVICENAME
```

### FileSystem
#### scan with System File Checker
```powershell
sfc /scannow
```

#### measure command time execution 
windows form of linux `time`
``` powershell
Measure-Command { echo hi }
```

---
### Windows [Terminal](https://docs.microsoft.com/en-us/windows/terminal/get-started#installation)

#### set terminal with vertical panes 2nd pane is WSL
``` powershell
wt split-pane --vertical wsl
```

### Supporting functions
for the work log analysis

#### create directories from January to December
``` powershell
$months = [System.Globalization.DateTimeFormatInfo]::InvariantInfo.MonthNames[0..11]

for ($i = 0; $i -lt 12; $i++) {
    $month = $months[$i]
    $dirName = "{0:D2}-{1}" -f ($i + 1), $month
    New-Item -ItemType Directory -Path $dirName -Force
}
```

[Back to top](#)

[Kiwiki Home](/../../)
