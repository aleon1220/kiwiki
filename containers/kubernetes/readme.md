- [Kubernetes](#kubernetes)
    - [YAML processing app](#yaml-processing-app)
      - [Get the client version](#get-the-client-version)
  - [Kubectl commands frequently used](#kubectl-commands-frequently-used)
      - [Get deployments and show all](#get-deployments-and-show-all)
      - [Get deployments and show labels](#get-deployments-and-show-labels)
      - [Create a deployment based on a YAML file](#create-a-deployment-based-on-a-yaml-file)
      - [Get Resource Set](#get-resource-set)
      - [Install a chat with `helm`](#install-a-chat-with-helm)
  - [Minikube](#minikube)
      - [Check status](#check-status)
        - [Check for new versions](#check-for-new-versions)
      - [Perform minikue update step](#perform-minikue-update-step)
      - [Do the upgrade](#do-the-upgrade)
      - [Start or stop the minikube system](#start-or-stop-the-minikube-system)
      - [Start minikube if using the Microsoft hyperV](#start-minikube-if-using-the-microsoft-hyperv)

[Kiwiki Home](/../../)

# Kubernetes
Container orchestrator

### YAML processing app

```bash
echo 'yq() {
  docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
}' | tee -a ~/.bashrc && source ~/.bashrc
```
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
[Back to top](#)

[Kiwiki Home](/../../)