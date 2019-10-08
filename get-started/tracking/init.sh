#!/bin/bash

# prompt
PS1='\033[01;34m\w\033[00m$ \033[01;32m'
trap 'echo -ne "\033[00m"' DEBUG

# git
git config --global user.email "guest@example.com"
git config --global user.name "Guest User"

# wait for dvc and highlight to be installed
:
: DVC and other stuff are being installed. Please be a bit patient.
:
:
until hash dvc &>/dev/null; do sleep 2; done
until hash highlight &>/dev/null; do sleep 2; done

# enable bash completion
source /etc/bash_completion

# clear screen
sleep 2
clear

# auto-play preparation steps
dvc version
mkdir example-get-started/
cd example-get-started/
DELAY=0.7 play prepare.sh
