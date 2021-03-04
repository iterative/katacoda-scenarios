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

### Get the code
:; wget -q https://code.dvc.org/get-started/code.zip
:; unzip code.zip
:; rm code.zip
:; git add params.yaml src/
:; git commit -m "Add source code files to repo"

### Install python requirements
:; virtualenv -q -p python3 .env
:; echo ".env/" >> .gitignore
set +o verbose
source .env/bin/activate
set -o verbose
:; pip install -qqq -r src/requirements.txt
:; git add .gitignore
:; git commit -m "Ignore virtualenv directory"

### Stage: prepare
:; dvc run \
       -n prepare \
       -d src/prepare.py \
       -d data/data.xml \
       -o data/prepared \
       python \
           src/prepare.py \
           data/data.xml
:; git add data/.gitignore dvc.yaml dvc.lock
:; git commit -m "Create data preparation stage"
:; dvc push -q

### Stage: featurize
:; dvc run \
       -n featurize \
       -d src/featurization.py \
       -d data/prepared \
       -o data/features \
       python \
           src/featurization.py \
           data/prepared \
           data/features
:; git add data/.gitignore dvc.yaml dvc.lock

### Stage: train
:; dvc run \
       -n train \
       -d src/train.py \
       -d data/features \
       -o model.pkl \
       python \
           src/train.py \
           data/features \
           model.pkl
:; git add data/.gitignore dvc.yaml dvc.lock
:; git commit -m "Create featurization and training stages"
:; dvc push -q

### Reproducing the model
:; sed -i data/data.xml -e '1d'
:; dvc repro
:; git add .
:; git commit -m "Produced another version of model.pkl"
:; dvc push -q
