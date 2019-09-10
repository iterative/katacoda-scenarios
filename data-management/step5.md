# Tracking multiple files and directories

1. Let's try to track multiple files:

   `rm -rf .dvc *`{{execute}}
   
   `dvc init --no-scm`{{execute}}
   
   `mkdir dir1`{{execute}}
   
   `echo 'test 1' > dir1/file1.txt`{{execute}}
   
   `echo 'test 2' > dir1/file2.txt`{{execute}}
   
   `echo 'test 3' > dir1/file3.txt`{{execute}}
   
   `tree -a`{{execute}}
   
   `dvc add dir1/*.txt`{{execute}}
   
   `tree -a`{{execute}}

   `dvc status`{{execute}}

   So, adding multiple files is the same as adding them one by one.
   
2. Since all the files are inside a directory, we can also track the
   directory with the option `-R, --recursive`:
   
   `dvc destroy -f`{{execute}}
   
   `dvc init --no-scm`{{execute}}
   
   `tree -a`{{execute}}
   
   `dvc add -R dir1`{{execute}}

   `tree -a`{{execute}}
   
   `dvc status`{{execute}}
   
   As you see, this is the same as the case above, adding the files
   one by one.
   
3. If we want to track the content of the directory as a dataset,
   where all the files are regarded as a whole, we should not use the
   option `-R`.
   
   `dvc destroy -f`{{execute}}
   
   `dvc init --no-scm`{{execute}}
   
   `tree -a`{{execute}}
   
   `dvc add dir1`{{execute}}
   
   `tree -a`{{execute}}

   You see that a file `dir1.dvc` is created for tracking the
   directory as a whole:
   
   `cat dir1.dvc`{{execute}}
   
   `ls .dvc/cache/85/db9c47282441a680dd344c7b5210eb.dir`{{execute}}
   
   `md5sum .dvc/cache/85/db9c47282441a680dd344c7b5210eb.dir`{{execute}}
   
   `cat .dvc/cache/85/db9c47282441a680dd344c7b5210eb.dir`{{execute}}
   
   ```
   cat .dvc/cache/85/db9c47282441a680dd344c7b5210eb.dir \
       | python3 -m json.tool
   ```{{execute}}
   
   The cache entry for this directory has the extension `.dir`. Its
   content is a JSON list of the files of the directory. For each file
   it keeps the name and the checksum of the file. If either the name,
   or the content of a file is changed, or if some files are deleted
   or new files are added, the checksum of the directory will change
   and DVC will store a different entry on the cache.

4. Let's clean up everything:

   `rm -rf .dvc *`
