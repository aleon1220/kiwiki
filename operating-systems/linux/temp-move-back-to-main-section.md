[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Processing CPU
Section for compute related concepts in computers

##### Interactive process viewer

```bash
htop
```

#### print a line and pipe it to a command

In this case the content of a `DockerFile` is echoed first then piped to `docker build` to create a docker image.

```bash
echo -e 'FROM busybox\nRUN echo "hello world"' | docker build -
```

#### run a command and append config
```bash
docker build -<<EOF
FROM busybox
RUN echo "hello world"
EOF
```

[Back to top](#)

[Kiwiki Home](/../../)


[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Computer Memory

[Back to top](#)

[Kiwiki Home](/../../)


[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Compute Storage File Systems

## NTFS

## ZFS File System

ZFS is a complex and yet powerful storage FileSystem

[Back to top](#)

[Kiwiki Home](/../../)