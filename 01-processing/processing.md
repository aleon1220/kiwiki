# Processing CPU
Section for compute related concepts in computers

##### Interactive process viewer

```bash
htop
```

#### nohup execution

`nohup` runs the given COMMAND with hangup signals ignored, so that the command can continue running in the background after you log out.

```bash
nohup $COMMAND_OR_SCRIPT > out_$(date).txt
```

#### Echo a string an pipe it to a command

In this case the content of a `DockerFile` is echoed first then piped to `docker build` to create a docker image.

```bash
echo -e 'FROM busybox\nRUN echo "hello world"' | docker build -
docker build -<<EOF
FROM busybox
RUN echo "hello world"
EOF
```

### Explore System Processes

#### Find the process that consumes more CPU

```bash
ps -eo pid,%cpu,%mem,args --sort -%cpu
```

#### Sort processes by memory

```bash
ps aux --sort=-%mem
```

#### Unuseful view with a process tree

```bash
ps xfa | less
```

[Back to top](#)