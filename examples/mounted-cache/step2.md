# Setup project storage for each user

1. Install sshfs:

   Go to the first terminal: `whoami`{{execute T1}}

   `apt install sshfs`{{execute}}
   
2. Go to the first user and mount the remote cache directory:

   On the second terminal: `whoami`{{execute T2}}
   
   `cd ~/project/`{{execute}}
   
   `mkdir -p .dvc/cache`{{execute}}
   
   ```
   sshfs \
       dvc-server:/srv/project.cache \
       .dvc/cache
   ```{{execute}}
   
   `tree -a -I .git`{{execute}}
   ```
   
3. Reflink copy (deduplication of data) does not work in this
   situation, since the cache directory is located on another
   filesystem (which is mounted on `.dvc/cache`). However we can still
   optimize data management by using symlinks, which work across
   filesystems:

   `dvc config cache.type 'reflink,symlink,hardlink,copy'`{{execute}}
   
   `dvc config cache.protected true`{{execute}}
   
4. Switch to the second user and mount the remote cache directory:

   On the third terminal: `whoami`{{execute T3}}
   
   `cd ~/project/`{{execute}}
   
   `mkdir -p .dvc/cache`{{execute}}
   
   ```
   sshfs \
       dvc-server:/srv/project.cache \
       .dvc/cache
   ```{{execute}}
   
   `tree -a -I .git`{{execute}}

5. Optimize data management with symlinks:

   `dvc config cache.type 'reflink,symlink,hardlink,copy'`{{execute}}
   
   `dvc config cache.protected true`{{execute}}
