# Setup the central server

1. Create user accounts:

   `useradd -m -s /bin/bash user1`{{execute}}
   
   `echo user1:pass1 | chpasswd`{{execute}}
   
   `ls -al /home/user1/`{{execute}}
   
   `useradd -m -s /bin/bash user2`{{execute}}
   
   `echo user2:pass2 | chpasswd`{{execute}}

   `ls -al /home/user2/`{{execute}}
   
2. Create groups for Git and DVC:

   `addgroup git-group`{{execute}}

   `adduser user1 git-group`{{execute}}

   `adduser user2 git-group`{{execute}}
   
   `addgroup dvc-group`{{execute}}

   `adduser user1 dvc-group`{{execute}}

   `adduser user2 dvc-group`{{execute}}

3. Create a bare Git repository for the project:
   
   `git init --bare --shared /srv/project.git`{{execute}}
   
   `cd /srv/project.git`{{execute}}
   
   `ls -al`{{execute}}

   `chgrp -R git-group .`{{execute}}
   
   `chmod -R g+rws .`{{execute}}

   `ls -al`{{execute}}
   
   `cd -`{{execute}}

4. Create a directory for the DVC remote cache:
   
   `mkdir /srv/project.cache`{{execute}}
   
   `cd /srv/project.cache/`{{execute}}
   
   `chgrp -R dvc-group .`{{execute}}
   
   `chmod -R g+rws .`{{execute}}

   `cd -`{{execute}}
