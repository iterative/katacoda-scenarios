#!/bin/bash
# We already downloaded and extracted the project to ~/project 

set -o verbose

### Starting web server to show plots
:; nohup python3 -m http.server -d /root/project/ 80 &> /dev/null &

### Checking the DVC version
:; dvc version

### Ready ###
