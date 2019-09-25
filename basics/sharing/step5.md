# SSH connection best practice

In the last step we used the account `user1` and a password for
connecting to the SSH server of the remote storage. However the
well-known best practice for SSH connections is to use SSH keys. It is
easy, convenient and secure, so why not do it?

1. First let's generate a SSH key pair:
   
   `cd`{{execute}}
   
   ```
   ssh-keygen -t rsa \
       -f ~/.ssh/user1_dvc
   ```{{execute}}
   
   Don't set a password, just press [Enter] on all the prompts.
   
   `ls -al ~/.ssh/`{{execute}}
   
2. Send the public key to the server:
   
   ```
   ssh-copy-id \
       -i ~/.ssh/user1_dvc.pub \
       user1@host01
   ```{{execute}}
   
3. Try to login with the new key (you should be able to login without
   a password):
   
   `ssh -i ~/.ssh/user1_dvc user1@host01`{{execute}}
   
   `ls -al`{{execute}}
   
   `ls -al .ssh`{{execute}}
   
   `cat .ssh/authorized_keys`{{execute}}
   
   `exit`{{execute}}
   
   `cat ~/.ssh/user1_dvc.pub`{{execute}}
   
   Notice that the public key `user1_dvc.pub` has been listed on
   `.ssh/authorized_keys` on the remote host.

4. Set the private SSH key on the configuration of the remote storage:

   `cd ~/workspace-a/`{{execute}}
   
   `dvc remote list --local`{{execute}}

   `cat .dvc/config.local`{{execute}}

   ```
   dvc remote modify --local \
       --unset ssh-cache password
   ```{{execute}}

   ```
   dvc remote modify --local \
       ssh-cache keyfile \
       /root/.ssh/user1_dvc
   ```{{execute}}

   `cat .dvc/config.local`{{execute}}

   `dvc status -c`{{execute}}

   `git diff`{{execute}}

   It works without asking for password, and no password is stored
   anywhere.
