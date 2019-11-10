# Setup project storage for each user

1. Install sshfs:

   Go to the first terminal: `whoami`{{execute T1}}

   `apt install sshfs`{{execute}}
   
2. Go to the first user and mount the remote storage directory:

   On the second terminal: `whoami`{{execute T2}}
   
   `mkdir project.cache`{{execute}}
   
   `ls -l`{{execute}}
   
   ```
   sshfs \
       dvc-server:/srv/project.cache \
       project.cache
   ```{{execute}}
   
   `ls -l`{{execute}}
   
3. Set the default storage of the project:

   `cd project/`{{execute}}
   
   `dvc remote list`{{execute}}
   
   `dvc remote list --local`{{execute}}
   
   ```
   dvc remote add \
       --local --default \
       local-cache $HOME/project.cache
   ```{{execute}}

   `dvc remote list`{{execute}}
   
   `dvc remote list --local`{{execute}}
   
   `cat .dvc/config.local`{{execute}}
   
4. Switch to the second user and mount the remote storage directory:

   On the third terminal: `whoami`{{execute T3}}
   
   `mkdir project.cache`{{execute}}
   
   `ls -l`{{execute}}
   
   ```
   sshfs \
       dvc-server:/srv/project.cache \
       project.cache
   ```{{execute}}
   
   `ls -l`{{execute}}
   
5. Set the default storage of the project:

   `cd project/`{{execute}}
   
   `dvc remote list`{{execute}}
   
   `dvc remote list --local`{{execute}}
   
   ```
   dvc remote add \
       --local --default \
       local-cache $HOME/project.cache
   ```{{execute}}

   `dvc remote list`{{execute}}
   
   `dvc remote list --local`{{execute}}
   
   `cat .dvc/config.local`{{execute}}
