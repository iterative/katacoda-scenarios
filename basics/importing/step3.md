# Getting different versions of data

The command `dvc get` has also an option `--rev` that allows to
download a certain revision of the file.

1. Let's try the `--rev` option:

   `rm file.txt`{{execute}}
   
   `cd ../proj1`{{execute}}
   
   `git log --oneline`{{execute}}
   
   `cd -`{{execute}}
   
   `dvc get ../proj1 file.txt --rev v1`{{execute}}
   
   `cat file.txt`{{execute}}
   
   `dvc get ../proj1 file.txt --rev=v2`{{execute}}
   
   `cat file.txt`{{execute}}
   
   `mv file.txt file.txt.v2`{{execute}}
   
   ```
   dvc get ../proj1 file.txt \
       --rev=v1 -o file.txt.v1
   ```{{execute}}
   
   `cat file.txt.v1`{{execute}}

   The option `-o, --out` tells the name where to save the downloaded
   file.

2. If we wanted to download manually a certain version of the file, we
   would use `git checkout <rev>` first, and then `dvc pull`, like
   this:
   
   `cd tmp/`{{execute}}
   
   `git log --oneline`{{execute}}
   
   `git checkout v1`{{execute}}
   
   `dvc status file.txt.dvc`{{execute}}
   
   `dvc status file.txt.dvc -c`{{execute}}
   
   `dvc pull file.txt.dvc`{{execute}}
   
   `dvc status file.txt.dvc -c`{{execute}}
   
   `cat file.txt`{{execute}}
   
   `cp file.txt ../`{{execute}}
   
   `cd ..`{{execute}}
   ```
   
3. So far we have used `dvc get` from outside a DVC project. But
   sometimes it may be convenient to use it from inside the DVC
   project itself, to get previous versions of a data file:
   
   `cd ..`{{execute}}
   
   `rm -rf dir1/`{{execute}}
   
   `cd proj1/`{{execute}}
   
   First let's restore the normal state of the project:
   
   `git status`{{execute}}
   
   `git checkout file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -caT`{{execute}}
   
   `dvc pull -aT`{{execute}}
   
   `dvc status -caT`{{execute}}
   
   `dvc status`{{execute}}
   
   Now let's get previous versions of the file using tags:
   
   ```
   dvc get . file.txt \
       --rev=v1 -o file.txt.v1
   ```{{execute}}

   ```
   dvc get . file.txt \
       --rev=v2 -o file.txt.v2
   ```{{execute}}
   
   `ls -l`{{execute}}
   
   `cat file.txt`{{execute}}

   `cat file.txt.v1`{{execute}}

   `cat file.txt.v2`{{execute}}
   
4. However, even if `dvc get` is used from inside the DVC project
   itself, and actually all the versions of the data may be present on
   the cache, it still depends on the data storage:

   `mv ../dvc-storage ../dvc-storage.bak`{{execute}}

   `rm file.txt.v{1,2}`{{execute}}
   
   `ls`{{execute}}
   
   ```
   dvc get . file.txt \
       --rev=v1 -o file.txt.v1
   ```{{execute}}

   It cannot find the cached file.
   
   `mv ../dvc-storage.bak ../dvc-storage`{{execute}}
