#!/bin/bash
# setup the central server

set -o verbose

### Create user accounts

:; useradd -m -s /bin/bash user1
:; echo user1:pass1 | chpasswd
:; useradd -m -s /bin/bash user2
:; echo user2:pass2 | chpasswd

### Create groups for Git and DVC

:; addgroup git-group
:; adduser user1 git-group
:; adduser user2 git-group

:; addgroup dvc-group
:; adduser user1 dvc-group
:; adduser user2 dvc-group

### Create a bare Git repository for the project

:; git init --bare --shared /srv/project.git
:; chgrp -R git-group /srv/project.git
:; chmod -R g+rws /srv/project.git

### Create a directory for the DVC remote cache

:; mkdir /srv/project.cache
:; chgrp -R dvc-group /srv/project.cache/
:; chmod -R g+rws /srv/project.cache/

### Done
