#!/bin/bash
# Second user setup

set -o verbose

### Setup the SSH config:

:; mkdir ~/.ssh
:; chmod 700 ~/.ssh/
:; cat <<EOF >> ~/.ssh/config
Host git-server
    HostName host01
    User user2
    IdentityFile ~/.ssh/git-server
    IdentitiesOnly yes 

Host dvc-server
    HostName host01
    User user2
    IdentityFile ~/.ssh/dvc-server
    IdentitiesOnly yes 
EOF

## Generate SSH keys:

:; ssh-keygen -t rsa -q -N '' -f ~/.ssh/git-server
:; ssh-keygen -t rsa -q -N '' -f ~/.ssh/dvc-server
:; ls -al ~/.ssh/

## Send the public keys to the server:

:; echo pass2 | sshpass ssh-copy-id -i ~/.ssh/git-server.pub -o StrictHostKeyChecking=no git-server
:; echo pass2 | sshpass ssh-copy-id -i ~/.ssh/dvc-server.pub -o StrictHostKeyChecking=no dvc-server

### Clone the Git project

:; git clone git-server:/srv/project.git

### Done
