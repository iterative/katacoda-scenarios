# Setup for the second user

Click on this command to switch to the second user on another terminal
tab: `su - second-user`{{execute T3}} The steps are similar to those
for the first user.

1. Set up ssh keys for the Git server:
   
   Login to the Git server (with password `pass2`):
   
   `ssh user2@git-server`{{execute}}
   
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
       user2@git-server
   ```{{execute}}
   
   Setup the ssh config:
   
   ```
   cat <<EOF >> ~/.ssh/config
   
   Host git-server
       HostName 127.0.0.1
       User user2
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

2. Clone the Git project:

   `git clone git-server:/srv/project.git`{{execute}}

   `cd project/`{{execute}}
   
   `git remote -v`{{execute}}
   
   `git log`{{execute}}
   
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
       user2@dvc-server
   ```{{execute}}
   
   Setup the ssh config:
   
   ```
   cat <<EOF >> ~/.ssh/config
   
   Host dvc-server
       HostName 127.0.0.1
       User user2
       IdentityFile ~/.ssh/dvc-server
       IdentitiesOnly yes 
   EOF
   ```{{execute}}
   
   `cat ~/.ssh/config`{{execute}}
   
   Try to login with the new key (you should be able to login without
   a password):
   
   `ssh dvc-server`{{execute}}
   
   `ls -al .ssh`{{execute}}
   
   `cat .ssh/authorized_keys`{{execute}}
   
   `exit`{{execute}}

4. Check the remote DVC cache:

   `cd ~/project/`{{execute}}
   
   `dvc remote list`{{execute}}
   
   `cat .dvc/config`{{execute}}
   
   `dvc status -c`{{execute}}
   
   Note that there are no username/password or ssh-key details on the
   DVC remote configuration, however they are specified on the SSH config
   file, so SSH knows how to connect to the server:
   
   `cat ~/.ssh/config`{{execute}}
