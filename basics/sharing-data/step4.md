# SSH connection details

We used a SSH remote storage in the last step, but we didn't have a
chance to setup its connection details, because the user `root` could
login automatically with a key file:

`ls -al ~/.ssh/`{{execute}}

`cat ~/.ssh/authorized_keys`{{execute}}

`cat ~/.ssh/id_rsa`{{execute}}

So, let's create a new user, and try to use his credentials for
accessing the SSH remote storage.

1. Create a new user account `user1` with password `pass1`:

   `adduser user1`{{execute}}
   
   `ssh user1@host01`{{execute}}
   
   `ls -al`{{execute}}
   
   `exit`{{execute}}
   
   Let's fix the permissions on `central-cache.dvc` so that it can be
   accessed by `user1`:
   
   `ls -al /root/central-cache.dvc/`{{execute}}
   
   `chown user1: /root/central-cache.dvc/ -R`{{execute}}
   
   `chmod +x /root`{{execute}}
   
   `ls -al /root/central-cache.dvc/`{{execute}}
   
2. Let's change the connection details of SSH storage on `workspace-a`
   to use `user1`:
   
   `cd ~/workspace-a/`{{execute}}
   
   `dvc remote list`{{execute}}
   
   ```
   dvc remote modify ssh-cache \
       url ssh://host01:/root/central-cache.dvc
   ```{{execute}}
   
   ```
   dvc remote modify ssh-cache \
       user user1
   ```{{execute}}
   
   `git status`{{execute}}
   
   `git diff .dvc/config`{{execute}}
   
   `dvc status -c`{{execute}}
   
   Authentication fails because it tries to login automatically, and
   it doesn't know the password. Let's tell it to ask for a password
   interactively:
   
   ```
   dvc remote modify ssh-cache \
       ask_password true
   ```{{execute}}
   
   `git diff`{{execute}}
   
   `dvc status -c`{{execute}}

3. Let's set the password, so that it does not ask each time it
   connects to the remote storage:
   
   ```
   dvc remote modify ssh-cache \
       ask_password false
   ```{{execute}}
   
   `git diff`{{execute}}
   
   `dvc status -c`{{execute}}
   
   ```
   dvc remote modify ssh-cache \
       password pass1
   ```{{execute}}
   
   `dvc status -c`{{execute}}
   
   `git diff`{{execute}}
   
4. Now it connects without asking for a password. But do you see any
   problems? Our plain text password has ended up on `.dvc/config`,
   ready to be committed and pushed to the central GIT repository. If
   this is a public repository (which it often is, for example a GitHub repo)
   this is terribly bad. Let's fix this as soon as possible:
   
   `dvc remote modify --unset ssh-cache password`{{execute}}
   
   `git diff`{{execute}}
   
   ```
   dvc remote modify --local \
       ssh-cache password pass1
   ```{{execute}}
   
   `dvc status -c`{{execute}}
   
   `git status`{{execute}}
   
   `git diff`{{execute}}
   
   It works, and the password is not in hands of GIT. The difference
   was made by the option `--local`. But where is the password?
   
   `ls -al .dvc/`{{execute}}
   
   `cat .dvc/config.local`{{execute}}
   
   `cat .dvc/.gitignore`{{execute}}
   
   So, with the option `--local`, the setting is not saved on
   `.dvc/config` but on `./dvc/config.local`, which is listed on
   `.dvc/.gitignore` so that it is not committed to GIT by mistake.
   Besides this, the configurations stored on `.dvc/config.local` take
   precedence over (override) those on `.dvc/config`.
