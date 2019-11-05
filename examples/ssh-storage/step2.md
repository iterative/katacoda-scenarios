# Setup for the first user

Click on this command to switch to the first user on another terminal
tab: `su - first-user`{{execute T2}}

1. Set up ssh keys for the Git server:
   
   Login to the Git server (with password `pass1`):
   
   `ssh user1@git-server`{{execute}}
   
   Note that `git-server` is defined on `/etc/hosts`:
   
   `cat /etc/hosts | grep git-server`{{execute}}
   
   Generate a SSH key pair:

   ```
   ssh-keygen -t rsa \
       -f ~/.ssh/git-server
   ```{{execute}}
   
   Don't set a password, just press [Enter] on all the prompts.
   
   `ls -al ~/.ssh/`{{execute}}
   
   Send the public key to the server:
   
   ```
   ssh-copy-id \
       -i ~/.ssh/git-server.pub \
       user1@git-server
   ```{{execute}}
   
   Setup the ssh config:
   
   ```
   cat <<EOF >> ~/.ssh/config
   
   Host git-server
       HostName 127.0.0.1
       User user1
       IdentityFile ~/.ssh/git-server
       IdentitiesOnly yes 
   EOF
   ```{{execute}}
   
   `cat ~/.ssh/config`{{execute}}
   
   Try to login with the new key (you should be able to login without
   a password):
   
   `ssh git-server`{{execute}}
   
   `ls -al .ssh/`{{execute}}
   
   `cat .ssh/authorized_keys`{{execute}}
   
   `exit`{{execute}}

2. Create the Git project:

   `mkdir project`{{execute}}
   
   `cd project/`{{execute}}
   
   `git init`{{execute}}
   
   `dvc init -q`{{execute}}
   
   `git commit -m 'Initialize DVC'`{{execute}}
   
   `git remote add origin git-server:/srv/project.git`{{execute}}
   
   `git remote -v`{{execute}}
   
   `git push origin master`{{execute}}

3. Set up ssh keys for the DVC server:
   
   Generate a SSH key pair:

   ```
   ssh-keygen -t rsa \
       -f ~/.ssh/git-server
   ```{{execute}}
   
   Don't set a password, just press [Enter] on all the prompts.
   
   `ls -al ~/.ssh/`{{execute}}
   
   Send the public key to the server:
   
   ```
   ssh-copy-id \
       -i ~/.ssh/dvc-server.pub \
       user1@dvc-server
   ```{{execute}}
   
   Setup the ssh config:
   
   ```
   cat <<EOF >> ~/.ssh/config
   
   Host dvc-server
       HostName 127.0.0.1
       User user1
       IdentityFile ~/.ssh/dvc-server
       IdentitiesOnly yes 
   EOF
   ```{{execute}}
   
   `cat ~/.ssh/config`{{execute}}
   
   Try to login with the new key (you should be able to login without
   a password):
   
   `ssh dvc-server`{{execute}}
   
   `ls -al .ssh/`{{execute}}
   
   `cat .ssh/authorized_keys`{{execute}}
   
   `exit`{{execute}}

4. Setup the remote DVC cache on the project:

   `cd ~/project/`{{execute}}
   
   `dvc remote list`{{execute}}
   
   `dvc remote add -d ssh-cache ssh://dvc-server:/srv/project.cache`{{execute}}

   `dvc remote list`{{execute}}
   
   `dvc status -c`{{execute}}
   
   Note that we didn't tell DVC the username and the key-file of the
   SSH connection, however they are specified on the SSH config file,
   so it already knows how to connect to the server:
   
   `cat ~/.ssh/config`{{execute}}
   
   Let's commit this configuration to Git:

   `git status`{{execute}}
   
   `git diff .dvc/config`{{execute}}
   
   `git add .dvc/config`{{execute}}
   
   `git commit -m 'Add a SSH remote cache'`{{execute}}

   `git status`{{execute}}
   
   `git push`{{execute}}
