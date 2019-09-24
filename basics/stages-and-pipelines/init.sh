#!/bin/bash

# git
git config --global user.email "guest@example.com"
git config --global user.name "Guest User"

# prompt
PS1='\033[01;34m\w\033[00m$ \033[01;32m'
trap 'echo -ne "\033[00m"' DEBUG

# install dvc
pip3 install dvc

# clear the screen
clear

# show dvc version
dvc version
