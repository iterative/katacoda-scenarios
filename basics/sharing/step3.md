# Using a remote data storage

A central data storage is more useful when it is located on a remote
server, so that it can help collaboration between people working on
different computers, often across the internet. DVC supports different
storage types and protocols, such as: Amazon S3, Google Cloud Storage,
SSH, HDFS, etc. Let's see how to use a SSH data storage, since this is
easy to try. We will use the localhost as a SSH server.

1. First of all, we have to install the dependencies for the SSH
   protocol:
   
   `pip3 install 'dvc[ssh]'`{{execute}}
   
   If we wanted to install the dependencies for all the supported
   protocols we would have used `pip3 install 'dvc[all]'`.
   
2. Let's probe the environment where we are working:

   `systemctl status ssh`{{execute}}
   
   `hostname`{{execute}}
   
   `whoami`{{execute}}
   
   `ssh root@host01`{{execute}}
   
   `exit`{{execute}}
   
   Luckily we can login without a password and this is going to make
   our test easier.
   
3. Let's add on `workspace-a` a SSH remote storage:

   `cd`{{execute}}
   
   `pwd`{{execute}}
   
   `cd workspace-a/`{{execute}}
   
   `dvc remote list`{{execute}}
   
   ```
   dvc remote add ssh-cache \
       ssh://root@host01:/root/central-cache.dvc
   ```{{execute}}

   `dvc remote list`{{execute}}
   
   `dvc remote remove data-storage`{{execute}}
   
   `dvc remote list`{{execute}}
   
   Let's set `ssh-cache` as default remote:
   
   `dvc remote default ssh-cache`{{execute}}
   
4. Do the same DVC configuration on `workspace-b`:

   `git status`{{execute}}
   
   `git diff .dvc/config`{{execute}}
   
   `git add .dvc/config`{{execute}}
   
   `git commit -m 'Adding a SSH remote cache'`{{execute}}
   
   `git status`{{execute}}
   
   `git push`{{execute}}
   
   `cd ../workspace-b/`{{execute}}
   
   `git pull`{{execute}}
   
   `dvc remote list`{{execute}}
   
   `cat .dvc/config`{{execute}}
   
   So, we committed in Git the configuration changes in the first
   workspace, and then pulled these changes from the other workspace.
   This way we can make sure that all of our workspaces use the same
   remote cache.
   
5. Let's change some data on one workspace, and transfer the changes
   to the other workspace, using the remote cache as an intermediary.
   
   `cat file.txt`{{execute}}
   
   `echo 'test 4' > file.txt`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc commit file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc push`{{execute}}
   
   `dvc status -c`{{execute}}
   
   Now let's commit the changes to git:
   
   `git status`{{execute}}
   
   `git diff file.txt.dvc`{{execute}}
   
   `git add file.txt.dvc`{{execute}}
   
   `git commit -m 'Changing file.txt once more'`{{execute}}
   
   `git tag v4`{{execute}}
   
   `git push`{{execute}}
   
   `git push origin v4`{{execute}}
   
   We can now retrieve these changes from `workspace-a`:
   
   `cd ../workspace-a/`{{execute}}
   
   `git pull`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc pull`{{execute}}
   
   `cat file.txt`{{execute}}


In a real situation we would have had to provide some more settings
about the SSH connection, like these:

- Set the user:
  ```
  dvc remote modify ssh-cache \
      user foo
  ```

- Set the port:
  ```
  dvc remote modify ssh-cache \
      port 2222
  ```

- Set a key file:
  ```
  dvc remote modify ssh-cache \
      keyfile /path/to/ssh/keyfile
  ```

- Set a password:
  ```
  dvc remote modify ssh-cache \
      password qwerty
  ```

- Ask for password interactively:
  ```
  dvc remote modify ssh-cache \
      ask_password true
  ```

For the other types of data storage it works the same way, only the
connection options are different.
