## Clean up (optional)

1. Unmount and delete the test directory `mnt/`:

   `
   cd ..
   umount mnt/
   rmdir mnt/
   `{{execute}}

2. Delete the loop device:

   `
   losetup -a
   sudo losetup -d /dev/loop0
   `{{execute}}

3. Remove the file that was used to create the loop device:

   `rm disk.img`{{execute}}
