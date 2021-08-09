# Containerisation architecture

## Docker Containers
``` bash
docker version
```
#### List Docker volumes
``` bash
docker volume ls
```
#### Check Docker system disk usage
``` bash
docker system df
```

## Dockerfile Practices
#### Retry `apt-get` operation if it fails
``` bash
# Make sure apt-get retries on failures
RUN echo 'Acquire::Retries "3";' > /etc/apt/apt.conf.d/80retries
```
### List the containers of an instance and show 4 attributes in table format
``` bash
docker container ls --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"
```

#### Docker Hub Search for an app or project containing given strings
``` bash
docker search IMAGE_TO_SEARCH
```

#### Example of setting credentials for another Docker registry e.g. [Artifactory.com](https://www.jfrog.com/confluence/display/JFROG/Using+Docker+V1#UsingDockerV1-3.SettingUpAuthentication)
``` bash
vim ~/.docker/config.json
```

#### Modify the `config.json` settings
``` json
{
    "auths" :{
        "https://artprod.company.com" : {
            "auth": "<USERNAME>:<PASSWORD> (converted to base 64)",
                "email": "youremail@email.com"
        },
        "https://artdev.company.com" : {
            "auth": "<USERNAME>:<PASSWORD> (converted to base 64)",
                "email": "youremail@email.com"
        }
    }
}
```

### Building Docker Images Dockerfile
#### Use docker cache busting
Install latest version of a package in 1 layer
``` bash
RUN apt-get update && apt-get install -y \
    nginx \
    vim
```

#### Use docker cache busting and version pinning and clean up the `apt` cache 
Gets specific package version with the latest minor releases

`apt cache` is not stored in a layer so you obtain a smalley docker image size

``` bash
RUN apt-get update && apt-get install -y \
    package-bar=2.5.* \
    package-baz=5.0.* \
    package-foo=1.3.* \
&& rm -rf /var/lib/apt/lists/*
```
#### Stop All Containers quietly
``` bash
docker stop $(docker ps --quiet)
```

#### Copy a file from host machine path to Docker container path
``` bash
FILE_HOST_PATH="/home/ubuntu/InternalCertificate.crt"
CONTAINER_PATH="/var/atlassian/application-data/bitbucket/"
CONTAINER_NAME="my-docker-container"
docker cp $FILE_HOST_PATH $CONTAINER_NAME:$CONTAINER_PATH
```

#### Examples of running docker containers
``` bash
docker run --restart always --name train-schedule -p 8080:8080 --detach aleon1220/train-schedule:9 node app.js

docker run --name some-nginx -d -p 9080:80
```

#### Networking tool for debugging in Debian/Ubuntu based containers
``` bash
apt update && apt install netcat inetutils-* net-tools iproute2 vim less --yes
```

#### List all containers that exited
``` bash
docker ps --filter "status=exited"
```

#### Inspect Exitcode by container ID
``` bash
docker inspect <container-id> --format='{{.State.ExitCode}}'
```

#### Clean up Everything including volumes
``` bash
docker system prune --all --force --volumes
```

#### Show containers that have an exposed port and sort
``` bash
docker ps --filter expose=0-65535/tcp | sort -u -k7
```
#### List labels for a given docker container [source](https://gist.github.com/steve-jansen)
``` bash
CONTAINER="ID or container name"
docker inspect --format \
    '{{ range $k, $v := .Config.Labels -}}
    {{ $k }}={{ $v }}
    {{ end -}}' $CONTAINER
```

#### Get IP of a given container name/ID
``` bash
docker inspect -f ‘{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}’ $CONTAINER_NAME_OR_ID
```

#### Get the IP address of the docker host from inside a docker container
``` bash
/sbin/ip route|awk '/default/ { print $3 }'
```
#### List commands used to create a given image
``` bash
MY_IMG="ubuntu"
docker history $MY_IMG | awk 'NR>1 {print $1}' | xargs docker inspect --format '{{ ((index .ContainerConfig.Cmd ) 0) }}'
```

