# What is the problem?

Let's see first what is the problem with big data files.

1. Initialize a project and create a big file of size 15G:

   `mkdir proj1`{{execute}}
   
   `cd proj1/`{{execute}}
   
   `dvc init --no-scm -q`{{execute}}
   
   `tree -a`{{execute}}
   
   `fallocate -l 15G file1.big`{{execute}}
   
   `ls -lh`{{execute}}
   
   `du -hs .`{{execute}}
   
2. Start tracking it with DVC:

   `time dvc add file1.big`{{execute}}
   
   `tree -a`{{execute}}
   
   `du -hs .dvc/cache/`{{execute}}
   
   `du -hs file1.big`{{execute}}
   
   `du -hs .`{{execute}}
   
   As you see, it takes twice the space, because a copy of the file is
   stored on the cache as well.
   
3. Checkout the file:

   `dvc status`{{execute}}
   
   `rm file1.big`{{execute}}
   
   `dvc status`{{execute}}
   
   `time dvc checkout file1.big.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   So, checkout takes a significant time as well, because it has to
   copy the file from the cache to the workspace (and the copy
   operation is not so efficient on ext4).
   
4. Clean up:

   `cd ..`{{execute}}
   
   `rm -rf proj1/`{{execute}}
