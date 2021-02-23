#!/bin/bash

# prompt
PS1='\[\033[01;34m\]\w\[\033[00m\]$ \[\033[01;32m\]'
trap 'echo -ne "\033[00m"' DEBUG

# git
git config --global user.email "guest@example.com"
git config --global user.name "Guest User"

# wait for dvc and highlight to be installed
# clear
# :;: ===================================
# :;: Please wait until DVC is installed.
# :;: ===================================
# until hash dvc &>/dev/null; do sleep 1; done

# We can just use snap to install in a user visible way. 

echo "Let's install DVC for this session from snap"
sleep 1

snap install --classic dvc

# install bash completion for dvc
dvc completion -s bash > /etc/bash_completion.d/dvc

# enable bash completion
source /etc/bash_completion

git clone https://github.com/iterative/example-get-started.git
cd example-get-started/
git checkout -b katacoda-gs-versioning

# clear screen
clear

tree .
dvc version
