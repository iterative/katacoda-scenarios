# Create users and clone the project

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

3. Clone the project for each user:

   `cd $DATA/`{{execute}}
   
   `git clone project.git user1-project`{{execute}}
   
   `chown user1: -R user1-project/`{{execute}}
   
   `ln -s $DATA/user1-project ~user1/project`{{execute}}
   
   `git clone project.git user2-project`{{execute}}
   
   `chown user2: -R user2-project/`{{execute}}
   
   `ln -s $DATA/user2-project ~user2/project`{{execute}}

Note that all the user projects and the central data storage are
located on `$DATA`, which is formatted with XFS and supports
reflinks. This is done for making DVC more efficient, both in terms of
space and speed. As we will see on the next step, the commands `dvc push`
and `dvc pull` will run instantaneously (literally), and the
occupied space on disk will not be increased at all when the data
files are cached, copied and duplicated.
