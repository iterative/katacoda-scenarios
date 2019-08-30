## Clean up (optional)

Unmount and delete the test directory `mnt/`:
```bash
cd ..
umount mnt/
rmdir mnt/
```{{execute}}

Delete the loop device:
```bash
losetup -a
sudo losetup -d /dev/loop0
```{{execute}}

Remove the file that was used to create the loop device:
```bash
rm disk.img
```{{execute}}
