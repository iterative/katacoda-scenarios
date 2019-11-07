# Share data

1. From the project of the second user, add a data file:

   `cd ~/project/`{{execute T3}}

   `fallocate -l 2G data2`{{execute}}
   
   `ls -lh`{{execute}}
   
   `dvc add data2`{{execute}}
   
   `git status -s`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m 'Add data2'`{{execute}}
   
2. Push it:
   
   `git push`{{execute}}
   
   Push to the local storage:

   `dvc status -c`{{execute}}
   
   `tree $DATA/project.cache/`{{execute}}
   
   `dvc push`{{execute}}
   
   `dvc status -c`{{execute}}

   `tree $DATA/project.cache/`{{execute}}
   
   Synchronize the local storage with the remote one:

   ```
   rsync -r -P \
       $DATA/project.cache/ \
       dvc-server:/srv/project.cache/
   ```{{execute}}

3. Pull it from the project of the first user:

   `cd ~/project/`{{execute T2}}
   
   `git pull`{{execute}}
   
   `dvc status`{{execute}}
   
   Synchronize the remote storage with the local one:
   
   `tree $DATA/project.cache/`{{execute}}
   
   ```
   rsync -r -P \
       dvc-server:/srv/project.cache/ \
       ~/project.cache/
   ```{{execute}}

   `tree $DATA/project.cache/`{{execute}}
   
   Now pull from the local storage to the project:
   
   `dvc status -c`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `dvc pull`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc status`{{execute}}
   
   `ls -lh`{{execute}}

Notice that besides the disk usage being reduced, the DVC commands
`dvc push` and `dvc pull` are also faster now.
