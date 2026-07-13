# Azure Cloud

> suggest to run from cloud shell

## Azure CLI

### Azure Authentication Methods

* Sign In with credentials on the command line

``` bash
az login
```

> deprecated `-u <username> -p <password>`

### Default Azure Credential

* set the values

```bash
export ARM_CLIENT_ID="Application Client ID"
export ARM_CLIENT_SECRET="Secret"
export ARM_SUBSCRIPTION_ID="azure_subscription_id"
```

* the tenant ID can be obtained programatically. When is not possible user must login to portal.azure.com

```bash
DOMAIN_TENANT="realhandsonlabs.com" && export ARM_TENANT_ID=$(curl -s "https://login.microsoftonline.com/${DOMAIN_TENANT}/.well-known/openid-configuration" | grep -o 'https://sts.windows.net/[^/]*' | cut -d '/' -f 4) && echo $ARM_TENANT_ID
```

### Authenticate with a Service Principal

Azure service principal is an identity created for use with applications, hosted services, and automated tools. 

this is a common pattern. Documentation [create a service principal](https://www.pulumi.com/docs/iac/get-started/azure/configure/#:~:text=create%20a%20service%20principal) provides insights on how to proceed. User must have enough permissions to proceed.

* create a service principal

fails because of permissions in EntraID

```bash
az ad sp create-for-rbac --name serv-principal-iac --role contributor --scopes /subscriptions/1d27a383-6d0b-4da7-a710-4b29d724d3f8/resourceGroups/devops-sre-platform-engineering-research

Insufficient privileges to complete the operation
```

## general commands

### Resource group management

### List all resource groups located in the West US region

```bash
az group list --query "[?location=='westus']"
```

* obtain first rg name

```bash
az group list --query "[0].name" --output tsv
```

### Obtain Authentication info

e.g. ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID

```bash
todo1
```

* get info about subscription

```bash
az account show | jq
```

## Azure Portal [Home * Microsoft Azure](https://portal.azure.com/#home)

## Azure Kubernetes AKS

* Get cluster details.

```bash
az aks show -g <ResourceGroup> -n <ClusterName> -o table
```

* Merge credentials into kubeconfig

```bash
az aks get-credentials -g <ResourceGroup> -n <ClusterName>
```

* uses Entra ID (Azure AD) and you need emergency admin access

```bash
az aks get-credentials -g <ResourceGroup> -n <ClusterName> --admin
```

* List all node pools

```bash
az aks nodepool list -g <ResourceGroup> --cluster-name <ClusterName> -o table
```

* List enabled add-ons

```bash
az aks addon list -g <ResourceGroup> -n <ClusterName> -o table
```

* Open Kubernetes Dashboard

```bash
az aks browse -g <ResourceGroup> -n <ClusterName>
```

* Run the AI diagnostic agent

```bash
az aks agent run
```

## Azure VM

* Create a Linux Ubuntu LTS VM

```bash
az vm create \
  --resource-group learn-e3d9d9e8-7d24-4940-981b-558289f6e549 \
  --name my-vm \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys
```

* Obtain the VM's IP address

```bash
IPADDRESS="$(az vm list-ip-addresses \
  --resource-group learn-e3d9d9e8-7d24-4940-981b-558289f6e549 \
  --name my-vm \
  --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
  --output tsv)"
```

* retrieve a list of fault domains per region

```bash
az vm list-skus --resource-type availabilitySets --query '[?name==`Aligned`].{Location:locationInfo[0].location, MaximumFaultDomainCount:capabilities[0].value}' --output Table
```

## Azure Networking

### List the current network security group rules

```bash
az network nsg list \
  --resource-group learn-e3d9d9e8-7d24-4940-981b-558289f6e549 \
  --query '[].name' \
  --output tsv
```

### list the rules associated with a given NSG

```bash
az network nsg rule list \
  --resource-group learn-e3d9d9e8-7d24-4940-981b-558289f6e549 \
  --nsg-name my-vmNSG
```

### Retrieve NSG name, priority, affected ports, and access (Allow or Deny)

```bash
az network nsg rule list \
  --resource-group learn-e3d9d9e8-7d24-4940-981b-558289f6e549 \
  --nsg-name my-vmNSG \
  --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' \
  --output table
```

---

* todo2_reusable

```bash

```
