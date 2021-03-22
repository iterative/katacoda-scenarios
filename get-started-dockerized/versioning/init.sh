#!/bin/bash

# prompt
# PS1='\[\033[01;34m\]\w\[\033[00m\]$ \[\033[01;32m\]'
# trap 'echo -ne "\033[00m"' DEBUG

docker volume create project
docker run -it --name dvcversioning -v project:/root/project emresult/dvc-gs-versioning
ln -s /var/lib/docker/volumes/project/_data /root/project
