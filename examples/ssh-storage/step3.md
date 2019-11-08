# Second user setup

Click on this command to switch to the second user on another terminal
tab: `su - second-user`{{execute T3}} The steps are similar to those
for the first user.

1. Set up ssh keys for the Git server:
   
   Setup the ssh config:
   
   `mkdir ~/.ssh`{{execute}}
   
   `chmod 700 ~/.ssh/`{{execute}}
   
   ```
   cat <<EOF >> ~/.ssh/config
   Host git-server
       HostName host01
       User user2
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
   
   Send the public key to the server (use password `pass2`):
   
   `ssh-copy-id -i ~/.ssh/git-server.pub git-server`{{execute}}
   
   Try to ssh with the new key (you should be able to do it without
   a password):
   
   `ssh git-server ls -al .ssh/`{{execute}}
   
   ```
   ssh git-server \
       cat .ssh/authorized_keys
   ```{{execute}}
   
2. Clone the Git project:

   ```
   git clone \
       git-server:/srv/project.git
   ```{{execute}}

   `cd project/`{{execute}}
   
   `git remote -v`{{execute}}
   
   `git log --oneline`{{execute}}
   
3. Set up ssh keys for the DVC server:
   
   Setup the ssh config:
   
   ```
   cat <<EOF >> ~/.ssh/config
   
   Host dvc-server
       HostName host01
       User user2
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
   
   Send the public key to the server (use password `pass2`):
   
   `ssh-copy-id -i ~/.ssh/dvc-server.pub dvc-server`{{execute}}
   
   Try to ssh with the new key (you should be able to do it without
   a password):
   
   `ssh dvc-server ls -al .ssh/`{{execute}}
   
   `ssh dvc-server cat .ssh/authorized_keys`{{execute}}
   
4. Check the remote DVC cache:

   `cd ~/project/`{{execute}}
   
   `dvc remote list`{{execute}}
   
   `cat .dvc/config`{{execute}}
   
   `dvc status -c`{{execute}}
   
   Note that there are no username/password or ssh-key details on the
   DVC remote configuration, however they are specified on the SSH config
   file, so SSH knows how to connect to the server:
   
   `cat ~/.ssh/config`{{execute}}
