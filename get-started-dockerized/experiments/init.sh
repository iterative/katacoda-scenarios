#!/bin/bash

# prompt
PS1='\[\033[01;34m\]\w\[\033[00m\]$ \[\033[01;32m\]'
trap 'echo -ne "\033[00m"' DEBUG

# git
git config --global user.email "guest@example.com"
git config --global user.name "Guest User"

### Download the project data and code

PROJECT_DOWNLOAD_URL="http://one.emresult.com/~iex/project-experiments.zip"

curl --silent "$PROJECT_DOWNLOAD_URL" --output project.zip
unzip -o project.zip 
rm -f project.zip

cd project

# wait for dvc and highlight to be installed
clear
:;: ===================================
:;: Please wait until DVC is installed.
:;: ===================================
until hash dvc &>/dev/null; do sleep 1; done

# enable bash completion
source /etc/bash_completion

# clear screen
clear

# auto-play preparation steps
DELAY=0 play prepare.sh
