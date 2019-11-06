#!/bin/bash
# setup the central server

set -o verbose

### Create user accounts

:; useradd -m -s /bin/bash user1

:; echo user1:pass1 | chpasswd

:; ls -al /home/user1/

:; useradd -m -s /bin/bash user2

:; echo user2:pass2 | chpasswd

:; ls -al /home/user2/

### Create a bare Git repository for the project

:; git init --bare /srv/project.git

:; ls -al /srv/project.git

### Grant users read-write access to it:

:; addgroup git-group

:; adduser user1 git-group

:; adduser user2 git-group

:; chgrp git-group -R /srv/project.git/

:; chmod g+rw -R /srv/project.git/

:; ls -al /srv/project.git/

### Create a directory for the DVC remote cache

:; mkdir /srv/project.cache

### Grant users read-write access to it

:; addgroup dvc-group

:; adduser user1 dvc-group

:; adduser user2 dvc-group

:; chgrp dvc-group -R /srv/project.cache/

:; chmod g+rw -R /srv/project.cache/

:; ls -al /srv/project.cache/

### Done
