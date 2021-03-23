#!/bin/bash

# We containerized all requirements, nothing to install

docker volume create project

if [ -e /root/project ] ; then 
    rm -rf /root/project
fi
ln -s /var/lib/docker/volumes/project/_data /root/project

docker pull emresult/dvc-gs-versioning

docker run -d -it --name dvc -v project:/root/project emresult/dvc-gs-versioning

touch /tmp/docker-ready
