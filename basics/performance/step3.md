# Using symlinks

The fast and efficient **reflink** copy works only inside the
boundaries of a filesystem. If for some reason the data files and the
cache have to be on different filesystems, a slow and inefficient
normal copy is going to be used.

If this is the case, then we can configure DVC to use **symlink**
(which work across filesystem boundaries).

1. Check first that we cannot use **reflink** to copy files from
   outside the filesystem:
   
   `ls -al proj1/`{{execute}}
   
   `cd proj1/`{{execute}}
   
   `tree -a`{{execute}}
   
   `fallocate -l 6G ../file2.big`{{execute}}
   
   `cp --reflink ../file2.big .`{{execute}}
   
   It fails.
   
   `time cp ../file2.big .`{{execute}}
   
   `ls -l`{{execute}}
   
   `rm file2.big`{{execute}}
   
   `time rsync --progress ../file2.big .`{{execute}}
   
   `rm file2.big`{{execute}}
   
2. Set the cache type to `reflink,symlink`:

   `dvc config cache.type reflink,symlink`{{execute}}
   
   `dvc config cache.type`{{execute}}
   
   This means that DVC will first use `reflink` to copy a data file to
   cache, and if this is not possible it will try with a symlink.
   
   By the way, the default value of `cache.type` is `reflink,copy`,
   which means that if a `reflink` copy is not possible, a normal
   `copy` will be used. That's why reflink worked automatically on
   the last step, without us having to change any configurations.
   
   `dvc config cache.protected true`{{execute}}
   
   `dvc config cache.protected`{{execute}}
   
   The setting `cache.protected` makes the cache files write-protected
   (read-only). This is needed when we use symlinks, otherwise a
   process that tries to modify the data file will end up modifying
   its cached copy (since the data file is actually just a symlink to
   the cached copy), and this would corrupt the cache.
   
   `cat .dvc/config`{{execute}}
   
3. Track a file which is on the same filesystem with the cache:

   `fallocate -l 10G file3.big`{{execute}}

   `dvc add file3.big`{{execute}}
   
   `cat file3.big.dvc`{{execute}}
   
   `ls -al`{{execute}}
   
   `ls -Rlh .dvc/cache/`{{execute}}
   
   No symlink is used. But still the cache file that was created is
   read-only (due to `cache.protected`).
   
   `dvc remove -p file3.big.dvc`{{execute}}
   
   `dvc gc`{{execute}}
   
4. Track `../file2.big` (which is on a different filesystem from the cache):

   `realpath ../file2.big`{{execute}}
   
   `time dvc add /root/file2.big`{{execute}}
   
   Notice that this still takes time for a big file, since a copy of
   the file is moved to the cache.
   
   `cat file2.big.dvc`{{execute}}
   
   `cat file2.big.dvc | grep 'path:'`{{execute}}
   
   (By the way, notice that DVC is able to track files that are
   outside its root directory, as is the case with `/root/file2.big`.)
   
   `ls -l ..`{{execute}}
   
   `ls -l ../file2.big`{{execute}}
   
   `ls -Rlh .dvc/cache/`{{execute}}
   
   Notice that the cached file corresponding to `file2.big` is not
   writable (is read-only).
   
   **Attention:** As you see, caching a file in _symlink_ mode replaces
   it with a symlink to the cache. This may potentially break any
   other process that uses the file and does not expect it to be
   replaced by a symlink. So, be careful and know what you are doing.
   
5. Checkout with a symlink is fast:
   
   `dvc status`{{execute}}
   
   `rm ../file2.big`{{execute}}
   
   `ls -l ..`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout file2.big.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `ls -l ..`{{execute}}
   
6. If you want to modify `../file2.big`, you need to unprotect it
   first:
   
   `time dvc unprotect ../file2.big`{{execute}}
   
   `ls -l ..`{{execute}}
   
   `ls -Rlh .dvc/cache/`{{execute}}
   
   However notice that this again takes a long time, since it replaces
   the symlink with a copy of the cached file.
   
   `dvc status`{{execute}}
   
   `echo xyz >> ../file2.big`{{execute}}
   
   `dvc status`{{execute}}
   
   `time dvc commit file2.big.dvc`{{execute}}
   
   `ls -l ..`{{execute}}
   
   `ls -Rlh .dvc/cache/`{{execute}}
   
   Again the cached file is read-only.
   
7. If you are tracking a directory (instead of a file), where files
   can be added or deleted, but each file is not modified after it is
   added (for example if it is a directory of images), then you don't
   need to run `dvc unprotect` before modifying the directory. This
   would save time, since we have seen that `dvc unprotect` is an
   expensive operation.
   
   `mkdir ../dir1`{{execute}}
   
   `echo 'test 1' > ../dir1/file1.txt`{{execute}}
   
   `echo 'test 2' > ../dir1/file2.txt`{{execute}}
   
   `echo 'test 3' > ../dir1/file3.txt`{{execute}}
   
   `ls -l ../dir1/`{{execute}}
   
   `dvc add /root/dir1`{{execute}}
   
   `cat dir1.dvc`{{execute}}
   
   `ls -l ../dir1/`{{execute}}
   
   `tree -a`{{execute}}
   
   Add another file:
   
   `dvc status`{{execute}}
   
   `echo 'test 4' > ../dir1/file4.txt`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc commit dir1.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `ls -l ../dir1/`{{execute}}
   
   Remove a file:
   
   `rm ../dir1/file1.txt`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc commit dir1.dvc`{{execute}}
   
   `dvc status`{{execute}}


As a conclusion, try to avoid symlinks, unless you have no other
choice. Their benefits are not so great, and they may also bring some
headaches.
