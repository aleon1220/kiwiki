- [Jenkins](#jenkins)
      - [Upgrade Jenkins version in monolith servers](#upgrade-jenkins-version-in-monolith-servers)
  - [Admin Tasks](#admin-tasks)
      - [Get the version with the CLI](#get-the-version-with-the-cli)
  - [Useful functions and tools](#useful-functions-and-tools)
    - [Variables](#variables)
    - [Validate the Jenkinsfile Pipeline](#validate-the-jenkinsfile-pipeline)
    - [Test Groovy code](#test-groovy-code)
    - [Use a Linter to validate Jenkins File](#use-a-linter-to-validate-jenkins-file)
    - [Example of using startup flags](#example-of-using-startup-flags)
  - [Jenkins Docker Container](#jenkins-docker-container)
      - [Run Jenkins from a Docker Container and install plugins from a list](#run-jenkins-from-a-docker-container-and-install-plugins-from-a-list)
      - [Build the Docker image](#build-the-docker-image)
      - [Start the container based on the built image](#start-the-container-based-on-the-built-image)
    - [Use the jenkins-plugin-cli to install](#use-the-jenkins-plugin-cli-to-install)
      - [Lists the Credentials in a specific Store](#lists-the-credentials-in-a-specific-store)
    - [Jenkins Kubernetes Helm Chart](#jenkins-kubernetes-helm-chart)
    - [Jenkins Glossary](#jenkins-glossary)
    - [Distributed Builds Terminology](#distributed-builds-terminology)
    - [Plugins used up to this point 2020](#plugins-used-up-to-this-point-2020)

[Kiwiki Home](/../../)
# Jenkins
www.jenkins.io

#### Upgrade Jenkins version in monolith servers
- Get the latest stable version
``` bash
cd $HOME
wget https://get.jenkins.io/war-stable/latest/jenkins.war
```

- Back up previous WAR file
``` bash
cp /usr/lib/jenkins/jenkins.war $HOME/jenkins.war.previous.version
```

- Copy new WAR to Jenkins location
``` bash
sudo cp $HOME/jenkins.war /usr/lib/jenkins/
```

- Restart services
``` bash
sudo systemctl restart jenkins
```
## Admin Tasks
#### Get the version with the CLI
``` bash
JENKINS_URL="http://myjenkins.local:8080/"
java -jar jenkins-cli.jar -s  $JENKINS_URL version
```
## Useful functions and tools
### Variables
Using env-vars.html
open `${YOUR_JENKINS_HOST}/env-vars.html` page on your Jenkins master server to get a list of all environment variables listed on an HTML page.

### Validate the Jenkinsfile Pipeline
If using vscode there is a nice linter/validator plugin
- get the plugin
``` bash
janjoerke.jenkins-pipeline-linter-connector
```
- within the Jenkinsfile do `CTRL + P`
- Type `Validate Jenkinsfile`
- Enter the Jenkins File validation URL

``` bash
https://JENKINS_URL/pipeline-model-converter/validate
```

### Test Groovy code
use the following URL to test groovy snippets

`$JENKINS_URL/script`
### Use a Linter to validate Jenkins File
[linter for Jenkins](https://www.jenkins.io/doc/book/pipeline/development/#linter)

### Example of using startup flags
```
java -Dhudson.footerURL=http://example.org -jar jenkins.war \
--httpPort=8083 --prefix=/ci --httpListenAddress=127.0.0.1
```

Setting the Java system property (JAVA_OPTS)
`-Dhudson.footerURL=http://example.org` will change the default footer on the Jenkins UI to `domain=http://example.com`
`--httpPort`, `--prefix`, and `--httpListenAddress` are the flags provided as `$JENKINS_OPTS`
`--httpPort=8083` will set the Jenkins port to 8083 instead of the default 8080
`--prefix=/ci` will add a prefix to the end of the Jenkins URL
`--httpListenAddress=127.0.0.1` binds Jenkins to the IP address.

[Jenkins Features Controlled with System Properties](https://jenkins.io/doc/book/managing/system-properties/)

Jenkins settings file  = `/etc/default/jenkins`
Startup script         = `/etc/init.d/jenkins`
Jenkins home directory = `/var/lib/jenkins`
Jenkins log file       = `/var/log/jenkins`

## Jenkins Docker Container
- [Docker Hub for jenkins:lts](https://hub.docker.com/r/jenkins/jenkins/)
- [Run Jenkins in Docker Container](https://www.jenkins.io/doc/book/installing/#downloading-and-running-jenkins-in-docker)
- [Jenkins project readme in Github](https://github.com/jenkinsci/docker/blob/master/README.md)

``` bash
docker run --name docker-jenkins-test --detach -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts
```

#### Run Jenkins from a Docker Container and install plugins from a list

``` bash
# create docker file
sudo bash -c "cat > $PWD/Dockerfile" 
<<EOF
FROM jenkins/jenkins:lts
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
EOF
```

#### Build the Docker image
`docker build --tag jenkins-lts:neon-plugins .`

#### Start the container based on the built image
``` bash
docker run --name docker-jenkins-test -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins-lts:neon-plugins
```

### Use the jenkins-plugin-cli to install
``` bash
jenkins-plugin-cli --plugins <List of plugins with version or just the name>
```

#### Lists the Credentials in a specific Store
``` bash
java -jar jenkins-cli.jar -s http://localhost:8080/ list-credentials STORE
```

### Jenkins Kubernetes Helm Chart
[Helm chart for Jenkins](https://github.com/helm/charts/tree/master/stable/jenkins)

### Jenkins Glossary
see [jenkins.io book](https://www.jenkins.io/doc/book/glossary/)

### Distributed Builds Terminology
From [EDX Jenkins](https://learning.edx.org/course/course-v1:LinuxFoundationX+LFS167x+2T2020/block-v1:LinuxFoundationX+LFS167x+2T2020+type@sequential+block@6074ebbee1a94de5963c3dbe2d021d4c/block-v1:LinuxFoundationX+LFS167x+2T2020+type@vertical+block@99c7f23e787749e4bb1734ee825be29a)
terminology related to **distributed build**.

- **Master=** A machine where Jenkins is installed. It centrally stores all the configurations, loads plugins and renders the Jenkins UI.
- **Agent=** A machine which connects to the Jenkins master and performs various operations as directed by the Jenkins master.
- **Node=** A machine that can allocate an executor and run Jenkins Pipelines. Examples are Jenkins masters and Agents. You will notice that nodes and agents are sometimes used synonymously.
- **Executor=** A Jenkins executor is one of the basic building blocks which allows a build to run on a node. You can configure more than one executor for every node. The number of executors is set based on the number of CPUs, IO performance and other hardware characteristics of a node and the type of builds you have configured to run. The number of executors determines the number of concurrent builds that can be run at any given point in time.

It is Jenkins security best practice to set the number of executors to 0 on the **Jenkins master**, and not run any builds on it.

### Plugins used up to this point 2020
- [Blue Ocean](https://plugins.jenkins.io/blueocean/) graphical editor = Easily create your Jenkinsfile and define pipelines execution.
- [Docker](https://plugins.jenkins.io/docker-plugin/) = Interacts with Docker
- [JaCoCo plugin](https://plugins.jenkins.io/jacoco/) = Java Code Coverage
- [Warnings Next Generation](https://plugins.jenkins.io/warnings-ng/) = Collects compiler warnings or issues reported by static analysis tools and visualizes the results.
- Folders = helps in organizing the structure of projects
- Prometheus metrics(https://plugins.jenkins.io/prometheus/#documentation)
- Docker(https://plugins.jenkins.io/docker-plugin/) = Jenkins cloud plugin for docker
- Kubernetes(https://plugins.jenkins.io/kubernetes/) = Run dynamic agents in Kubernetes

[Back to top](#)

[Kiwiki Home](/../../)