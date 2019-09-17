#!/bin/bash

# git
git config --global user.email "guest@example.com"
git config --global user.name "Guest User"
#git config color.status always
#git config color.ui always

# prompt
PS1='\033[01;34m\w\033[00m$ \033[01;32m'
trap 'echo -ne "\033[00m"' DEBUG

# dvc
pip3 install dvc
dvc version

# install highlight
apt install --yes highlight
