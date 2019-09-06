# Track a file

1. Initialize DVC again:

   `dvc init --no-scm`{{execute}}
   
   `tree -a`{{execute}}
   
   DVC doesn't have to be initialized on an empty directory (as in the
   previous example).

2. Start tracking `file1.txt`:

   `cat file1.txt`{{execute}}
   
   `dvc add file1.txt`{{execute}}
   
   `ls -l`{{execute}}
      
   `cat file1.txt.dvc`{{execute}}
   
   `md5sum file1.txt`{{execute}}

   `tree -a`{{execute}}
   
   `cat .dvc/cache/24/90a3d39b0004e4afeb517ef0ddbe2d`{{execute}}
   
   `diff -u file1.txt .dvc/cache/24/90a3d39b0004e4afeb517ef0ddbe2d`{{execute}}

   Do you see what happened? The file `file1.txt.dvc` that was created
   contains (among other things) the path of the tracked file `path: file1.txt`
   and its MD5 hash `md5: 2490a3d39b0004e4afeb517ef0ddbe2d`. A copy of the file
   `file1.txt` is stored on the cache, with a name that is composed of its MD5 hash.

3. Remove it and restore it:

   `rm file1.txt`{{execute}}
   
   `ls`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `ls`{{execute}}
   
   `cat file1.txt`{{execute}}
   
   DVC can detect a missing data file and can help us to restore it
   (from cache).

4. Modify it and restore it:

   `echo 'xyz' > file1.txt`{{execute}}
   
   `cat file1.txt`{{execute}}
   
   `cat file1.txt.dvc`{{execute}}
   
   `md5sum file1.txt`{{execute}}
   
   As you see, the MD5 sum of the new file is different from what is
   stored on the tracking file.
   
   `dvc status`{{execute}}
   
   And sure enough DVC detects that it has been modified.
   
   `dvc checkout file1.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `cat file1.txt`{{execute}}
   
   It has been restored from the version that was cached.

5. To stop tracking `file1.txt` we can simply remove the tracking file
   `file1.txt.dvc`:
   
   `rm file1.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `ls`{{execute}}
   
   Everything seems OK. However the cached version of the file is
   still there and now it is useless:
   
   `tree -a`{{execute}}
   
   We can clean it up like this:
   
   `dvc gc`{{execute}}
   
   `tree -a`{{execute}}
   
   `dvc status`{{execute}}
   
   The command `gc` means "garbage cleaner" and it removes from cache
   any dangling files (that are not referenced from any data-tracking
   files).
