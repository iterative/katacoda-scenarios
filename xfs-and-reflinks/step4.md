## Deduplicate existing files

If there were already normal (non-reflink) copies of the same file, we
could deduplicate them with a tool like **duperemove**.

1. Create some normal copies of the `test` file:

   `cp test test2`{{execute}}

   `cp test test3`{{execute}}

2. Check the size of each file and the total size:

   `ls -hsl`{{execute}}

3. Check also the disk usage:

   `df -h .`{{execute}}

   They are taking up to **340M** of the disk space.

4. Install **duperemove**:

   `sudo apt install duperemove`{{execute}}

5. Try to deduplicate:

   `duperemove -hdr --hashfile=/tmp/test.hash .`{{execute}}

6. Check again the disk usage:

   `df -h .`{{execute}}

   Notice that the size of the disk space used has been reduced from
   **340M** back to **140M**.