#### Before checking issues with the app, check issues with the docker engine
``` bash
/var/log/daemon.log          = Debian distributions;
/var/log/messages            = RHEL and Oracle Linux;
journalctl -u docker.service = Ubuntu 16.04+ and CentOS 7/8
/var/log/upstart/docker.log  = for Ubuntu distributions still using upstart;
AppData/Local                = Windows operating systems;
```

#### Check logs of a container and choose a timeframe
``` bash
docker logs CONTAINER --since 15m
```
#### Check logs since a given time until a given time
``` bash
docker logs CONTAINER --since 2021-06-15T00:00 --until 2021-06-15T00:10 | less
```
### Docker Exit Codes

Common exit codes associated with docker containers are:

- Exit `Code 0`: Absence of an attached foreground process
- Exit `Code 1`: Indicates failure due to application error
- Exit `Code 137`: Indicates failure as container received SIGKILL (Manual intervention or ‘oom-killer’ [OUT-OF-MEMORY])
- Exit `Code 139`: Indicates failure as container received SIGSEGV
- Exit `Code 143`: Indicates failure as container received SIGTERM

#### Perform security scan on Docker file with third party Snyk
``` bash
docker scan --file Dockerfile --exclude-base docker-scan:e2e
```
[source](<https://docs.docker.com/engine/scan/?utm_source=docker&utm_medium=inproductad&utm_campaign=totw-docker-scan#how-to-scan-images>)

## Docker-Compose

Orchestrates docker containers.

#### Install Docker-Compose

``` bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

##### Get docker compose version
``` bash
docker-compose version
```
##### Validate config and Build docker-compose stack
``` bash
docker-compose config

# Build the stack
docker-compose build
```

##### Execute a docker-compose with verbosity
``` bash
docker-compose --verbose up --detach
```
#### Show images for a stack
``` bash
docker-compose images
```

#### Remove orphan containers from a stack
``` bash
docker-compose -f setup.yml up --remove-orphans
```
#### Check process info of stack with verbosity
``` bash
docker-compose --verbose top
```

#### Check running containers in a stack
``` bash
docker-compose --verbose ps
```

#### Check logs of a service
``` bash
DOCKER_COMPOSE_FILE=/opt/docker-compose.yaml
SERVICE_NAME="NameInsideDockerCompose"

docker-compose -f $DOCKER_COMPOSE_FILE logs $SERVICE_NAME
```
#### Check logs
``` bash
docker-compose -f $DOCKER_COMPOSE_FILE logs
```
#### Tail/get log in format `log-yyy-mm-dd` The log lives in a special path inside the container. Piped to `less`
``` bash
docker-compose -f $DOCKER_COMPOSE_FILE exec SERVICE_NAME cat "logs/log-$(env TZ="NZT" date +%Y-%m-%d).php" | less
```
#### Pipe contents of a supervisord.log to `less` from within the container to the host shell
``` bash
docker-compose -f $DOCKER_COMPOSE_FILE exec SERVICE_NAME cat "logs/supervisord.log" | less
```
# Kubernetes K8S

#### Get the client version
``` bash
kubectl version
```
## Kubectl commands frequently used
``` bash
kubectl get pods
```
#### Get deployments and show all
``` bash
kubectl get deployments.apps --show-*
```
#### Get deployments and show labels
``` bash
kubectl get deployments.apps --show-labels
```

#### Create a deployment based on a YAML file
``` bash
kubectl create -f wishlist-deployment.yaml
```

#### Get Resource Set
``` bash
kubectl get rs
```

#### Install a chat with `helm`
``` bash
helm install --name "wishlist-chart" -f values.yaml .
```

## Minikube
``` bash
minikube version
```
#### Check status
``` bash
minikube status
```

##### Check for new versions
``` bash
minikube update-check
```
#### Perform minikue update step
``` bash
minikube update
```
#### Do the upgrade
``` bash
minikube upgrade
```

#### Start or stop the minikube system
``` bash
minikube start/stop
```

#### Start minikube if using the Microsoft hyperV
``` bash
minikube start --vm-driver=hyper
```