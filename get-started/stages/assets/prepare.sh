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

### Setup a data storage
:; dvc remote add --default mystorage /tmp/data-storage
:; git commit .dvc/config -m "Configure data storage"

### Push cached files to data storage
:; dvc push -q

### Unzip the code 
:; unzip ../code.zip 
:; rm ../code.zip
:; git add params.yaml src/
:; git commit -m "Add source files to the repository"

### Prepare the virtual environment
:; apt install --yes python3-venv
:; python3 -m venv .env 
:; echo ".env" >> .gitignore
:; git add .gitignore
:; git commit -m "ignored virtual environment"
:; source .env/bin/activate

### Install requirements
:; pip3 install -r src/requirements.txt

### Ready ###
