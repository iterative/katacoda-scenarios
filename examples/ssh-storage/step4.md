# Share data

With this setup we can share data between the users: we push data from
the cache to the data storage with `dvc push`, and we pull from the
data storage with `dvc pull`.

1. Switch to the first user and add a data file to the project:

   On terminal 2: `cd ~/project/`{{execute T2}}
   
   `fallocate -l 5G datafile`{{execute}}
   
   `ls -lh`{{execute}}
   
   `dvc add datafile`{{execute}}
   
   `git status -s`{{execute}}
   
   `cat .gitignore`{{execute}}
   
   `cat datafile.dvc`{{execute}}
   
   `tree .dvc/cache/`{{execute}}

2. Commit changes to Git and push them to the Git central repository:

   `git add .`{{execute}}
   
   `git status -s`{{execute}}
   
   `git commit -m 'Add datafile'`{{execute}}
   
   `git status`{{execute}}
   
   `git push`{{execute}}
   
3. Push cached files to the central data storage:
   
   `dvc status -c`{{execute}}
   
   `dvc push`{{execute}}
   
   `dvc status -c`{{execute}}
   
   Check the cache on the data storage (on terminal 1):
   
   `cd /srv/project.cache/`{{execute T1}}
   
   `tree`{{execute}}
   
4. Switch to the second user and pull changes from Git:

   On terminal 3: `cd ~/project/`{{execute T2}}
   
   `git pull`{{execute}}
   
   `ls -lh`{{execute}}
   
   `cat datafile.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
5. Pull cached files from the central data storage:
   
   `dvc status -c`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `dvc pull`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `ls -lh`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}
   
