# Setup the central server

1. Create user accounts:

   `useradd -m -s /bin/bash user1`{{execute}}
   
   `echo user1:pass1 | chpasswd`{{execute}}
   
   `ls -al /home/user1/`{{execute}}
   
   `useradd -m -s /bin/bash user2`{{execute}}
   
   `echo user2:pass2 | chpasswd`{{execute}}

   `ls -al /home/user2/`{{execute}}

2. Create a bare Git repository for the project and grant users
   read-write access to it:
   
   `git init --bare /srv/project.git`{{execute}}
   
   `ls -al /srv/project.git`{{execute}}

   `addgroup git-group`{{execute}}

   `adduser user1 git-group`{{execute}}

   `adduser user2 git-group`{{execute}}

   ```
   chgrp git-group -R \
         /srv/project.git/
   ```{{execute}}
   
   `chmod g+rw -R /srv/project.git/`{{execute}}

   `ls -al /srv/project.git/`{{execute}}

3. Create a directory for the DVC remote cache and grant users
   read-write access to it:
   
   `mkdir /srv/project.cache`{{execute}}
   
   `addgroup dvc-group`{{execute}}

   `adduser user1 dvc-group`{{execute}}

   `adduser user2 dvc-group`{{execute}}

   ```
   chgrp dvc-group -R \
         /srv/project.cache/
   ```{{execute}}
   
   `chmod g+rw -R /srv/project.cache/`{{execute}}

   `ls -al /srv/project.cache/`{{execute}}
