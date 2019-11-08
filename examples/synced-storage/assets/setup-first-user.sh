#!/bin/bash
# First user setup

set -o verbose

### Setup SSH config:

:; mkdir ~/.ssh
:; chmod 700 ~/.ssh/
:; cat <<EOF >> ~/.ssh/config
Host git-server
    HostName host01
    User user1
    IdentityFile ~/.ssh/git-server
    IdentitiesOnly yes 

Host dvc-server
    HostName host01
    User user1
    IdentityFile ~/.ssh/dvc-server
    IdentitiesOnly yes 
EOF

### Generate SSH keys:

:; ssh-keygen -t rsa -q -N '' -f ~/.ssh/git-server
:; ssh-keygen -t rsa -q -N '' -f ~/.ssh/dvc-server
:; ls -al ~/.ssh/

### Send public keys to the server:

:; echo pass1 | sshpass ssh-copy-id -i ~/.ssh/git-server.pub -o StrictHostKeyChecking=no git-server
:; echo pass1 | sshpass ssh-copy-id -i ~/.ssh/dvc-server.pub -o StrictHostKeyChecking=no dvc-server

### Initialize the project:

:; mkdir project
:; cd project/
:; git init
:; dvc init -q
:; git commit -m 'Initialize DVC'
:; git remote add origin git-server:/srv/project.git
:; git push --set-upstream origin master

### Done
