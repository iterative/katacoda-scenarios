#!/bin/bash
# rerun the commands of the previous parts

set -o verbose

### initialize git project
:; git init

### initialize dvc
:; dvc init -q
:; git commit -m "Initialize DVC project"

### done
