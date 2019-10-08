# Setup a data storage

A _data storage_ is nothing but a but a backup place for
`.dvc/cache/`.  For analogy with `git remote`, data storages are
managed with `dvc remote`. However, similar to a Git remote repository
which can be a local directory, a DVC data storage can also be a local
directory.

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
