#!/bin/bash

# install highlight and virtualenv
apt install --yes highlight virtualenv

# install bash completion for dvc
wget -O /etc/bash_completion.d/dvc \
    https://raw.githubusercontent.com/iterative/dvc/master/scripts/completion/dvc.bash

# install dvc
pip3 install --ignore-installed PyYAML
pip3 install dvc
