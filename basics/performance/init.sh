#!/bin/bash

# install bash competion for dvc
wget -O /etc/bash_completion.d/dvc \
    https://raw.githubusercontent.com/iterative/dvc/master/scripts/completion/dvc.bash
source /etc/bash_completion

# prompt
PS1='\033[01;34m\w\033[00m$ \033[01;32m'
trap 'echo -ne "\033[00m"' DEBUG

# dvc
pip3 install dvc

# clear the screen
clear

# show the version
dvc version
