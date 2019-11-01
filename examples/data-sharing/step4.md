# Share data 

With this setup we can share data the normal way: we push data from
the cache to the data storage with `dvc push`, and we pull from the
data storage with `dvc pull`. The fact that all the project copies and
the data storage itself are located on the same host doesn't make any
difference. The only difference will be in efficiency; since all the
caches and the data storage are located on the same XFS filesystem
(that supports reflinks), copying data files around will be
instantabous and no data will be duplicated.

1. Login as the first user and add some data to the project:

   `su - user1`{{execute}}
   
   `cd project/`{{execute}}
   
   `cp test_data.csv test_data_1.csv`{{execute}}
   
   `sed -i test_data_1.csv -e '1d'`{{execute}}
   
   `dvc add test_data_1.csv`{{execute}}
   
   `git status -s`{{execute}}
   
   `git diff .gitignore`{{execute}}
   
   `cat test_data_1.csv.dvc`{{execute}}
   
2. Commit and push to git and push cache to the data storage:
   
   `git add .`{{execute}}
   
   `git commit -m 'Add another data file'`{{execute}}
   
   `git push`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `tree $DATA/user1-project-cache`{{execute}}

   `tree $DATA/dvc-storage`{{execute}}
   
   `dvc push`{{execute}}
   
   `tree $DATA/dvc-storage`{{execute}}
   
   `dvc status -c`{{execute}}

   `exit`{{execute}}
   
3. Login as the second user and pull the data:

   `su - user2`{{execute}}
   
   `cd project/`{{execute}}
   
   `git pull`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `tree $DATA/user2-project-cache/`{{execute}}
   
   `dvc pull`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc status`{{execute}}
   
   `tree $DATA/user2-project-cache/`{{execute}}
   
   `exit`{{execute}}
