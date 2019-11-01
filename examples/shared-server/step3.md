# Create user accounts

1. Create a couple of users:

   `useradd -m -s /bin/bash user1`{{execute}}
   
   `useradd -m -s /bin/bash user2`{{execute}}
   
   `ls -l /home/`{{execute}}
   
   `ls -al /home/user1/`{{execute}}
   
   `ls -al /home/user2/`{{execute}}

2. Grant them read-write access to the data storage and to the
   project:

   `addgroup dvcgroup`{{execute}}
   
   `adduser user1 dvcgroup`{{execute}}

   `adduser user2 dvcgroup`{{execute}}

   `chgrp dvcgroup -R $DATA/dvc-storage`{{execute}}
   
   `chmod g+rw -R $DATA/dvc-storage`{{execute}}

   `chgrp dvcgroup -R $DATA/project.git`{{execute}}

   `chmod g+rw -R $DATA/project.git`{{execute}}

   `ls -al $DATA`{{execute}}

3. Clone the project for the first user:

   `mkdir $DATA/user1-project-cache`{{execute}}
   
   `chown user1: $DATA/user1-project-cache`{{execute}}

   `ls -al $DATA`{{execute}}

   `su - user1`{{execute}}
   
   ```
   echo 'export DATA=/var/local/data' \
       >> ~/.bashrc
   ```{{execute}}
   
   `source ~/.bashrc`{{execute}}
   
   `echo $DATA`{{execute}}
   
   `git clone $DATA/project.git`{{execute}}
   
   `cd project/`{{execute}}
   
   ```
   dvc config --local cache.dir \
       $DATA/user1-project-cache
   ```{{execute}}

   `cat .dvc/config.local`{{execute}}
   
   `exit`{{execute}}
   
4. Do the same for the second user:

   `mkdir $DATA/user2-project-cache`{{execute}}
   
   `chown user2: $DATA/user2-project-cache`{{execute}}
   
   `su - user2`{{execute}}
   
   ```
   echo 'export DATA=/var/local/data' \
       >> ~/.bashrc
   ```{{execute}}
   
   `source ~/.bashrc`{{execute}}
   
   `echo $DATA`{{execute}}
   
   `git clone $DATA/project.git`{{execute}}
   
   `cd project/`{{execute}}
   
   ```
   dvc config --local cache.dir \
       $DATA/user2-project-cache
   ```{{execute}}

   `cat .dvc/config.local`{{execute}}
   
   `exit`{{execute}}

Note that the cache of the user projects and the data storage of the
project are both located on `/var/local/data`, which is formatted with
XFS and supports reflinks. This is done in order to make the operation
of DVC more efficient, both in terms of space and speed. As we will
see on the next step, the commands `dvc push` and `dvc fetch` will run
instantaneously (literally), and the occupied space on disk will not
be increased at all when the cached files are copied and duplicated.
