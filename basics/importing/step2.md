# Download a file with `dvc get`

Before getting to `dvc import`, let's see first how `dvc get` works,
because they are closely related.

1. Let's go to another directory and try to download `file.txt` from
   the Git project:

   `mkdir ../dir1`{{execute}}
   
   `cd ../dir1/`{{execute}}
   
   `ls -al ../proj1/`{{execute}}
   
   `dvc get ../proj1 file.txt`{{execute}}
   
   `ls -al`{{execute}}
   
   `cat file.txt`{{execute}}
   
   The first argument of `dvc get` is the URL of the Git project, the
   second one is the file to be downloaded. Notice that `dvc get`
   works anywhere, it does not need the current directory to be a Git
   repo or a DVC project.
   
2. Let's delete `proj1/file.txt` and try it again:
   
   `rm file.txt`{{execute}}
   
   `rm ../proj1/file.txt`{{execute}}
   
   `ls -al ../proj1/`{{execute}}
   
   `dvc get ../proj1 file.txt`{{execute}}
   
   `ls -al`{{execute}}
   
   `cat file.txt`{{execute}}
   
   So, we removed the file `proj1/file.txt` but somehow we can still
   download it. What's going on?
   
3. Let's delete `proj1/file.txt.dvc` as well and try it once more:
   
   `rm file.txt`{{execute}}
   
   `rm ../proj1/file.txt.dvc`{{execute}}
   
   `ls -al ../proj1/`{{execute}}
   
   `dvc get ../proj1 file.txt`{{execute}}

   `ls -al`{{execute}}
   
   `cat file.txt`{{execute}}
   
   It can still be downloaded without the tracking file
   `file.txt.dvc`. What if we remove the DVC cache too?
   
4. Remove `proj1/.dvc/cache/` as well and try it again:

   `rm file.txt`{{execute}}
   
   `rm -rf ../proj1/.dvc/cache/`{{execute}}
   
   `ls -al ../proj1/.dvc/`{{execute}}
   
   `dvc get ../proj1 file.txt`{{execute}}

   `ls -al`{{execute}}
   
   `cat file.txt`{{execute}}
   
   It still works without the cache.
   
5. Where is the file being downloaded from? To understand it let's see
   how we would do it without `dvc get`:
   
   `rm file.txt`{{execute}}
   
   `mkdir tmp`{{execute}}
   
   `cd tmp/`{{execute}}
   
   `git clone ../../proj1 .`{{execute}}
   
   `ls -al`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
   `dvc remote list`{{execute}}
   
   `cat .dvc/config`{{execute}}
   
   `dvc status file.txt.dvc`{{execute}}
   
   `dvc status file.txt.dvc -c`{{execute}}
   
   `dvc pull file.txt.dvc`{{execute}}
   
   `ls -al`{{execute}}
   
   `cp file.txt ../`{{execute}}
   
   `cd ..`{{execute}}
   
   `cat file.txt`{{execute}}
   
   So, we downloaded it from the **default data storage** of the DVC
   project (with `dvc pull`), and this is where `dvc get` downloads it
   from too.

6. If we want to copy it directly from the data storage, without using
   `dvc pull`, we can do it like this:
   
   `rm file.txt`{{execute}}
   
   `cat tmp/.dvc/config`{{execute}}
   
   `cat tmp/file.txt.dvc`{{execute}}
   
   ```
   cat tmp/file.txt.dvc \
       | grep -e ' path: '
   ```{{execute}}
   
   ```
   cat tmp/file.txt.dvc \
       | grep -e ' md5: '
   ```{{execute}}
   
   ```
   cp /root/dvc-storage/22/44fbd6bee5dcbe312e387c062ce6e6 \
       file.txt
   ```{{execute}}
   
   `cat file.txt`{{execute}}

   We get the URL of data storage from `.dvc/config`, we get the file
   name and the MD5 hash from `file.txt.dvc`, and we can construct a
   `cp` command to copy the file.
   
   Note that in case that the default data storage is on cloud, the
   download command would be similar but different. For example
   instead of `cp` we might use `scp`, `wget` etc. depending on the
   type of storage.
