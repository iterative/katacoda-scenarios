# Create a directory for the data

Since our filesystem (ext4) does not support _reflinks_, let's create
and mount an XFS filesystem. We will see later why using a filesystem
that supports reflinks is important for an efficient operation.

1. Create an image file big enough to hold the data and all the
   caches:

   `cd /var/local/`{{execute}}
   
   `df -h /`{{execute}}
   
   `fallocate -l 30G data.img`{{execute}}
   
   `ls -lh`{{execute}}

   `df -h /`{{execute}}
   
2. Format it as an XFS filesystem with _reflink_ enabed, and mount it:

   ```
   mkfs.xfs \
       -m reflink=1 \
       -L data \
       data.img
   ```{{execute}}

   `mkdir data`{{execute}}
   
   `ls -lh`{{execute}}
   
   `mount -o loop data.img data`{{execute}}
   
3. Make sure that it is mounted automatically on reboot:

   ```
   cat <<EOF >> /etc/fstab
   /var/local/data.img  /var/local/data  auto  loop  0 0
   EOF
   ```{{execute}}
   
   `cat /etc/fstab | grep data`{{execute}}
   
   `mount -a`{{execute}}

4. Declare the environment variable DATA that contains the path to the
   data directory:

   ```
   echo 'export DATA=/var/local/data' \
       >> ~/.bashrc
   ```{{execute}}
   
   `source ~/.bashrc`{{execute}}
   
   `echo $DATA`{{execute}}
