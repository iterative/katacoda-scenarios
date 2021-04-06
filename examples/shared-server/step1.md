# Create a directory for the data

Since our filesystem (ext4) does not support _reflinks_, let's create
and mount an XFS filesystem. We will see later why using a filesystem
that supports reflinks is important for an efficient operation of DVC.

**Note:** If your root filesystem already supports reflinks, you can
skip the steps 1-3.

1. Create an image file big enough to hold the data and all the
   caches:

   ```
   cd /var/local/
   fallocate -l 20G data.img
   df -h /
   ```{{execute}}
   
2. Format it as an XFS filesystem with _reflink_ enabled, and mount it:

   ```
   mkfs.xfs \
       -m reflink=1 \
       -L data \
       data.img
   mkdir data
   mount -o loop data.img data
   ```{{execute}}

   
3. (Optional) Make sure that it is mounted automatically on reboot:

   ```
   cat <<EOF >> /etc/fstab
   /var/local/data.img  /var/local/data  auto  loop  0 0
   EOF
   ```

4. Declare the environment variable DATA that contains the path to the
   data directory:

   ```
   echo 'export DATA=/var/local/data' \
       >> ~/.bashrc
   source ~/.bashrc
   echo $DATA
   ```{{execute}}
   
   Declare it for all the new users as well:

   ```
   echo 'export DATA=/var/local/data' \
       >> /etc/skel/.bashrc
   ```{{execute}}
   
