# Automate synchronization steps

Notice that whenever we run `dvc push` we also have to run `rsync`,
and before a `dvc pull` we also have to run `rsync`. This can be
automated and simplified by defining aliases or functions on
`~/.bashrc`.

1. Define functions for the first user:

   `cd ~/project/`{{execute T2}}
   
   ```
   cat << EOF >> ~/.bashrc
   push() {
       set -x
       git push
       dvc push
       rsync -rP $DATA/project.cache/ dvc-server:/srv/project.cache/
       set +x
   }
   pull() {
       set -x
       git pull
       rsync -rP dvc-server:/srv/project.cache/ $DATA/project.cache/
       dvc pull
       set +x
   }
   EOF
   ```{{execute}}
   
   `source ~/.bashrc`{{execute}}

2. Define functions for the second user:

   `cd ~/project/`{{execute T3}}
   
   ```
   cat << EOF >> ~/.bashrc
   push() {
       set -x
       git push
       dvc push
       rsync -rP $DATA/project.cache/ dvc-server:/srv/project.cache/
       set +x
   }
   pull() {
       set -x
       git pull
       rsync -rP dvc-server:/srv/project.cache/ $DATA/project.cache/
       dvc pull
       set +x
   }
   EOF
   ```{{execute}}
   
   `source ~/.bashrc`{{execute}}

3. Let the second user add and push a data file:

   `fallocate -l 1G data3`{{execute}}
   
   `echo 3 >> data3`{{execute}}
   
   `dvc add data3`{{execute}}
   
   `ls -lh`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m 'Add data3'`{{execute}}
   
   `push`{{execute}}

4. Let the first user pull it:

   `cd ~/project/`{{execute T2}}

   `pull`{{execute}}
   
   `ls -lh`{{execute}}
   
Another way to make the synchronization transparent to the users is to
setup cron jobs that synchronize periodically the local DVC storage
with the central one.
