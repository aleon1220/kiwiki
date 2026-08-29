# Windows

Reusable Actions. Command prompt cmd & PowerShell

> Executed using windows terminal with WSL:

* Powershell 7
* windows 10
* windows 11

#### find in history uses of `ssh`

```powershell
Get-History | Select-String "ssh "
```

#### open given directory path in File Explorer
```powershell
Invoke-Item C:\workspace
```

## Aliases

* create persistent Aliases

* open a simple editor to customize the Powershell profile: use `notepad` or `code`

```powershell
notepad $PROFILE
```

* create the alias required. Usually Linux commands

```powershell
Set-Alias ll Get-ChildItem
```

* view existing aliases

```powershell
Get-Alias
```

## Environment variables

Environment variables store data that's used by the operating system and other programs.
[learn Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7.5)

* check content of Path variable

```powershell
$env:Path
```

* Source the Profile file: Similar to `source ~/.bashrc`

```powershell
. $PROFILE
```

## Handling compressed files

#### decompress a .zip file

```powershell
Expand-Archive -Path .\compressedData.zip -DestinationPath .\decompressedFiles
```

## Admin tasks

* Get OS info verbose

```powershell
Get-ComputerInfo | Select-Object Os* | Format-List
```

* start a session running as Admin

```powershell
Start-Process powershell -Verb runAs
```

## Common CLI Actions

* learn more about commands and their usage

```powershell
Get-Help Get-ChildItem
```

* which AD groups i am part of?

```powershell
whoami /groups | Format-List
```

* list directories simple

```powershell
ls | ForEach-Object { $_.Name }
```

* get Windows License

```cmd
wmic path SoftwareLicensingService get OA3xOriginalProductKey
```

## file ops

<!-- expand -->
<details>

<summary> File operations with powershell </summary>

*  finds files filtering by regex return the Path

```powershell
Get-ChildItem -Path "C:\Users\" -Filter "*.doc*" -Recurse | Select-Object -ExpandProperty FullName
```

* batch rename by Removing **Screenshot** text
once happy remove dry run flag `-WhatIf`

```powershell
$folder = "C:\workspace"

Get-ChildItem -Path $folder -File -Filter 'Screenshot *.png' |
  ForEach-Object {
    $newName = $_.Name -replace '^Screenshot\s+', ''   # regex at the beginning of the line
    Rename-Item -LiteralPath $_.FullName -NewName $newName -WhatIf
}
```

### Powershell Supporting functions

* for the work log analysis: create directories from January to December

``` powershell
$months = [System.Globalization.DateTimeFormatInfo]::InvariantInfo.MonthNames[0..11]
$year = (Get-Date).Year

for ($i = 0; $i -lt 12; $i++) {
    $month = $months[$i]
    $dirName = "$year-{0:D2}-{1}" -f ($i + 1), $month
    New-Item -ItemType Directory -Path $dirName -Force
}
```

* force update windows enterprise policies

``` powershell
gpupdate /force
```

</details>
<!-- end of expand -->

## Networking

* get your Public IP Address

```powershell
(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content
```

* check port connectivity. set `$host_to_test=host.in`

```powershell
Test-NetConnection -ComputerName $host_to_test -Port 22 -InformationLevel Detailed
```

---

## WSL management

WSL Windows Subsystem Linux. WSL is a virtualization layer that runs Linux distros in windows.
check [WSL docs](https://learn.microsoft.com/en-us/windows/wsl/) 

* install WSL

```powershell
wsl --install
```

* restart WSL
restart vmcompute service and the Hyper-v service

Encountering the WSL2 error. after running the commands in few seconds the WSL with a linux instance is available again

tested in Win10 and win11

> Logon failure: the user has not been granted the requested logon type at this computer.
> Error code: Wsl/Service/CreateInstance/CreateVm/0x80070569

*-* stop `wsl`

```powershell
wsl --shutdown
```

* restart WSL related services

```powershell
Restart-Service vmcompute
```

* optional: tested in windows 10

```powershell
Restart-Service LxssManager
```

* list installed distros

```powershell
wsl --list --verbose
```

* import OS image into WSL

```powershell
$DistroName="RHEL-10-custom"
$InstallLocation=".\WSL\RHEL10custom"
$InstallTarFile=".\Downloads\composer-api-12b-image.wsl"

wsl.exe --import $DistroName $InstallLocation $InstallTarFile
```

* run specific distro

  ```powershell
  wsl.exe --install --no-distribution
  ```

---

## Network

* flush DNS & restart networking: runa terminal window as Admin

```dotnetcli
echo "Restart the computer"
ipconfig /all
```

* purges the DNS Resolver cache.

```cmd
ipconfig /flushdns
```

* refreshes all DHCP leases and re-registers DNS names

```cmd
ipconfig /registerdns
```

#### releases the current DHCP lease
```cmd
ipconfig /release
```

* obtain new lease: re-connect computer to network

```cmd
ipconfig /renew
```

* network statistics 

```powershell
netstat -nao
```

* netstats by Process ID

```powershell
netsat -ano | find str "PID"
```

* restart Network IPV6 associated

```powershell
netsh int ipv6 reset reset.log
```

* Disable any active virtual private network (VPN) connection.
* Restore the firewall defaults
* disable the IP Helper service
This features attempts to manage some aspects of IPv6 connectivity. To disable it:

1. Press `Windows key+R` type services.msc in the displayed window Run box, and select OK.
2. A list of Windows system services will be shown.
3. Scroll through the list and locate the service named IP Helper > right-click the service name > Properties.
4. In the Startup type drop-down list, choose Disabled, then select OK.
5. Restart your system
6. check to see if the IPv6 connection now works as expected.

* clean-up network devices

```cmd
netcfg -d
```

* resets Sockets (Winsock) catalog to default state: helps resolving network connectivity issues

```cmd
netsh winsock reset
```

* verify that DNS name resolution is working correctly

```cmd
$hostToLookUP = "andres.nz"
nslookup $hostToLookUP
```

* determine whether the router is performing slowly or dropping packets

```powershell
pathping  $IP
```

* set Configurations for files and folders

```powershell
attrib
```

### Service Control Manager

* query extended status for a service

* enumerates the status for types of services.

```cmd
sc queryex
```

* delete service

```powershell
sc delete $SERVICENAME
```

### FileSystem

* scan with System File Checker

```powershell
sfc /scannow
```

* measure command time execution: windows form of linux `time`

``` powershell
Measure-Command { echo hi }
```

---

### Windows [Terminal](https://docs.microsoft.com/en-us/windows/terminal/get-started#installation)

* set terminal with vertical panes 2nd pane will be WSL

``` powershell
wt split-pane --vertical wsl
```
