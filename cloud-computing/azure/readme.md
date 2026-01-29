[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Azure Cloud
> suggest to run from cloud shell

#### Sign In with credentials on the command line
``` bash
az login -u <username> -p <password>
```

## Authenticate with a Service Principal
Azure service principal is an identity created for use with applications, hosted services, and automated tools. 

this is a common pattern. Documentation [create a service principal](https://www.pulumi.com/docs/iac/get-started/azure/configure/#:~:text=create%20a%20service%20principal) provides insights on how to proceed. User must have enough permissions to proceed.

#### get info about subscription
```bash
az account show | jq
```

## Azure Portal [Home - Microsoft Azure](https://portal.azure.com/#home)

### Create a Linux Ubuntu LTS VM

```bash
az vm create \
  --resource-group learn-e3d9d9e8-7d24-4940-981b-558289f6e549 \
  --name my-vm \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys
```

### Obtain the VM's IP address

```bash
IPADDRESS="$(az vm list-ip-addresses \
  --resource-group learn-e3d9d9e8-7d24-4940-981b-558289f6e549 \
  --name my-vm \
  --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
  --output tsv)"
```

### retrieve a list of fault domains per region

```bash
az vm list-skus --resource-type availabilitySets --query '[?name==`Aligned`].{Location:locationInfo[0].location, MaximumFaultDomainCount:capabilities[0].value}' --output Table
```

# Networking
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

# Resource group management

### List all resource groups located in the West US region

```bash
az group list --query "[?location=='westus']"
```

### Obtain Authentication info 
e.g. ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_SUBSCRIPTION_ID
```bash
todo1
```

### todo2

```bash

```

### todo3

```bash

```

### todo4

```bash

```

### todo5

```bash

```

### todo6

```bash

```

### todo7

```bash

```

[Back to top](#)

[Kiwiki Home](/../../)
