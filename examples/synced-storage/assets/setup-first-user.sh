#!/bin/bash
# Setup for the first user

set -o verbose

### Set up ssh keys for the Git server

## Setup the ssh config:

:; mkdir ~/.ssh
:; chmod 700 ~/.ssh/
:; cat <<EOF >> ~/.ssh/config
Host git-server
    HostName host01
    User user1
    IdentityFile ~/.ssh/git-server
    IdentitiesOnly yes 
EOF
:; cat ~/.ssh/config

## Generate a SSH key pair:

:; ssh-keygen -t rsa -q -N '' -f ~/.ssh/git-server
:; ls -al ~/.ssh/

## Send the public key to the server:

:; echo pass1 | sshpass ssh-copy-id -i ~/.ssh/git-server.pub -o StrictHostKeyChecking=no git-server

## Try to ssh with the new key:

:; ssh git-server ls -al .ssh/
:; ssh git-server cat .ssh/authorized_keys

### Create the Git project

:; mkdir project
:; cd project/
:; git init
:; dvc init -q
:; git commit -m 'Initialize DVC'
:; git remote add origin git-server:/srv/project.git
:; git remote -v
:; git push origin master

### Set up ssh keys for the DVC server

## Setup the ssh config:

:; cat <<EOF >> ~/.ssh/config

Host dvc-server
    HostName host01
    User user1
    IdentityFile ~/.ssh/dvc-server
    IdentitiesOnly yes 
EOF
:; cat ~/.ssh/config

## Generate a SSH key pair:

:; ssh-keygen -t rsa -q -N '' -f ~/.ssh/dvc-server
:; ls -al ~/.ssh/

## Send the public key to the server:

:; echo pass1 | sshpass ssh-copy-id -i ~/.ssh/dvc-server.pub -o StrictHostKeyChecking=no dvc-server

## Try to ssh with the new key:

:; ssh dvc-server ls -al .ssh/
:; ssh dvc-server cat .ssh/authorized_keys

### Setup the remote DVC cache on the project

:; cd ~/project/
:; dvc remote list
:; dvc remote add -d ssh-cache ssh://dvc-server:/srv/project.cache
:; dvc remote list
:; dvc status -c

: Note that we didn't tell DVC the username and the key-file of the
: SSH connection, however they are specified on the SSH config file,
: so it already knows how to connect to the server:

:; cat ~/.ssh/config

## Let's commit this configuration to Git:

:; git status -s
:; git diff .dvc/config
:; git add .dvc/config
:; git commit -m 'Add a SSH remote cache'
:; git push --set-upstream origin master

### Done
