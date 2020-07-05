#!/bin/bash

apt install --yes highlight virtualenv

# install dvc
sudo wget https://dvc.org/deb/dvc.list \
          -O /etc/apt/sources.list.d/dvc.list
sudo apt-get update -o Dir::Etc::sourcelist="sources.list.d/dvc.list" \
    -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
sudo apt install dvc

# install bash completion for dvc
dvc completion -s bash > /etc/bash_completion.d/dvc
