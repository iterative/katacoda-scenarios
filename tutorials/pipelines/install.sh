#!/bin/bash

# install virtualenv
apt install --yes virtualenv

# install bash completion for dvc
wget -O /etc/bash_completion.d/dvc \
    https://raw.githubusercontent.com/iterative/dvc/master/scripts/completion/dvc.bash

# install dvc
pip3 install dvc
