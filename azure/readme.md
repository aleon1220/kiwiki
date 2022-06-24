# Cloud Provider Azure

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

### get your VM's IP address

```bash
IPADDRESS="$(az vm list-ip-addresses \
  --resource-group learn-e3d9d9e8-7d24-4940-981b-558289f6e549 \
  --name my-vm \
  --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
  --output tsv)"
```

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

### todo

```bash

```

### todo

```bash

```

### todo

```bash

```

### todo

```bash

```

### todo

```bash

```

### todo

```bash

```

### todo

```bash

```

### todo

```bash

```

### todo

```bash

```

[Back to top](#)