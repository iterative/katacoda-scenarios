#!/bin/bash

# install bash completion for dvc
wget -O /etc/bash_completion.d/dvc \
    https://raw.githubusercontent.com/iterative/dvc/master/scripts/completion/dvc.bash
source /etc/bash_completion

# git
git config --global user.email "guest@example.com"
git config --global user.name "Guest User"

# prompt
PS1='\033[01;34m\w\033[00m$ \033[01;32m'
trap 'echo -ne "\033[00m"' DEBUG

# install dvc
pip3 install dvc

# wait for highlight to be installed
until which highlight; do sleep 1; done

# clear screen
clear

# auto-play preparation steps
DELAY=0.7 play prepare.sh
