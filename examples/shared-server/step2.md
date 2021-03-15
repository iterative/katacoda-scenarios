# Create users and projects

1. Create a couple of users and a group:
   ```
   useradd -m -s /bin/bash user1
   useradd -m -s /bin/bash user2
   ls -l /home/
   ls -al /home/user1/
   ls -al /home/user2/
   addgroup team
   adduser user1 team
   adduser user2 team
   ```{{execute}}

2. Create a Git project on the `$DATA` directory:

   `cd $DATA/`{{execute}}

   `git init --bare --shared project.git`{{execute}}
   
   `chgrp -R team project.git`{{execute}}

   `chmod -R g+rws project.git`{{execute}}

   `ls -al project.git`{{execute}}

3. Clone the Git project for the first user:

   `git clone project.git user1-project`{{execute}}
   
   `chown -R user1: user1-project/`{{execute}}
   
   `ln -s $DATA/user1-project ~user1/project`{{execute}}
   
4. Create a data storage:
   
   `mkdir -p project.cache`{{execute}}
   
   `chgrp -R team project.cache`{{execute}}
   
   `chmod -R g+rws project.cache`{{execute}}

5. Initialize DVC:

   `su - user1`{{execute}}
   
   `ls -l`{{execute}}
   
   `cd project/`{{execute}}
   
   `dvc init -q`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
   `git status -s`{{execute}}
   
   `git config user.email 'user1@host01.com'`{{execute}}
   
   `git config user.name 'user1'`{{execute}}
   
   `git commit -m 'Initialize DVC'`{{execute}}
   
6. Set the data storage:

   ```
   dvc remote add --default \
       storage $DATA/project.cache
   ```{{execute}}
   
   `dvc remote list`{{execute}}
   
   `git status -s`{{execute}}
   
   `git diff .dvc/config`{{execute}}
   
   `git add .dvc/config`{{execute}}
   
   `git commit -m 'Set a default storage'`{{execute}}
   
   `git push`{{execute}}
   
   `exit`{{execute}}

7. Clone the project for the other user:

   `cd $DATA/`{{execute}}
   
   `git clone project.git user2-project`{{execute}}
   
   `chown -R user2: user2-project/`{{execute}}
   
   `ln -s $DATA/user2-project ~user2/project`{{execute}}

   `ls -al ~user2/project`{{execute}}

Note that all the user projects and the central data storage are
located on `$DATA`, which is formatted with XFS and supports
reflinks. This is done for making DVC more efficient, both in terms of
space and speed. As we will see on the next step, the commands `dvc push`
and `dvc pull` will run instantaneously (literally), and the
occupied space on disk will not be increased at all when the data
files are cached, copied and duplicated.
