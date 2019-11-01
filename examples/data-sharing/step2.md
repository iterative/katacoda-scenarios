# Create a simple project

1. Let's initialize a project on the `$DATA` directory:

   `mkdir $DATA/project`{{execute}}
   
   `cd $DATA/project/`{{execute}}
   
   `git init`{{execute}}
   
   `dvc init -q`{{execute}}
   
   `git commit -m 'Initialize DVC'`{{execute}}
   
2. Configure an external cache directory:
   
   `mkdir $DATA/project-cache`{{execute}}
   
   `dvc config cache.dir $DATA/project-cache`{{execute}}
   
   `rm -rf .dvc/cache/`{{execute}}
   
   `git status -s`{{execute}}
   
   `git diff .dvc/config`{{execute}}
   
   `git add .dvc/config`{{execute}}

   `git commit -m 'Setup an external cache'`{{execute}}

3. Add a default data storage:
   
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

4. Get some data files:
   
   ```
   wget https://pjreddie.com/media/files/mnist_train.csv \
       -O train_data.csv
   ```{{execute}}

   ```
   wget https://pjreddie.com/media/files/mnist_test.csv \
       -O test_data.csv
   ```{{execute}}
   
   `ls -lh`{{execute}}

   `cat train_data.csv | wc -l`{{execute}}

   `cat test_data.csv | wc -l`{{execute}}
   
5. Add them to DVC:
   
   `dvc add train_data.csv`{{execute}}

   `dvc add test_data.csv`{{execute}}
   
   `git status -s`{{execute}}

   `cat .gitignore`{{execute}}

   `cat train_data.csv.dvc`{{execute}}

   `cat test_data.csv.dvc`{{execute}}
   
   `tree $DATA/project-cache/`{{execute}}
   
6. Push cached files to the data storage:
   
   `dvc status -c`{{execute}}
   
   `tree $DATA/dvc-storage/`{{execute}}
   
   `dvc push`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `tree $DATA/dvc-storage/`{{execute}}

7. Commit changes to Git:
   
   `git add .`{{execute}}
   
   `git status -s`{{execute}}
   
   `git commit -m 'Add datasets'`{{execute}}
   
8. Make the Git repository bare:
   
   `cd ..`{{execute}}
   
   `ls -l`{{execute}}
   
   `git clone --bare project project.git`{{execute}}
   
   `ls -l project.git/`{{execute}}
   
   `rm -rf project/`{{execute}}
   
   `ls -l`{{execute}}

Note that the cache of the project and the data storage of the project
are both located on `/var/local/data`, which is formated with XFS, a
filesystem that supports **reflinks**. The fact that they are both
located on the same filesystem that supports reflinks will make the
operation of DVC very efficient, both in terms of space and speed. The
commands `dvc push` and `dvc pull` will run instantaneously
(literally), and the occupied space on disk will not be increased at
all when cached files are copied and duplicated.
   
