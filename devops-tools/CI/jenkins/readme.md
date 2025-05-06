[Kiwiki Home](/../../)
[Back to Main Page](./readme.md)

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

## plugins.txt
user can create a jenkins instance with plugins installed on demand

job-import-plugin: 3.4
blueocean-display-url: 2.4.0
jquery-detached: 1.2.1
workflow-cps: 2.83
scm-api: 2.6.3
htmlpublisher: 1.23
promoted-builds: 3.6
email-ext: 2.77
workflow-job: 2.40
blueocean-jwt: 1.24.1
timestamper: 1.11.6
security-inspector: 0.5
Office-365-Connector: 4.13.2
maven-plugin: 3.7
postbuild-task: 1.8
blueocean-web: 1.24.1
swarm: 3.23
build-timeout: 1.20
repo: 1.13.0
mailer: 1.32.1
momentjs: 1.1.1
blueocean-git-pipeline: 1.24.1
msginject: 0.1.1
gradle: 1.36
git-userContent: 1.4
variant: 1.3
lockable-resources: 2.10
dashboard-view: 2.13
pipeline-milestone-step: 1.3.1
blueocean-i18n: 1.24.1
blueocean-core-js: 1.24.1
disk-usage: 0.28
pipeline-graph-analysis: 1.10
git-tag-message: 1.7.1
workflow-cps-global-lib: 2.17
checks-api: 1.0.2
bootstrap4-api: 4.5.2-1
pipeline-input-step: 2.12
gerrit-verify-status-reporter: 0.0.3
publish-over: 0.22
matrix-auth: 2.6.3
maven-metadata-plugin: 2.0.0
pipeline-stage-step: 2.5
build-with-parameters: 1.5
build-publisher: 1.22
github: 1.31.0
git: 4.4.4
workflow-aggregator: 2.6
workflow-step-api: 2.23
workflow-basic-steps: 2.20
ssh-credentials: 1.18.1
jaxb: 2.3.0.1
envinject: 2.3.0
blueocean: 1.24.1
stash-pullrequest-builder: 1.17
ssh-slaves: 1.31.2
pipeline-stage-view: 2.17
blueocean-jira: 1.24.1
config-file-provider: 3.7.0
gradle-repo: 1.0.1
jobcacher: 1.0
jdk-tool: 1.4
aws-global-configuration: 1.5
github-oauth: 0.33
resource-disposer: 0.14
plain-credentials: 1.7
pipeline-model-extensions: 1.7.2
node-iterator-api: 1.5.0
filesystem-list-parameter-plugin: 0.0.6
cloudbees-folder: 6.14
blueocean-pipeline-api-impl: 1.24.1
extended-read-permission: 3.2
pipeline-model-definition: 1.7.2
Parameterized-Remote-Trigger: 3.1.4
parameterized-trigger: 2.39
bouncycastle-api: 2.18
blueocean-pipeline-scm-api: 1.24.1
archived-artifact-url-viewer: 1.1
aws-credentials: 1.28
pipeline-stage-tags-metadata: 1.7.2
basic-branch-build-strategies: 1.3.2
font-awesome-api: 5.14.0-1
jqs-monitoring: 1.4
sse-gateway: 1.23
ace-editor: 1.1
display-url-api: 2.3.3
blueocean-autofavorite: 1.2.4
blueocean-rest-impl: 1.24.1
backup: 1.6.1
blueocean-pipeline-editor: 1.24.1
docker-workflow: 1.24
global-variable-string-parameter: 1.2
copyartifact: 1.45.1
http_request: 1.8.26
job-direct-mail: 1.5
envinject-api: 1.7
junit: 1.39
okhttp-api: 3.14.9
publish-over-ftp: 1.15
subversion: 2.13.1
workflow-multibranch: 2.22
ssh-agent: 1.20
durable-task: 1.35
antisamy-markup-formatter: 2.1
jsch: 0.1.55.2
ftppublisher: 1.2
gerrit-code-review: 0.4.4
blueocean-personalization: 1.24.1
apache-httpcomponents-client-4-api: 4.5.10-2.0
managed-scripts: 1.4
echarts-api: 4.9.0-1
s3: 0.11.5
startup-trigger-plugin: 2.9.3
snakeyaml-api: 1.27.0
build-blocker-plugin: 1.7.3
hudson-wsclean-plugin: 1.0.8
pipeline-github-lib: 1.0
blueocean-bitbucket-pipeline: 1.24.1
permissive-script-security: 0.6
structs: 1.20
extended-choice-parameter: 0.82
run-condition: 1.3
script-security: 1.75
jquery3-api: 3.5.1-1
singleuseslave: 1.0.0
pipeline-rest-api: 2.17
multiple-scms: 0.6
artifactdeployer: 1.2
blueocean-dashboard: 1.24.1
credentials-binding: 1.23
ldap: 1.26
block-build-final-project: 1.0
pubsub-light: 1.13
javadoc: 1.6
blueocean-github-pipeline: 1.24.1
bitbucket: 1.1.27
slave-setup: 1.10
gerrit-trigger: 2.30.5
credentials: 2.3.13
git-notes: 0.0.4
jobConfigHistory: 2.26
greenballs: 1.15
jquery: 1.12.4-1
sectioned-view: 1.25
github-branch-source: 2.9.1
publish-over-ssh: 1.20.1
parameter-separator: 1.3
last-changes: 2.7.9
icon-shim: 2.0.3
blueocean-rest: 1.24.1
block-same-builds: 1.3
compress-artifacts: 1.10
github-api: 1.116
pipeline-model-declarative-agent: 1.1.1
mapdb-api: 1.0.9.0
copy-project-link: 1.5
pipeline-build-step: 2.13
authentication-tokens: 1.4
workflow-api: 2.40
git-server: 1.9
network-monitor: 1.1
build-timestamp: 1.0.3
systemloadaverage-monitor: 1.2
git-client: 3.5.1
windows-slaves: 1.7
conditional-buildstep: 1.3.6
handlebars: 1.1.1
artifact-diff-plugin: 1.3
jira: 3.1.1
ivy: 2.1
extensible-choice-parameter: 1.6.0
fail-the-build-plugin: 1.0
shared-workspace: 1.0.2
popper-api: 1.16.0-6
clone-workspace-scm: 0.6
pollscm: 1.3.1
favorite: 2.3.2
command-launcher: 1.4
jackson2-api: 2.11.3
role-strategy: 3.1
artifactory: 3.8.1
git-changelog: 3.0
mask-passwords: 2.13
blueocean-events: 1.24.1
build-token-trigger: 1.0.0
block-queued-job: 0.2.0
handy-uri-templates-2-api: 2.1.8-1.0
cloudbees-bitbucket-branch-source: 2.9.4
external-monitor-job: 1.7
thinBackup: 1.10
pam-auth: 1.6
git-parameter: 0.9.13
build-token-root: 1.7
token-macro: 2.12
postbuildscript: 2.11.0
github-pr-coverage-status: 2.1.1
random-string-parameter: 1.0
ec2: 1.53
ghprb: 1.42.1
matrix-project: 1.18
workflow-scm-step: 2.11
gitflow: 1.0.1
copy-data-to-workspace-plugin: 1.0
trilead-api: 1.0.10
stashNotifier: 1.20
ftp-rename: 1.2
docker-commons: 1.17
workflow-support: 3.5
pipeline-utility-steps: 2.6.1
github-pullrequest: 0.2.8
jenkins-design-language: 1.24.1
pipeline-model-api: 1.7.2
ws-cleanup: 0.38
ruby-runtime: 0.12
aws-java-sdk: 1.11.854
promoted-builds-simple: 1.9
blueocean-config: 1.24.1
plugin-util-api: 1.3.0
workflow-durable-task-step: 2.36
emailext-template: 1.1
mercurial: 2.10
amazon-ecs: 1.37
artifact-manager-s3: 1.12
ant: 1.11
branch-api: 2.6.0
blueocean-commons: 1.24.1
project-build-times: 1.2.1

[Back to top](#)

[Kiwiki Home](/../../)