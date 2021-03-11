#!/bin/bash
# We already downloaded and extracted the project to ~/project 

set -o verbose

### Download the project data and code

PROJECT_DOWNLOAD_URL="http://one.emresult.com/~iex/project-experiments.zip"

curl --silent "$PROJECT_DOWNLOAD_URL" --output project.zip
unzip -o project.zip 
rm -f project.zip

cd project

### Starting web server to show plots
:; nohup python3 -m http.server -d /root/project/ 80 &> /dev/null &

### Checking the DVC version
:; dvc version

### Ready ###
