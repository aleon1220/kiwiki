[Kiwiki Home](/../../)
[Back to Main Page](./readme.md)

# The Java Language
high-level, class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible
## Java Versions

### Older Versions
#### Java 1.3

#### Java 1.4

#### Java 1.5

#### Java 1.6

### Java 7

### Java 8

### Java 9

### Java 11

### Java 12

### Java 13

### Java 14

### Java 15

### Java 16

### Java 17

### Java 18

### Java 19

### Java 20

### Java 21
LTS. Recently using [Amazon JDK](https://docs.aws.amazon.com/corretto/latest/corretto-21-ug/downloads-list.html)

## Java installation Management SDK
Manage multiple version with sdkman

### [SDKMan](https://sdkman.io/)
#### Installation 
- install SDK Man
```bash
curl -s "https://get.sdkman.io" | bash
```

#### Find java distro version number
```bash
sdk list java | grep "21.0"
```

#### Install target JDK version
```bash
SDK_MAN_JAVA_VERSION="21.0.2-amzn"

sdk install java $SDK_MAN_JAVA_VERSION
```
### Using Ubuntu apt
leverage OS package manager

### Install default JDK and JRE Ubuntu
``` bash
sudo apt install default-jdk default-jre
```

#### Install popular OpenJDK
```bash
sudo apt install openjdk-8-jdk
```

#### Use `update-alternative` to set version for Java runtime

```bash
update-alternatives --config java
```

#### Use `update-alternative` to set version for Java compiler

```bash
update-alternatives --config javac
```
## JDKs

### OpenJDK

### [Oracle Java](https://www.oracle.com/java/)


[Back to top](#)

[Kiwiki Home](/../../)
