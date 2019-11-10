# Share data

1. From the project of the second user, add a data file:

   `cd ~/project/`{{execute T3}}

   `fallocate -l 1G datafile`{{execute}}
   
   `ls -lh`{{execute}}
   
   `dvc add datafile`{{execute}}
   
   `git status -s`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m 'Add datafile'`{{execute}}
   
2. Push it:
   
   `git push`{{execute}}
   
   Push to the local storage:

   `dvc status -c`{{execute}}
   
   `tree ~/project.cache/`{{execute}}

   `tree /srv/project.cache/`{{execute}}

   `dvc push`{{execute}}
   
   `dvc status -c`{{execute}}

   `tree ~/project.cache/`{{execute}}
   
   `tree /srv/project.cache/`{{execute}}

3. Pull it from the project of the first user:

   `cd ~/project/`{{execute T2}}
   
   `git pull`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `tree ~/project.cache/`{{execute}}
   
   `dvc pull`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc status`{{execute}}
   
   `ls -lh`{{execute}}
