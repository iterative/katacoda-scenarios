#!/bin/bash

export CONTAINER="emresult/katacoda-gs-accessing"

docker volume create example-get-started

if [ -e /root/example-get-started ] ; then 
    rm -rf /root/example-get-started
fi
ln -s /var/lib/docker/volumes/example-get-started/_data /root/example-get-started

docker run -d -it --name dvc -v example-get-started:/root/example-get-started "$CONTAINER"

touch /tmp/docker-ready
