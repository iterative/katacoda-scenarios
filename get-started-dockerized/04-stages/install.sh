#!/bin/bash

export CONTAINER="emresult/katacoda-gs-stages"

docker volume create project

if [ -e /root/project ] ; then 
    rm -rf /root/project
fi
ln -s /var/lib/docker/volumes/project/_data /root/project

docker run -d -it --name dvc -v project:/root/project "$CONTAINER"

touch /tmp/docker-ready
