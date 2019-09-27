# Tracking data versions without Git

DVC allows us to cache different versions of a data file and to switch
between them. Let's see how to do it.

1. Initialize a DVC workspace and add a test file:

   `mkdir proj1`{{execute}}
   
   `cd proj1/`{{execute}}

   `dvc init --no-scm -q`{{execute}}
   
   `echo 'test 1' > file.txt`{{execute}}
   
   `dvc add file.txt`{{execute}}
   
   `tree -a`{{execute}}
   
   `dvc status`{{execute}}
   
2. As we know, `file.txt.dvc` is a reference to the cached file,
   through the checksum of the data file that it stores. Let's save it
   first, before we modify `file.txt`:

   `mkdir versions`{{execute}}
   
   `cp file.txt.dvc versions/file.txt.dvc.v1`{{execute}}
   
   `tree -a`{{execute}}
   
   Change the content of `file.txt`:
   
   `echo 'test 2' > file.txt`{{execute}}
   
   `dvc status`{{execute}}
   
   After the change, the content of `file.txt.dvc` is outdated,
   because it still has the checksum of the old version of the file,
   and therefore points to the old version of the file in the cache.
   Let's resolve this issue with `dvc commit`:
   
   `dvc commit file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `tree -a`{{execute}}
   
   `cat file.txt.dvc`{{execute}}
   
   `cat .dvc/cache/b0/b3b0dbf5330e3179c6ae3e0ac524c9`{{execute}}
   
   So, `dvc commit` has stored in cache the latest version of
   `file.txt`, and has updated `file.txt.dvc` with the checksum of the
   latest version. Now the current state of the data files is in sync
   again with the cache and `dvc status` is happy.
   
   Let's save again the current meta data file (`file.txt.dvc`) in
   `versions/`:
   
   `cp file.txt.dvc versions/file.txt.dvc.v2`{{execute}}
   
   `tree -a`{{execute}}
   
3. Let's change the data file once more and sync and save again:

   `echo 'test 3' > file.txt`{{execute}}

   `dvc status`{{execute}}
   
   `dvc commit file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `tree -a`{{execute}}
   
   `cat file.txt.dvc`{{execute}}
   
   `cp file.txt.dvc versions/file.txt.dvc.v3`{{execute}}
   
   `tree -a`{{execute}}
   
4. If we want to switch back to the first version of the data file, we
   can do it like this:
   
   `cp versions/file.txt.dvc.v1 file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `cat file.txt`{{execute}}
   
   As you see, when we restore the previous version of the tracking
   file, the status of the data file is shown as modified, because the
   checksum that it stores is different from the checksum of the
   current data file. When we run `dvc checkout`, a copy of the data
   file is restored from the cache (this is the first version of the
   data file), and then everything matches again.
   
5. Let's get the second version of the data file:

   `cp versions/file.txt.dvc.v2 file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `cat file.txt`{{execute}}

6. If you wish, try yourself to switch again to the third version of
   the data file.

7. Think about it (or try it): What happens if we run `dvc gc`? Can we
   switch to the other versions after doing that?
