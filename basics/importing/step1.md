# Prepare

1. Let's initialize a project:
   
   `mkdir proj1`{{execute}}
   
   `cd proj1`{{execute}}
   
   `git init`{{execute}}
   
   `dvc init -q`{{execute}}
   
   `git status`{{execute}}
   
   `git commit -m 'Initialize DVC'`{{execute}}
   
2. Setup a default data storage:
   
   `mkdir /root/dvc-storage`{{execute}}
      
   `dvc remote list`{{execute}}
   
   ```
   dvc remote add --default \
       storage /root/dvc-storage
   ```{{execute}}
   
   `dvc remote list`{{execute}}
   
   `git status`{{execute}}
   
   `git diff .dvc/config`{{execute}}
   
   `git add .dvc/config`{{execute}}
   
   ```
   git commit \
       -m 'Set a default storage'
   ```{{execute}}
   ```
   
3. Add a data file and make several versions of it:
   
   `play init-git-repo.sh`{{execute}}
   
   `ls -al`{{execute}}

   `git tag`{{execute}}
   
   `git log --oneline`{{execute}}
   
   `dvc status`{{execute}}
   
   `tree -a -I .git`{{execute}}

   `tree /root/dvc-storage`{{execute}}
   
4. Push all the cached files to the DVC storage:
   
   `dvc status -caT`{{execute}}
   
   `dvc push -aT`{{execute}}
   
   `dvc status -caT`{{execute}}
   
   `tree /root/dvc-storage`{{execute}}
