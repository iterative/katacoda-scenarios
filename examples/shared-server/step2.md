# Create a simple project

1. Let's initialize a project on the `$DATA` directory:

   `mkdir $DATA/project`{{execute}}
   
   `cd $DATA/project/`{{execute}}
   
   `git init`{{execute}}
   
   `dvc init -q`{{execute}}
   
   `git commit -m 'Initialize DVC'`{{execute}}
   
2. Add a default data storage:
   
   `mkdir -p $DATA/dvc-storage`{{execute}}
   
   ```
   dvc remote add --default \
       storage $DATA/dvc-storage
   ```{{execute}}
   
   `dvc remote list`{{execute}}
   
   `git status -s`{{execute}}
   
   `git diff .dvc/config`{{execute}}
   
   `git add .dvc/config`{{execute}}
   
   `git commit -m 'Setup a default storage'`{{execute}}

3. Make the Git repository bare:
   
   `cd ..`{{execute}}
   
   `ls -l`{{execute}}
   
   `git clone --bare project project.git`{{execute}}
   
   `ls -l project.git/`{{execute}}
   
   `rm -rf project/`{{execute}}
   
   `ls -l`{{execute}}
