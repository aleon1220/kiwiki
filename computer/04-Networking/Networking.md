- [Networking](#networking)
        - [Check this awesome Cheat sheet](#check-this-awesome-cheat-sheet)
      - [Query DNS](#query-dns)
      - [Alternative to dig. It doesn't use the system local DNS.](#alternative-to-dig-it-doesnt-use-the-system-local-dns)
      - [Check packets hop and route](#check-packets-hop-and-route)
    - [Network Probing](#network-probing)
      - [Port scanning TCP,UDP ports open or closed](#port-scanning-tcpudp-ports-open-or-closed)
      - [Sends ICMP pings. checks latency](#sends-icmp-pings-checks-latency)
      - [Test port 80 netcat](#test-port-80-netcat)
      - [Examine the IPv4 TCP-based sockets that are listening for connections on your system](#examine-the-ipv4-tcp-based-sockets-that-are-listening-for-connections-on-your-system)
      - [Examine the IPv6 TCP-based sockets that are listening for connections on your system](#examine-the-ipv6-tcp-based-sockets-that-are-listening-for-connections-on-your-system)
      - [Creating Unix Domain Sockets](#creating-unix-domain-sockets)
      - [examine unix domain sockets](#examine-unix-domain-sockets)
      - [Connect to an UNIX Socket](#connect-to-an-unix-socket)
      - [Simulate traffic in IPV4 and IPV6](#simulate-traffic-in-ipv4-and-ipv6)
    - [Traffic capture](#traffic-capture)
    - [Network management](#network-management)
      - [Check ARP cache](#check-arp-cache)
    - [Load testing](#load-testing)
      - [Send TCP or UDP traffic. Similar to wrk2 but allows UDP](#send-tcp-or-udp-traffic-similar-to-wrk2-but-allows-udp)
      - [Network performance measurement tool](#network-performance-measurement-tool)
    - [Benchmarking](#benchmarking)
      - [Flush DNS by resetting the network DEBIAN based](#flush-dns-by-resetting-the-network-debian-based)
      - [Inspect TCP socket states e.g. 443](#inspect-tcp-socket-states-eg-443)
      - [Netstat statistics](#netstat-statistics)
      - [Find ports in use](#find-ports-in-use)
      - [Make sure the `firewalld` service is enabled](#make-sure-the-firewalld-service-is-enabled)
      - [Install netcat in Fedora/Redhat](#install-netcat-in-fedoraredhat)
      - [CentOS Linux Open Port 8080 on the firewall](#centos-linux-open-port-8080-on-the-firewall)
      - [Find user behind a process](#find-user-behind-a-process)
      - [Test connectivity to a port](#test-connectivity-to-a-port)
      - [Check server status](#check-server-status)
      - [Check Any URL and get output in Text](#check-any-url-and-get-output-in-text)
      - [Get listening ports](#get-listening-ports)
      - [Get a report with nmap. install it first `sudo snap install nmap`](#get-a-report-with-nmap-install-it-first-sudo-snap-install-nmap)
    - [The `ip` command](#the-ip-command)
      - [- Show / manipulate routing](#--show--manipulate-routing)
      - [- Show List of routes](#--show-list-of-routes)
      - [- Show / manipulate devices](#--show--manipulate-devices)
      - [Restart Name Service Cache Process](#restart-name-service-cache-process)
  - [CURL Client URL](#curl-client-url)
      - [Download a file and save it with a custom name](#download-a-file-and-save-it-with-a-custom-name)
      - [Get HTTP headers. use the `-I` or the `— head` option](#get-http-headers-use-the--i-or-the--head-option)
      - [Ignore invalid certs `-k or --insecure`](#ignore-invalid-certs--k-or---insecure)
      - [Make a POST request.](#make-a-post-request)
      - [get the HTTP headers and verbose mode](#get-the-http-headers-and-verbose-mode)
      - [Simplified view](#simplified-view)
      - [Specify the type of request](#specify-the-type-of-request)
      - [Include the Basic Auth](#include-the-basic-auth)
      - [Update name resolution](#update-name-resolution)
      - [Check service health](#check-service-health)
      - [Upload a file](#upload-a-file)
      - [Timing Curl connection](#timing-curl-connection)
      - [VPN](#vpn)

[Kiwiki Home](/../../)

# Networking
Commands and useful cheat sheet used in networking

##### Check this awesome Cheat sheet

[CheatSheet](https://www.linuxtrainingacademy.com/linux-ip-command-networking-cheat-sheet/)

Accessing a service, DNS
`whois` = servers
#### Query DNS
DNS queries and shows associated records
```bash
dig $DOMAIN
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

#### VPN

OpenVPN [setup in ubuntu](https://tecadmin.net/install-openvpn-client-on-ubuntu/)

[Back to top](#)

[Kiwiki Home](/../../)