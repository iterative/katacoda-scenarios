#!/bin/bash
# rerun the commands of the previous parts

set -o verbose

### Initialize a Git project
:; git init

### Initialize DVC
:; dvc init -q
:; git commit -m "Initialize DVC project"

### Get a data file
:; mkdir data
:; dvc get -q \
       https://github.com/iterative/dataset-registry \
       get-started/data.xml \
       -o data/data.xml

### Make it smaller
:; head -n 12000 data/data.xml > data/data.xml.1
:; mv data/data.xml.1 data/data.xml

### Track a data file
:; dvc add data/data.xml

### Commit to Git
:; git add data/.gitignore data/data.xml.dvc
:; git commit -m "Add raw data to project"

:; git add params.yaml src/
:; git commit -m "Add source files to the repository"

### Install requirements
### Normally this should be done in a virtual environment
### But here we're already in a container
:; pip3 install wheel
:; pip3 install -r src/requirements.txt

### Starting web server to show images
:; nohup python3 -m http.server -d /root/ 80 &> /dev/null &

### Checking the DVC version
:; dvc version

### Ready ###
