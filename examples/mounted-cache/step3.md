# Share data

1. From the project of the second user, add a data file:

   `cd ~/project/`{{execute T3}}

   `fallocate -l 1G datafile`{{execute}}
   
   `ls -lh`{{execute}}
   
   `dvc add datafile`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `ls -lh`{{execute}}
   
   Notice the symlink.
   
   `cat datafile.dvc`{{execute}}
   
2. Commit to Git:
   
   `git status -s`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m 'Add datafile'`{{execute}}
   
   `git push`{{execute}}
   
3. We don't need to push it because it is already available on the
   mounted cache directory:

   `tree /srv/project.cache/`{{execute}}
   
   We also don't need to pull or fetch on the projects of the other
   users because it will be immediately available on their mounted
   cache directories.

4. Check it out from the project of the first user:

   On the second terminal: `whoami`{{execute T2}}

   `cd ~/project/`{{execute}}
   
   `git pull`{{execute}}
   
   `ls -lh`{{execute}}
   
   `dvc status`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
   
   `ls -lh`{{execute}}
