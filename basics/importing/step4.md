# Importing data

The command `dvc import` not only downloads the data, like `dvc get`,
but also creates a DVC tracking file for it and saves it to cache.
This means that it has to be used from inside a DVC project (unlike
`dvc get` which can be run from anywhere).

1. Create a second DVC project and import a file from the first one:

   `cd ..`{{execute}}

   `mkdir proj2`{{execute}}
   
   `cd proj2/`{{execute}}
   
   `dvc import ../proj1 file.txt`{{execute}}
   
   It doesn't work unless we are inside a DVC repository. Let's
   initialize DVC:
   
   `dvc init --no-scm -q`{{execute}}
   
   `tree -a`{{execute}}
   
   `dvc import ../proj1 file.txt`{{execute}}
   
   `tree -a`{{execute}}
   
   `cat file.txt`{{execute}}
   
   `cat file.txt.dvc`{{execute}}
   
   Notice the fields `repo:`, `url:` and `rev_lock:` which keep track
   of the origin of the imported file.
   
2. Try to update the imported file:
   
   `dvc status file.txt.dvc`{{execute}}
   
   `dvc repro file.txt.dvc`{{execute}}

   `cat file.txt.dvc | grep locked:`{{execute}}

   A locked stage cannot be reproduced, which means that the file will
   not be downloaded again when we try to reproduce it. This makes
   sense because downloading the same revision of the file from the
   same Git repository will result in the same file that we already
   have.
   
   However we can use `dvc update` if we want to update to the latest
   version of the file (which is on the master or on the top of a
   branch):
   
   `dvc update file.txt.dvc`{{execute}}
   
   `cat file.txt`{{execute}}
   
   Nothing has changed because there is no new version of the file on
   the Git repo.
   
3. Add a new version of the data file and try to update again:
   
   `cd ../proj1/`{{execute}}
   
   `echo 'test 4' > file.txt`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc commit file.txt.dvc`{{execute}}
   
   `dvc status file.txt.dvc`{{execute}}
   
   Commit changes to Git:
   
   `git status -s`{{execute}}
   
   `git diff file.txt.dvc`{{execute}}
   
   `git add file.txt.dvc`{{execute}}
   
   `git commit -m 'Change file.txt once more'`{{execute}}
   
   `git tag v4`{{execute}}
   
   `git log --oneline`{{execute}}
   
   Push cached files to the storage:
   
   `dvc status -c`{{execute}}
   
   `dvc push`{{execute}}
   
   `dvc status -c`{{execute}}
   
   Try to update it again:
   
   `cd ../proj2`{{execute}}
   
   `dvc update file.txt.dvc`{{execute}}
   
   `cat file.txt`{{execute}}
   
   `dvc status`{{execute}}

4. Like `dvc get`, with the option `--rev` we can also import a
   certain revision of a file:
   
   ```
   dvc import ../proj1 file.txt \
       --rev=v1 --out=file.txt.v1
   ```{{execute}}
   
   `tree`{{execute}}
   
   `cat file.txt.v1`{{execute}}
   
   `cat file.txt.v1.dvc`{{execute}}

   ```
   dvc import ../proj1 file.txt \
       --rev=v2 --out=file.txt.v2
   ```{{execute}}
   
   `tree`{{execute}}
   
   `cat file.txt.v2`{{execute}}

   `cat file.txt.v2.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc update file.txt.v1.dvc`{{execute}}

   Since the revision `v1` that we have used is a tag, `dvc update`
   will never find a newer version to download. But if it was a
   branch, then it would get the latest version on top of that branch.
