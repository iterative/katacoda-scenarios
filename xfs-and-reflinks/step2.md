## Create an XFS filesystem

1. Make sure that the package `xfsprogs` is installed:

   `sudo apt install xfsprogs`{{execute}}

2. Create an XFS filesystem on the image file:

   `mkfs.xfs \
       -m reflink=1 \
       -L test \
       disk.img`{{execute}}

   The metadata `-m reflink=1` tells the command to enable reflinks,
   and `-L test` sets the label of the filesystem.

3. Create a directory:

   `mkdir mnt`{{execute}}

4. Mount the loop device on it:

   `sudo mount /dev/loop0 mnt`{{execute}}

5. Check the usage of the filesystem:

   `df -h mnt/`{{execute}}

   Notice that only **40M** are used from it.
