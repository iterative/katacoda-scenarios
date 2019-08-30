## Copy files with '--reflink'

Create for testing a file of size 100 MB (with random data):

`cd mnt/`{{execute}}

`dd if=/dev/urandom of=test bs=1M count=100`{{execute}}

Check that now there are **140M** of disk space used:

`df -h .`{{execute}}

Create a copy of the file (with reflinks enabled):

`cp -v --reflink=always test test1`{{execute}}

Check the size of each file:

`ls -hsl`{{execute}}

Each of them is **100M** and in total there are **200M** of data.

However if we check the disk usage we will see that both of them still
take on disk the same amout of space as before **140M**:

`df -h .`{{execute}}

This shows the space-saving feature of reflinks. If the file was big
enough, we would have noticed as well that the reflink copy takes no
time at all, it is done instantly.
