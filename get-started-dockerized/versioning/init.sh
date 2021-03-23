#!/bin/bash

set +vx

# prompt
PS1='\[\033[01;34m\]\w\[\033[00m\]$ \[\033[01;32m\]'
trap 'echo -ne "\033[00m"' DEBUG

:;: "###########################################"
:;: "## INSTALLING CONTAINER FOR THE SCENARIO ##"
:;: "## $ docker run -it dvcorg/gs-versioning ##"
:;: "###########################################"
until [ -f /tmp/docker-ready ] ; do echo -n "." ; sleep 1 ; done

docker attach dvc
