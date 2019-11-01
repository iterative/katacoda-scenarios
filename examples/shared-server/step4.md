# Share data

1. Login as the first user and add a data file to the project:

   `su - user1`{{execute}}
   
   `cd project/`{{execute}}
   
   `fallocate -l 10G datafile`{{execute}}
   
   `dvc add datafile`{{execute}}
   
   `git status -s`{{execute}}
   
   `git diff .gitignore`{{execute}}
   
   `cat datafile.dvc`{{execute}}
   
   `tree $DATA/user1-project-cache`{{execute}}

2. Commit changes to Git and push them to the Git central repository:

   `git add .`{{execute}}
   
   `git commit -m 'Add datafile'`{{execute}}
   
   `git push`{{execute}}
   
3. Push cached files to the central data storage:
   
   `dvc status -c`{{execute}}
   
   `tree $DATA/user1-project-cache`{{execute}}

   `tree $DATA/dvc-storage`{{execute}}
   
   `df -h $DATA`{{execute}}
   
   `dvc push`{{execute}}
   
   `tree $DATA/dvc-storage`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `df -h $DATA`{{execute}}
   
   Notice that `dvc push` was instantaneous and the space usage was
   not increased at all by pushing the cached file to the central data
   storage.

   `exit`{{execute}}
   
4. Login as the second user and pull changes from Git:

   `su - user2`{{execute}}
   
   `cd project/`{{execute}}
   
   `ls -lh`{{execute}}
   
   `git status`{{execute}}
   
   `git pull`{{execute}}
   
   `ls -lh`{{execute}}
   
   `cat datafile.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
5. Pull cached files from the central data storage:
   
   `dvc status -c`{{execute}}
   
   `tree $DATA/user2-project-cache/`{{execute}}
   
   `df -h $DATA`{{execute}}
   
   `dvc fetch`{{execute}}
   
   `tree $DATA/user2-project-cache/`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `df -h $DATA`{{execute}}
   
   Notice that `dvc fetch` was instantaneous and the space usage was
   not increased at all by fetching the cached file from the central
   data storage.
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
   
   `ls -lh`{{execute}}
   
   `exit`{{execute}}

With this setup we can share data the normal way:
- we can push data from the cache to the data storage with `dvc push`
- we can fetch from the data storage to the cache with `dvc fetch`

However, since all the user caches and the data storage are located on
the same XFS filesystem (that supports reflinks), copying cached files
around with `push` and `fetch` will be instantaneous and no additional
space will be used for the duplicated files.

If the user projects were located on the XFS filesystem too (or if the
whole root directory was mounted on a reflink enabled filesystem),
then the data copy between the workspace and the cache would also be
very efficient (instantaneous and using no extra space).
