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

:; pip3 install -q wheel
:; pip3 install -q -r src/requirements.txt

:; git add *
:; git commit -m "Beginning of the params-metrics-plots scenario"

### Starting web server to show plots
:; nohup python3 -m http.server -d /root/ 80 &> /dev/null &

### Checking the DVC version
:; dvc version

### Ready ###
