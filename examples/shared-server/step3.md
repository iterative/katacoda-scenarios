# Share data

1. Switch to the first user and add a data file to the project:

   `su - user1`{{execute}}
   
   `cd project/`{{execute}}
   
   `fallocate -l 10G datafile`{{execute}}
   
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
   
   `tree .dvc/cache/`{{execute}}

   `tree $DATA/project.cache`{{execute}}
   
   `df -h $DATA`{{execute}}
   
   `dvc push`{{execute}}
   
   `tree $DATA/project.cache`{{execute}}
   
   `df -h $DATA`{{execute}}
   
   Notice that `dvc push` was instantaneous and the space usage was
   not increased at all by pushing the cached file to the central data
   storage.

   `dvc status -c`{{execute}}
   
   `exit`{{execute}}
   
4. Switch to the second user and pull changes from Git:

   `su - user2`{{execute}}
   
   `ls -l`{{execute}}
   
   `cd project/`{{execute}}
   
   `git pull`{{execute}}
   
   `ls -lh`{{execute}}
   
   `cat datafile.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
5. Pull cached files from the central data storage:
   
   `dvc status -c`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `df -h $DATA`{{execute}}
   
   `dvc fetch`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `df -h $DATA`{{execute}}
   
   Notice that `dvc fetch` was instantaneous and the space usage was
   not increased at all by pulling the data file from the central data
   storage.
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `ls -lh`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `exit`{{execute}}

With this setup we can share data the normal way:
- we can push from the cache to the data storage with `dvc push`
- we can pull from the data storage to the cache with `dvc pull`

However, since all the user projects and the central data storage are
located on the same XFS filesystem (that supports reflinks), copying
cached files around with `push` and `pull` will be instantaneous and
no additional space will be used for the duplicated files.
