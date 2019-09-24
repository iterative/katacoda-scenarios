# Callback stages

Assume that we have to pull data from a database into our
pipeline. For the sake of simplicity we will use a small SQLite
database that has a table with filenames. Along the way we will see
also what are callback stages and how they are used.

1. Let's create a simple database:

   `apt install sqlite3`{{execute}}
   
   ```
   sqlite3 ~/data.sqlite <<EOF
   CREATE TABLE files (name varchar(30));
   INSERT INTO files VALUES ('diff1');
   INSERT INTO files VALUES ('diff2');
   INSERT INTO files VALUES ('diff3');
   INSERT INTO files VALUES ('diff4');
   EOF
   ```{{execute}}
   
   ```
   sqlite3 ~/data.sqlite \
       'SELECT name FROM files;'
   ```{{execute}}
   
2. Let's create a stage that reads data from this database and saves
   it to `data3.txt`:

   ```
   dvc run \
       -f db.dvc \
       -o data3.txt \
       "sqlite3 ~/data.sqlite \
           'SELECT name \
              FROM files;' > \
           data3.txt"
   ```{{execute}}
   
   `git status`{{execute}}
   
   `cat db.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   Note that this stage does not have any dependencies. As such, it
   doesn't make any sense to check the dependencies before executing
   the command, so the command is always executed (unless the stage is
   locked). This unconditioned stage is called a _callback_ stage.
   
3. Let's fix `stage3.dvc` to use the data from `data3.txt`:

   ```
   dvc run \
       -f stage1.dvc \
       -d data1.txt \
       -d data2.txt \
       -d data3.txt \
       -o joint-list.txt \
       --overwrite-dvcfile \
       'cat data*.txt > \
            joint-list.txt'
   ```{{execute}} 
   
   `git status`{{execute}}
   
   `git diff stage1.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro stage3.dvc`{{execute}}
   
   `dvc status`{{execute}}

   `dvc repro stage3.dvc`{{execute}}
   
   ```
   dvc pipeline show \
       stage3.dvc --ascii
   ```{{execute}}
   
   ```
   dvc pipeline show \
       stage3.dvc --ascii --outs
   ```{{execute}}
   
   ```
   dvc pipeline show \
       stage3.dvc --tree
   ```{{execute}}
   
4. So, the database query that downloads the data and saves them in
   our workspace is always executed when we reproduce the pipeline.
   If the database is on a remote server and the amount of data to be
   downloaded is big (for example if the data are image files), this
   would be inefficient. We can make the process a bit more efficient
   by checking first if there are any changes in the database, before
   downloading the data. For example we can count the number of
   records in a table. Let's modify out pipeline with this
   optimization.

   ```
   dvc run \
       -f db_status.dvc \
       -O db_status.txt \
       "sqlite3 ~/data.sqlite \
           'SELECT COUNT(*) \
              FROM files;' > \
           db_status.txt"
   ```{{execute}}

   ```
   dvc run \
       -f db.dvc \
       -d db_status.txt \
       -o data3.txt \
       --overwrite-dvcfile \
       "sqlite3 ~/data.sqlite \
           'SELECT name \
              FROM files;' > \
           data3.txt"
   ```{{execute}}

   `git status`{{execute}}
   
   `cat db_status.txt`{{execute}}
   
   `cat db_status.dvc`{{execute}}
   
   `cat db.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro stage3.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc lock db_status.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro stage3.dvc`{{execute}}
   
   `dvc unlock db_status.dvc`{{execute}}
   
   `dvc repro stage3.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   ```
   dvc pipeline show \
       stage3.dvc --ascii
   ```{{execute}}
   
   ```
   dvc pipeline show \
       stage3.dvc --ascii --outs
   ```{{execute}}
   
   ```
   dvc pipeline show \
       stage3.dvc --tree
   ```{{execute}}

5. Let's save the current state of the project by committing
   everything to GIT:

   `git status`{{execute}}
   
   `git add .`{{execute}}
   
   `git status`{{execute}}
   
   `git commit -m 'Second pipeline'`{{execute}}
   
   `git tag pipeline-2`{{execute}}
   
   `git tag`{{execute}}

6. Finally let's check the metrics:

   `dvc metrics show`{{execute}}

   `dvc metrics show -T`{{execute}}

   `dvc metrics show -a`{{execute}}

   `dvc metrics show -aT`{{execute}}
   
   Assuming that in each tag we have used a different approach to
   solve the problem, and assuming that the metrics measure the
   quality of that approach, the option `-T, --all-tags` would show us
   which approach is better. The option `-a, --all-branches` makes the
   comparison across all the branches.
