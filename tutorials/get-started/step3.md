# Data sharing

In order to share data or models outside of the context of a single
project, for example with other collaborators, or even with yourself,
in a different computing environment, we need to setup a data storage.
It's similar to the way you would use GitHub or any other Git server
to store and share your code.
   
1. Setup a data storage:

   `dvc remote list`{{execute}}
   
   `mkdir /tmp/data-storage`{{execute}}
   
   ```
   dvc remote add --default \
       mystorage /tmp/data-storage
   ```{{execute}}

   `dvc remote list`{{execute}}
   
   `git status -s`{{execute}}
   
   `git diff .dvc/config`{{execute}}
   
   ```
   git commit .dvc/config \
       -m "Configure data storage"
   ```{{execute}}
   
   For simplicity we have created a local data storage, however DVC
   supports several types of storages, like: `ssh`, `s3`, `gs`,
   `azure`, `hdfs`, etc. For example to setup a S3 storage we would
   use something like this:
   
   ```
   dvc remote add -d \
       s3storage s3://mybucket/myproject
   ```
   
2. Push the cached files to the data storage:

   `dvc status`{{execute}}
   
   `dvc status --cloud`{{execute}}
   
   This command compares the state of the cache with the state of the
   data storage (the option `-c, --cloud`). It shows that there is a
   new file on the cache that has not been uploaded to the data
   storage.
   
   `dvc push`{{execute}}
   
   `dvc status --cloud`{{execute}}
   
   `tree /tmp/data-storage/`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   The command `dvc push` has uploaded the cached file to the data
   storage.
   
3. Pull files from the data storage:

   For the sake of example let's remove first the data file and the
   cache, and then let's try to retrieve it from the data storage.
   
   `rm data/data.xml`{{execute}}
   
   `rm -rf .dvc/cache/*`{{execute}}
   
   `git status`{{execute}}
   
   `ls data/`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}

   So, the file tracked by `data/data.xml.dvc` is missing. It is
   neither in the workspace nor in the cache. But it is on the data
   storage and we can get it with `dvc pull`:
   
   `dvc pull data/data.xml.dvc`{{execute}}
   
   `ls data/`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc status`{{execute}}
   

The command `dvc pull` is usually used after `git clone`, `git pull`,
or `git checkout` to synchronize the data with the code.  Along with
`dvc push`, it provides a basic collaboration workflow, similar to
`git push` and `git pull`.
