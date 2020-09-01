# jenkins
jenkins.io

### example of using startup flags
```
java -Dhudson.footerURL=http://example.org -jar jenkins.war \
--httpPort=8083 --prefix=/ci --httpListenAddress=127.0.0.1
```
setting the Java system property (JAVA_OPTS) `-Dhudson.footerURL=http://example.org` will change the default footer on the Jenkins UI to http://example.com
`--httpPort`, `--prefix`, and `--httpListenAddress` are the flags provided as JENKINS_OPTS
`--httpPort=8083` will set the Jenkins port to 8083 instead of the default 8080
`--prefix=/ci` will add a prefix to the end of the Jenkins URL
`--httpListenAddress=127.0.0.1` binds Jenkins to the IP address.

[Jenkins Features Controlled with System Properties](https://jenkins.io/doc/book/managing/system-properties/)

 Jenkins settings file= `/etc/default/jenkins`
 startup script= `/etc/init.d/jenkins`
 Jenkins home directory= `/var/lib/jenkins`
 Jenkins log file= `/var/log/jenkins`

## Jenkins Docker Container
https://hub.docker.com/r/jenkins/jenkins/
[Run Jenkins in Docker Container](https://www.jenkins.io/doc/book/installing/#downloading-and-running-jenkins-in-docker)

# Jenkins Kubernetes Helm Chart
[Helm chart for Jenkins](https://github.com/helm/charts/tree/master/stable/jenkins)

## Jenkins Glossary
see [jenkins.io book](https://www.jenkins.io/doc/book/glossary/)