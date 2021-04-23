#!/bin/bash

# prompt
PS1='\[\033[01;34m\]\w\[\033[00m\]$ \[\033[01;32m\]'
trap 'echo -ne "\033[00m"' DEBUG

clear 

:;: ###########################################
:;:    INSTALLING CONTAINER FOR THE SCENARIO   
:;: ###########################################
# until [ -f /tmp/docker-ready ] ; do echo -n "." ; sleep 1 ; done

echo "Starting: $CONTAINER"

docker run -d -it --name dvc -v example-get-started:/root/example-get-started "$CONTAINER"

clear

docker attach dvc
