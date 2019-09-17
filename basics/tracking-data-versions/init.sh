#!/bin/bash

PS1='\[\033[01;34m\]\w\[\033[00m\]$ '

git config --global user.email "guest@example.com"
git config --global user.name "Guest User"

pip3 install dvc

dvc version
