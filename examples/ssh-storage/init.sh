#!/bin/bash

# set prompt
cat <<EOF >> ~/.bashrc
PS1='\[\033[01;31m\]root\[\033[00m\]@\[\033[01;33m\]storage-server\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
EOF
source ~/.bashrc

# git
git config --global user.email "root@example.org"
git config --global user.name "Admin User"

# wait for dvc to be installed
clear
:;: ===================================
:;: Please wait until DVC is installed.
:;: ===================================
until hash dvc &>/dev/null; do sleep 1; done

# enable bash completion
source /etc/bash_completion

# clear screen
clear
dvc version
