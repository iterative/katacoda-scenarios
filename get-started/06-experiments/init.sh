#!/bin/bash

# prompt
PS1='\[\033[01;34m\]\w\[\033[00m\]$ \[\033[01;32m\]'
trap 'echo -ne "\033[00m"' DEBUG

clear 

# :;: ###########################################
# :;:    INSTALLING CONTAINER FOR THE SCENARIO   
# :;: ###########################################
# until [ -f /tmp/docker-ready ] ; do echo -n "." ; sleep 1 ; done
#
# clear
#
# docker attach dvc
docker run -it emresult/get-started-mnist
