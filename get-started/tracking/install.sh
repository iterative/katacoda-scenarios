#!/bin/bash

# install highlight and dos2unix
apt install --yes highlight dos2unix

# install bash completion for dvc
wget -O /etc/bash_completion.d/dvc \
    https://raw.githubusercontent.com/iterative/dvc/master/scripts/completion/dvc.bash

# install dvc
pip3 install dvc
