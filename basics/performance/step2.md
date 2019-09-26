# Use a virtual XFS filesystem

To solve this problem, we can create an XFS filesystem on a virtual
block device, and mount it on our project directory.

1. Create an image file that will contain our filesystem:
   
   `df -h /`{{execute}}
   
   `fallocate -l 35G proj1.img`{{execute}}
   
   `df -h /`{{execute}}
   
   `ls -lh`{{execute}}
   
   Create the image file as big as you need or as big as you can, so
   that it can contain all the data of the project and the caches.

2. Format it with XFS and mount on it on `proj1/`:

   `apt install xfsprogs`{{execute}}

   ```
   mkfs.xfs \
       -m reflink=1 \
       -L proj1 \
       proj1.img
   ```{{execute}}
   
   The metadata `-m reflink=1` tells the command to enable reflinks,
   and `-L proj1` sets the label of the filesystem.

   `mkdir proj1`{{execute}}
   
   `mount -o loop proj1.img proj1`{{execute}}
   
3. Initialize DVC on `proj1/` and create a big file:

   `cd proj1/`{{execute}}
   
   `dvc init --no-scm -q`{{execute}}
   
   `tree -a`{{execute}}
   
   `fallocate -l 15G file1.big`{{execute}}
   
   `ls -lh`{{execute}}
   
   `du -hs .`{{execute}}
   
   `df -h .`{{execute}}
   
4. Add it to cache and check the space used:
   
   `dvc add file1.big`{{execute}}
   
   `tree -a`{{execute}}
   
   `du -hs .dvc/cache/`{{execute}}
   
   `du -hs .`{{execute}}

   `df -h .`{{execute}}
   
   As you see, the disk space used is not doubled. Both the file and
   the cached copy take just 16G. This is efficient.
   
5. Check the time of a checkout:

   `rm file1.big`{{execute}}
   
   `dvc status`{{execute}}

   `time dvc checkout file1.big.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   That was very fast. No matter how big is the cached file, the
   checkout will still be instantaneous.
   
6. Make sure that `proj1.img` is mounted on `proj1` on reboot:

   `cd ..`{{execute}}
   
   `umount proj1/`{{execute}}
   
   `ls proj1/`{{execute}}
   
   `realpath proj1.img`{{execute}}
   
   `realpath proj1/`{{execute}}
   
   ```
   cat <<EOF >> /etc/fstab
   /root/proj1.img  /root/proj1  auto  loop  0 0
   EOF
   ```{{execute}}

   `ls proj1/`{{execute}}
   
   `mount -a`{{execute}}
   
   `ls proj1/`{{execute}}
