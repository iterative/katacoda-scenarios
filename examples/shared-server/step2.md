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
    ```
    cd $DATA/
    git init --bare --shared project.git
    chgrp -R team project.git
    chmod -R g+rws project.git
    ls -al project.git
    ```{{execute}}


3. Clone the Git project for the first user:
    ```
    git clone project.git user1-project
    chown -R user1: user1-project/
    ln -s $DATA/user1-project ~user1/project
    ```{{execute}}
   
4. Create a data storage:

   ```
   mkdir -p project.cache
   chgrp -R team project.cache
   chmod -R g+rws project.cache
   ```{{execute}}

5. Initialize DVC:

   ```
   su - user1
   ls -l
   cd project/
   dvc init -q
   tree -a -I .git
   git status -s
   git config user.email 'user1@host01.com'
   git config user.name 'user1'
   git commit -m 'Initialize DVC'
   ```

6. Set the data storage:

   ```
   dvc remote add --default \
       storage $DATA/project.cache
   dvc remote list
   git status -s
   git diff .dvc/config
   git add .dvc/config
   git commit -m 'Set a default storage'
   git push
   exit
   ```{{execute}}

7. Clone the project for the other user:

   ```
   cd $DATA/
   git clone project.git user2-project
   chown -R user2: user2-project/
   ln -s $DATA/user2-project ~user2/project
   ls -al ~user2/project
   ```{{execute}}

Note that all the user projects and the central data storage are
located on `$DATA`, which is formatted with XFS and supports
reflinks. This is done for making DVC more efficient, both in terms of
space and speed. As we will see on the next step, the commands `dvc push`
and `dvc pull` will run instantaneously (literally), and the
occupied space on disk will not be increased at all when the data
files are cached, copied and duplicated.
