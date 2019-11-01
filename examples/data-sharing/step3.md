# Create users

1. Create a couple of users:

   ```
   echo -e "pass1\npass1" \
       | adduser --gecos '' user1
   ```{{execute}}

   ```
   echo -e "pass2\npass2" \
       | adduser --gecos '' user2
   ```{{execute}}
   
   `ls /home/`{{execute}}
   
   `ls -al /home/user1/`{{execute}}
   
   `ls -al /home/user2/`{{execute}}
```

2. Grant them read-write access to the data storage and to the
   project:

   `addgroup dvcgroup`{{execute}}
   
   `adduser user1 dvcgroup`{{execute}}

   `adduser user2 dvcgroup`{{execute}}

   `chgrp dvcgroup $DATA/dvc-storage`{{execute}}
   
   `chgrp dvcgroup $DATA/project.git`{{execute}}

   `chmod g+rw $DATA/project.git`{{execute}}

   `chmod g+rw $DATA/dvc-storage`{{execute}}

   `ls -al $DATA`{{execute}}

3. Clone the project for the first user:

   `mkdir $DATA/user1-project-cache`{{execute}}
   
   `chown user1: $DATA/user1-project-cache`{{execute}}

   `ls -al $DATA`{{execute}}

   `su - user1`{{execute}}
   
   ```
   echo 'export DATA=/var/lib/data' \
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

   `git status -s`{{execute}}
   
   `cat .dvc/config.local`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc pull`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc status`{{execute}}
   
   `tree $DATA/user1-project-cache`{{execute}}

   `exit`{{execute}}
   
4. Do the same for the second user:

   `mkdir $DATA/user2-project-cache`{{execute}}
   
   `chown user2: $DATA/user2-project-cache`{{execute}}
   
   `su - user2`{{execute}}
   
   ```
   echo 'export DATA=/var/lib/data' \
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

   `git status -s`{{execute}}
   
   `cat .dvc/config.local`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc pull`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc status`{{execute}}
   
   `tree $DATA/user2-project-cache`{{execute}}

   `exit`{{execute}}
