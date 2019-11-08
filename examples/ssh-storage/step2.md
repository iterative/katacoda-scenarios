# First user setup

Click on this command to switch to the first user on another terminal
tab: `su - first-user`{{execute T2}}

1. Set up ssh keys for the Git server:
   
   Setup the ssh config:
   
   `mkdir ~/.ssh`{{execute}}
   
   `chmod 700 ~/.ssh/`{{execute}}
   
   ```
   cat <<EOF >> ~/.ssh/config
   Host git-server
       HostName host01
       User user1
       IdentityFile ~/.ssh/git-server
       IdentitiesOnly yes 
   EOF
   ```{{execute}}
   
   `cat ~/.ssh/config`{{execute}}
   
   Generate a SSH key pair:

   ```
   ssh-keygen -t rsa -q -N '' \
       -f ~/.ssh/git-server
   ```{{execute}}
   
   `ls -al ~/.ssh/`{{execute}}
   
   Send the public key to the server (use password `pass1`):
   
   `ssh-copy-id -i ~/.ssh/git-server.pub git-server`{{execute}}
   
   Try to ssh with the new key (you should be able to do it without
   a password):
   
   `ssh git-server ls -al .ssh/`{{execute}}
   
   ```
   ssh git-server \
       cat .ssh/authorized_keys
   ```{{execute}}
   
2. Create the Git project:

   `mkdir project`{{execute}}
   
   `cd project/`{{execute}}
   
   `git init`{{execute}}
   
   `dvc init -q`{{execute}}
   
   `git commit -m 'Initialize DVC'`{{execute}}
   
   ```
   git remote add origin \
       git-server:/srv/project.git
   ```{{execute}}
   
   `git remote -v`{{execute}}
   
   `git push origin master`{{execute}}

3. Set up ssh keys for the DVC server:
   
   Setup the ssh config:
   
   ```
   cat <<EOF >> ~/.ssh/config
   
   Host dvc-server
       HostName host01
       User user1
       IdentityFile ~/.ssh/dvc-server
       IdentitiesOnly yes 
   EOF
   ```{{execute}}
   
   `cat ~/.ssh/config`{{execute}}
   
   Generate a SSH key pair:

   ```
   ssh-keygen -t rsa -q -N '' \
       -f ~/.ssh/dvc-server
   ```{{execute}}
   
   `ls -al ~/.ssh/`{{execute}}
   
   Send the public key to the server (use password `pass1`):
   
   `ssh-copy-id -i ~/.ssh/dvc-server.pub dvc-server`{{execute}}
   
   Try to ssh with the new key (you should be able to do it without
   a password):
   
   `ssh dvc-server ls -al .ssh/`{{execute}}
   
   ```
   ssh dvc-server \
       cat .ssh/authorized_keys
   ```{{execute}}
   
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

   `git status -s`{{execute}}
   
   `git diff .dvc/config`{{execute}}
   
   `git add .dvc/config`{{execute}}
   
   `git commit -m 'Add a SSH remote cache'`{{execute}}

   `git push --set-upstream origin master`{{execute}}
