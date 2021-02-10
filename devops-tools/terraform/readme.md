# Terraform uses and cheat sheet
You may follow the steps in order

## Installation
```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
wget https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip
unzip terraform_0.14.6_linux_amd64.zip
terraform_path_UBUNTU="/usr/bin/terraform"
printf "$(which terraform)\n"
printf "$terraform_path_UBUNTU\n"
sudo mv terraform $(which terraform) || $terraform_path_UBUNTU
```

### Create a TerraformProject and access it
`mkdir aTerraformProject && cd $_`

## Init terraform repo
`terraform init`

## Create a terraform plan, save it to a plan file and then show the plan
`terraform plan -out $(date +%F-%H_%M)-a-terraform-plan.plan; terraform show`

## Format and validate the configuration
`terraform fmt; terraform validate`

## Apply the plan and provision the infrastructure
`terraform apply`

## Graph the terraform plan and open it in [Webgraphviz](http://webgraphviz.com/)
`terraform graph`

## Destroy the infrastructure provisioned with terraform
`terraform destroy`

# AWS Provider
Configuration process creates a file at `~/.aws/credentials`

