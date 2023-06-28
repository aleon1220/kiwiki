# Terraform uses & cheat sheet

## Installation & Set Up

#### Set GPG keys
``` bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

#### Repo access
``` bash
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

#### Get the terraform binary given the version. Use the variable terraform_install_version
``` bash
terraform_install_version="1.4.2"

wget https://releases.hashicorp.com/terraform/${terraform_install_version}/terraform_${terraform_install_version}_linux_amd64.zip

wget https://releases.hashicorp.com/terraform/1.4.2/terraform_1.4.2_linux_amd64.zip
```

#### Unzip the compressed file
``` bash
unzip terraform_*
```

`unzip "terraform_${terraform_install_version}_linux_amd64.zip"`

#### Install the binary
``` bash
terraform_path_LINUX="/usr/bin/terraform"
printf "Is there a terraform path already in the machine $(which terraform)\n"
printf "Printing the variable with the suggested path $terraform_path_LINUX\n"
sudo mv terraform $terraform_path_LINUX
printf "terraform binary has been added to the OS \n"
printf "To validate run the command terraform version \n"
```

#### Create a Terraform Project and access it
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

### Cloud init in terraform cloud
* data aws_ami          =  defines a filter to find the AWS AMI to be used for this instance creation. Usually, AWS EC2 Image builder creates this AMI
* data template_file    = call a .tpl file and initializes the environment variables to be passed to the bash script
* `.*tpl` file          = bash script that sets variables, mounts extra volumes, provisions extra software, clones repos, etc

#### Cloud init logs to check in AWS EC2 instance Debian/ubuntu flavor
``` bash
less /var/log/cloud-init-output.log
less /var/log/cfn-init.log
```

### Initialize your Terraform working directory
#### Initialize directory, pull down providers
``` bash
terraform init
```

#### Initialize terraform dir and skip remote validation
Very useful when working with terraform cloud

``` bash
terraform init --backend=false
```

#### Initialize directory, do not download plugins
``` bash
terraform init -get-plugins=false
```

#### Initialize directory, do not verify plugins for Hashicorp signature
``` bash
terraform init -verify-plugins=false
```

### Plan, Deploy and Cleanup Infrastructure

#### Apply changes without being prompted to enter “yes”
``` bash
terraform apply --auto-approve
```

#### Destroy/cleanup deployment without being prompted for “yes”
``` bash
terraform destroy --auto-approve
```

#### output the deployment plan to plan.out
``` bash
terraform plan -out plan.out
```

#### use the plan.out plan file to deploy infrastructure
``` bash
terraform apply plan.out
```

#### Outputs a destroy plan
``` bash
terraform plan -destroy
```

#### Only apply/deploy changes to the target resource
``` bash
terraform apply -target=aws_instance.my_ec2
```

#### pass a variable via command-line while applying a configuration
``` bash
terraform apply -var my_region_variable=us-east-1
```

#### lock the state file so it can’t be modified by any other Terraform apply or modification action
(possible only where backend allows locking)

``` bash
terraform apply -lock=true
```

#### Do not reconcile state file with real-world resources(helpful with large complex deployments for saving deployment time)
``` bash
terraform apply refresh=false
```

#### Number of simultaneous resource operations
``` bash
terraform apply --parallelism=5
```

#### Reconcile the state in Terraform state file with real-world resources
``` bash
terraform refresh
```

#### Get information about providers used in current configuration
``` bash
terraform providers
```
### Terraform Workspaces
#### create a new workspace
``` bash
terraform workspace new mynewworkspace
```

#### Change to the selected workspace
``` bash
terraform workspace select default
```

#### list out all workspaces
``` bash
terraform workspace list
```

### Terraform State Manipulation
#show details stored in Terraform state for the resource
``` bash
terraform state show aws_instance.my_ec2
```

#### download and output terraform state to a file
``` bash
terraform state pull > terraform.tfstate
```

#### Move a resource tracked via state to different module
``` bash
terraform state mv aws_iam_role.my_ssm_role module.custom_module
```

#### replace an existing provider with another
``` bash
terraform state replace-provider hashicorp/aws registry.custom.com/aws
```

#list out all the resources tracked via the current state file
``` bash
terraform state list
```

#### Unmanage a resource, delete it from Terraform state file
``` bash
terraform state rm  aws_instance.myinstace
```

### Terraform Import And Outputs
#### Import EC2 instance with id i-abcd1234 into the Terraform resource named “new_ec2_instance” of type “aws_instance”
``` bash
terraform import aws_instance.new_ec2_instance i-abcd1234
```

#### same as above, imports a real-world resource into an instance of Terraform resource
``` bash
terraform import 'aws_instance.new_ec2_instance[0]' i-abcd1234
```

#### list all outputs as stated in code
``` bash
terraform output
```

#### list out a specific declared output
``` bash
terraform output instance_public_ip
```

#### list all outputs in JSON format
``` bash
terraform output -json
```

### Terraform Miscelleneous commands
#display Terraform binary version, also warns if version is old
``` bash
terraform version
```
#### download and update modules in the “root” module.
``` bash
terraform get -update=true
```

### Terraform Console(Test out Terraform interpolations)
#echo an expression into terraform console and see its expected result as output
``` bash
echo 'join(",",["foo","bar"])' | terraform console
```
#### Terraform console also has an interactive CLI just enter “terraform console”
``` bash
echo '1 + 5' | terraform console
```

#### display the Public IP against the “my_ec2” Terraform resource as seen in the Terraform state file
``` bash
echo "aws_instance.my_ec2.public_ip" | terraform console
```
### Terraform Graph(Dependency Graphing)
#### produce a PNG diagrams showing relationship and dependencies between Terraform resource in your configuration/code
``` bash
terraform graph | dot -Tpng > graph.png
```

### Terraform Taint/Untaint(mark/unmark resource for recreation -> delete and then recreate)
#### taints resource to be recreated on next apply
``` bash
terraform taint aws_instance.my_ec2
```

#### Remove taint from a resource
``` bash
terraform untaint aws_instance.my_ec2
```

#### forcefully unlock a locked state file, LOCK_ID provided when locking the State file beforehand
``` bash
terraform force-unlock LOCK_ID
```

### [Terraform Cloud](https://app.terraform.io/app)
#### obtain and save API token for Terraform cloud
``` bash
terraform login
```

#### Log out of Terraform Cloud, defaults to hostname app.terraform.io
``` bash
terraform logout
```

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

[Back to top](#)