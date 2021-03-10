#!/bin/bash

# install highlight
apt install --yes highlight

# install dvc
pip3 install --ignore-installed PyYAML
pip3 install --pre dvc

# install bash completion for dvc
wget -O /etc/bash_completion.d/dvc \
    https://raw.githubusercontent.com/iterative/dvc/master/scripts/completion/dvc.bash

# this is about a bug in index.json
rm -f /root/project/play /root/project/prepare.sh /root/project/example-flow.png
