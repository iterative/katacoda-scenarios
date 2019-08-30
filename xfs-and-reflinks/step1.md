## Create a virtual block device

Linux supports a special block device called the loop device, which
maps a normal file onto a virtual block device. This allows for the
file to be used as a "virtual file system".

Create such a file: `dd if=/dev/zero of=disk.img bs=100M
count=10`{{execute}}

Check its size: `du -hs disk.img`{{execute}}. It is 1GB.

Now create a loop device with this file: `sudo losetup -f
disk.img`{{execute}}. The option `-f` finds an unused loop device.

Find the name of the loop device that was created: `losetup -a`.
