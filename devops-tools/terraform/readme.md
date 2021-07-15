# Terraform uses & cheat sheet

## Installation

#### Set gpg keys and repo access
``` bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

#### Get the terraform binary
``` bash
wget https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip
unzip terraform_0.14.6_linux_amd64.zip
```
### Get Terraform with CLI copy/paste steps
#### Define the version, get the binary
``` bash
version="0.15.0"
wget https://releases.hashicorp.com/terraform/$version/terraform_${version}_linux_amd64.zip
```
#### unzip the file and install the binary
``` bash
unzip "terraform_${version}_linux_amd64.zip"
terraform_path_UBUNTU="/usr/bin/terraform"
printf "$(which terraform)\n"
printf "$terraform_path_UBUNTU\n"
sudo mv terraform $(which terraform) || $terraform_path_UBUNTU
```

#### Create a TerraformProject and access it
``` bash
mkdir aTerraformProject && cd $_
```

#### Init terraform repo
``` bash
terraform init
```

#### Create a terraform plan, save it to a plan file and then show the plan
``` bash
terraform plan -out $(date +%F-%H_%M)-a-terraform-plan.plan; terraform show
```

#### Format and validate the configuration
Format code per HCL canonical standard
``` bash
terraform fmt; terraform validate
```

#### Apply the plan and provision the infrastructure
``` bash
terraform apply
```

#### Graph the terraform plan. Open with [Webgraphviz](http://webgraphviz.com/)
``` bash
terraform graph
```

#### Destroy the infrastructure provisioned with terraform
``` bash
terraform destroy
```

## AWS Provider
Configuration process creates a file at `~/.aws/credentials`

### Setup tab auto-completion, requires logging back in
``` bash
terraform -install-autocomplete 
```
#### validate code skip backend validation
terraform validate -backend=false 

Initialize your Terraform working directory
#initialize directory, pull down providers

terraform init 

#initialize directory, do not download plugins
terraform init -get-plugins=false

#initialize directory, do not verify plugins for Hashicorp signature
terraform init -verify-plugins=false

Plan, Deploy and Cleanup Infrastructure

#apply changes without being prompted to enter “yes”
terraform apply --auto-approve 

#destroy/cleanup deployment without being prompted for “yes”
terraform destroy --auto-approve

#output the deployment plan to plan.out
terraform plan -out plan.out

#use the plan.out plan file to deploy infrastructure
terraform apply plan.out

#outputs a destroy plan
terraform plan -destroy

#only apply/deploy changes to the targeted resource
terraform apply -target=aws_instance.my_ec2

#pass a variable via command-line while applying a configuration
terraform apply -var my_region_variable=us-east-1

#### lock the state file so it can’t be modified by any other Terraform apply or modification action
(possible only where backend allows locking)

terraform apply -lock=true 

# do not reconcile state file with real-world resources(helpful with large complex deployments for saving deployment time)
terraform apply refresh=false 

#number of simultaneous resource operations
terraform apply --parallelism=5 

#reconcile the state in Terraform state file with real-world resources
terraform refresh

#get information about providers used in current configuration
terraform providers 

### Terraform Workspaces
#### create a new workspace
terraform workspace new mynewworkspace

#### Change to the selected workspace
terraform workspace select default 

#### list out all workspaces
terraform workspace list

### Terraform State Manipulation
#show details stored in Terraform state for the resource
terraform state show aws_instance.my_ec2 

#download and output terraform state to a file
terraform state pull > terraform.tfstate

#move a resource tracked via state to different module
terraform state mv aws_iam_role.my_ssm_role module.custom_module

#replace an existing provider with another
terraform state replace-provider hashicorp/aws registry.custom.com/aws 

#list out all the resources tracked via the current state file
terraform state list 

#### Unmanage a resource, delete it from Terraform state file
terraform state rm  aws_instance.myinstace 

### Terraform Import And Outputs
#### Import EC2 instance with id i-abcd1234 into the Terraform resource named “new_ec2_instance” of type “aws_instance”
terraform import aws_instance.new_ec2_instance i-abcd1234 

#same as above, imports a real-world resource into an instance of Terraform resource
terraform import 'aws_instance.new_ec2_instance[0]' i-abcd1234 

#list all outputs as stated in code
terraform output 

# list out a specific declared output
terraform output instance_public_ip

#list all outputs in JSON format
terraform output -json

### Terraform Miscelleneous commands
#display Terraform binary version, also warns if version is old
terraform version 

#download and update modules in the “root” module.
terraform get -update=true

### Terraform Console(Test out Terraform interpolations)
#echo an expression into terraform console and see its expected result as output
echo 'join(",",["foo","bar"])' | terraform console

#Terraform console also has an interactive CLI just enter “terraform console”
echo '1 + 5' | terraform console 

#display the Public IP against the “my_ec2” Terraform resource as seen in the Terraform state file
echo "aws_instance.my_ec2.public_ip" | terraform console 

### Terraform Graph(Dependency Graphing)
#produce a PNG diagrams showing relationship and dependencies between Terraform resource in your configuration/code
terraform graph | dot -Tpng > graph.png 


### Terraform Taint/Untaint(mark/unmark resource for recreation -> delete and then recreate)
#taints resource to be recreated on next apply
terraform taint aws_instance.my_ec2 

#Remove taint from a resource
terraform untaint aws_instance.my_ec2 

#forcefully unlock a locked state file, LOCK_ID provided when locking the State file beforehand
terraform force-unlock LOCK_ID 

### [Terraform Cloud](https://app.terraform.io/app)
#obtain and save API token for Terraform cloud
terraform login 

#Log out of Terraform Cloud, defaults to hostname app.terraform.io
terraform logout 

## Terraform Docker Provider
#### Lock the provider to a specific version
``` terraform
required_providers {
# We recommend pinning to the specific version of the Docker Provider you're using
# Since new versions are released frequently

  docker = {
    source  = "kreuzwerker/docker"
    version = "2.8.0"
  }
}
```