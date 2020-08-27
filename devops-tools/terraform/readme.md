# Terraform uses and cheat sheet
You may follow the steps in order

## Create aTerraformProject and access it
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
Configuration process creates a file at ~/.aws/credentials

