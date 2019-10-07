#!/bin/bash
# rerun the commands of the previous parts

set -o verbose
:; dvc version

### initialize git project
:; mkdir example-get-started
:; cd example-get-started/
:; git init

### initialize dvc
:; dvc init -q
:; git commit -m "Initialize DVC project"
