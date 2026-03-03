
#!/bin/bash
dnf install ansible -y 
ansible-pull -U https://github.com/Pavankotha9550/terraform-ansible-roles.git -e component=$1 main.yaml