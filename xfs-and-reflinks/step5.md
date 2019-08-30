## Clean up (optional)

Unmount and delete the test directory `mnt/`:
`
cd ..
umount mnt/
rmdir mnt/
`{{execute}}

Delete the loop device:

`
losetup -a
sudo losetup -d /dev/loop0
`{{execute}}

Remove the file that was used to create the loop device:
`rm disk.img`{{execute}}
