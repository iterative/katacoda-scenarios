# Deduplicate cache storage

For each file that is cached, there is a copy on the workspace, a copy
on `.dvc/cache/`, and another copy on `~/project.cache/` (besides the
copy on the remote storage).

If you have a deduplicating filesystem (like XFS, Btrfs, etc.)  then
ecerything is fine because making copies of the same file does not
actually increase the disk usage.  If not, then you can create and
mount by loopback a deduplicating filesystem, and move the project and
caches there.

In this example the filesystem is ext4, which doesn't support yet
reflink copy (deduplication), so we are going to create and use XFS
filesystems for each of the user projects.

1. Go to the terminal of the first user and create and mount an XFS
   filesystem:

   `exit`{{execute T2}}
   
   `cd /var/local/`{{execute}}

   `fallocate -l 10G first-user.img`{{execute}}
   
   `mkfs.xfs -m reflink=1 first-user.img`{{execute}}

   `mkdir first-user`{{execute}}
   
   `ls -lh`{{execute}}
   
   `mount -o loop first-user.img first-user`{{execute}}
   
   Make sure that it is mounted automatically on reboot:

   ```
   cat <<EOF >> /etc/fstab
   /var/local/first-user.img  /var/local/first-user  auto  loop  0 0
   EOF
   ```{{execute}}
   
   `cat /etc/fstab | grep first-user`{{execute}}
   
   `mount -a`{{execute}}
   
   Declare env var DATA:

   ```
   echo 'export DATA=/var/local/first-user' \
       >> ~first-user/.bashrc
   ```{{execute}}
   
   `source ~first-user/.bashrc`{{execute}}
   
   `echo $DATA`{{execute}}

2. Move the project and caches to DATA:

   `mv ~first-user/project.cache/ $DATA/`{{execute}}
   
   `mv ~first-user/project/ $DATA/`{{execute}}
   
   Deduplicate existing files:
   
   `df -h $DATA/`{{execute}}
   
   ```
   duperemove -hdr \
       --hashfile=/tmp/test.hash \
       $DATA >/dev/null
   ```{{execute}}
   
   `df -h $DATA/`{{execute}}
   
   Link from homedir of the user:
   
   `ln -s $DATA/project ~first-user/`{{execute}}
   
   Fix the remote url:
   
   `su - first-user`{{execute}}
   
   `cd project/`{{execute}}
   
   `dvc remote list --local`{{execute}}
   
   ```
   dvc remote modify \
       --local local-cache \
       url $DATA/project.cache
   ```{{execute}}

   `dvc remote list --local`{{execute}}
   
3. Go to the terminal of the second user and create and mount an XFS
   filesystem:

   `exit`{{execute T3}}
   
   `cd /var/local/`{{execute}}

   `fallocate -l 10G second-user.img`{{execute}}
   
   `mkfs.xfs -m reflink=1 second-user.img`{{execute}}

   `mkdir second-user`{{execute}}
   
   `ls -lh`{{execute}}
   
   `mount -o loop second-user.img second-user`{{execute}}
   
   Make sure that it is mounted automatically on reboot:

   ```
   cat <<EOF >> /etc/fstab
   /var/local/second-user.img  /var/local/second-user  auto  loop  0 0
   EOF
   ```{{execute}}
   
   `cat /etc/fstab | grep second-user`{{execute}}
   
   `mount -a`{{execute}}
   
   Declare env var DATA:

   ```
   echo 'export DATA=/var/local/second-user' \
       >> ~second-user/.bashrc
   ```{{execute}}
   
   `source ~second-user/.bashrc`{{execute}}
   
   `echo $DATA`{{execute}}

4. Move the project and caches to DATA:

   `mv ~second-user/project.cache/ $DATA/`{{execute}}
   
   `mv ~second-user/project/ $DATA/`{{execute}}
   
   Deduplicate existing files:
   
   `df -h $DATA/`{{execute}}
   
   ```
   duperemove -hdr \
       --hashfile=/tmp/test.hash \
       $DATA >/dev/null
   ```{{execute}}
   
   `df -h $DATA/`{{execute}}
   
   Link from homedir of the user:
   
   `ln -s $DATA/project ~second-user/`{{execute}}
   
   Fix the remote url:
   
   `su - second-user`{{execute}}
   
   `cd project/`{{execute}}
   
   `dvc remote list --local`{{execute}}
   
   ```
   dvc remote modify \
       --local local-cache \
       url $DATA/project.cache
   ```{{execute}}

   `dvc remote list --local`{{execute}}
