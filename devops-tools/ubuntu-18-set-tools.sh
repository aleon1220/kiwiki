#!/bin/bash

# Set Up my required Tools

# VSCode
## Extensions
plugin_terraform=ms-azuretools.vscode-azureterraform
plugin_powershell=ms-vscode.PowerShell
### https://marketplace.visualstudio.com/items?itemName=Atlassian.atlascode
plugin_atlasssian=Atlassian.atlascode
### https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker
### https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml
plugin_docker=ms-azuretools.vscode-docker
plugin_yaml=redhat.vscode-yaml
### https://marketplace.visualstudio.com/items?itemName=ms-python.python
plugin_python=ms-python.python
### https://marketplace.visualstudio.com/items?itemName=aws-scripting-guy.cform    
plugin_aws=aws-scripting-guy.cform
### https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql
ms-mssql.mssql

# Install extensions
code --install-extension $plugin_terraform  $plugin_powershell

## code Android extensions suggested
code --install-extension naco-siren.gradle-language mathiasfrohlich.Kotlin vscjava.vscode-java-pack
### verify https://code.visualstudio.com/docs/editor/extension-gallery#_command-line-extension-management
code --list-extensions

# AWS CLI
## https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

## AWS CLI command completion
echo $SHELL
which aws_completer
# Add the completer's folder to your path
export PATH=/usr/local/bin:$PATH
 source ~/.bashrc
# source ~/.bash_profile

# Enable command completion
complete -C '/usr/local/bin/aws_completer' aws

# Docker latest
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https ca-certificates \
    curl gnupg-agent software-properties-common

## Add Dockers PGP
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
## Check fingerprint 
sudo apt-key fingerprint 0EBFCD88
## Add Repo
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
## Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
## Post-install settings
sudo groupadd docker
sudo usermod -aG docker $USER

# Docker-compose latest
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
## verify
docker-compose --version

# Terraform
## Add the HashiCorp GPG key.
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
## Verify
terraform -help
## Enable tab completion
terraform -install-autocomplete