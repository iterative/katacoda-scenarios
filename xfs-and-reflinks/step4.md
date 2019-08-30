## Deduplicate existing files

If there were already normal (non-reflink) copies of the same file, we
could deduplicate them with a tool like **duperemove**.

To test this let's create some normal copies of the `test` file:

`cp test test2`{{execute}}

`cp test test3`{{execute}}

Check the size of each file and the total size:

`ls -hsl`{{execute}}

Check also the disk usage:

`df -h .`{{execite}}

They are taking up to **340M** of the disk space.

Install **duperemove**:

`sudo apt install duperemove`{{execute}}

Try to deduplicate:

`duperemove -hdr --hashfile=/tmp/test.hash .`{{execute}}

Check again the disk usage:

`df -h .`{{execute}}

Notice that the size of the disk space used has been reduced from
**340M** to **198M**.
