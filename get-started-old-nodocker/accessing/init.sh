#!/bin/bash

# prompt
PS1='\[\033[01;34m\]\w\[\033[00m\]$ \[\033[01;32m\]'
trap 'echo -ne "\033[00m"' DEBUG

# git
git config --global user.email "guest@example.com"
git config --global user.name "Guest User"

# wait for DVC and highlight to be installed
clear
:;: ===================================
:;: Please wait until DVC is installed.
:;: ===================================
until hash dvc &>/dev/null; do sleep 1; done

# enable bash completion
source /etc/bash_completion

# git clone --branch 3-config-remote \
#     https://github.com/iterative/example-get-started.git
# cd example-get-started/
# git reset –-hard 3-config-remote
# cd ..

git init project
cd project

# clear screen
clear

ls
dvc version
