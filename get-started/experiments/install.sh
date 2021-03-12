#!/bin/bash

# install highlight
apt update
apt install --yes highlight graphviz

# install dvc
pip3 install --ignore-installed PyYAML
pip3 install dvc

dvc completion > /etc/bash_completion.d/dvc

unzip -o project.zip

# this is to fix a bug in index.json
rm -f /root/project/play /root/project/prepare.sh /root/project/example-flow.png
