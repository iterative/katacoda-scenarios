#!/bin/bash

# prompt
# PS1='\[\033[01;34m\]\w\[\033[00m\]$ \[\033[01;32m\]'
# trap 'echo -ne "\033[00m"' DEBUG

docker run -it --name dvcversioning emresult/dvc-gs-versioning
