# Ansible
[Ansible website](www.ansible.com)

#### Add the repo and install Ubuntu
``` bash
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

#### Execute a playbook. Prompt for the password if any of the servers require Pass auth
The command below connects to servers that have private_ssh_key authentication and pass auth
`hosts-physical` uses the INI format and it specifies the user with `ansible_user=linuxUserFoo`
there is a default `ansible.cfg`

the flag `--ask-pass` was needed as some of the servers require a password for authentication.

``` bash
INVENTORY_FILE="hosts-physical"
ansible-playbook playbooks/ping.yml -i $INVENTORY_FILE --ask-pass
```

A successful execution ignoring the warnings look like this
``` bash
TASK [Ping all servers] **********************************************************************************************************************************ok: [control]
ok: [odin]
ok: [thor]
ok: [devops]

PLAY RECAP ***********************************************************************************************************************************************control                    : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
server00-devops                     : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
server01-odin                       : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
server02-thor                       : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

[Back to top](#)

[Kiwiki Home](/../../)