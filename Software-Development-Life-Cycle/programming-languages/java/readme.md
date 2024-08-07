- [The Java Language](#the-java-language)
  - [Java Versions](#java-versions)
    - [Older Versions](#older-versions)
      - [Java 1.3](#java-13)
      - [Java 1.4](#java-14)
      - [Java 1.5](#java-15)
      - [Java 1.6](#java-16)
    - [Java 7](#java-7)
    - [Java 8](#java-8)
    - [Java 9](#java-9)
    - [Java 11](#java-11)
    - [Java 12](#java-12)
    - [Java 13](#java-13-1)
    - [Java 14](#java-14-1)
    - [Java 15](#java-15-1)
    - [Java 16](#java-16-1)
    - [Java 17](#java-17)
    - [Java 18](#java-18)
    - [Java 19](#java-19)
    - [Java 20](#java-20)
  - [Java installation Management SDK](#java-installation-management-sdk)
    - [SDKMan](#sdkman)
      - [Find java distro version number](#find-java-distro-version-number)
      - [install JDK version](#install-jdk-version)
    - [Install default JDK and JRE Ubuntu](#install-default-jdk-and-jre-ubuntu)
      - [Install popular OpenJDK](#install-popular-openjdk)
      - [Use `update-alternative` to set version for Java runtime](#use-update-alternative-to-set-version-for-java-runtime)
      - [Use `update-alternative` to set version for Java compiler](#use-update-alternative-to-set-version-for-java-compiler)
      - [Git Repo reporting Demo for one Java WebApp](#git-repo-reporting-demo-for-one-java-webapp)
    - [OpenJDK](#openjdk)
    - [Oracle Java](#oracle-java)

[Kiwiki Home](/../../)

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
