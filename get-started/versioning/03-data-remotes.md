# Data Remotes

DVC allows to set up [remotes][bcremote] that are accessible by other systems
or team members. 


To set up a data remote, you would typically use Amazon S3, Google Cloud, or
[another supported storage][cmdremote] type like:

```
dvc remote add --default \
    my-storage s3://my-bucket/dvc-storage
```

> Note that DVC remotes are _unlike_ Git remotes. DVC remotes are data 
> storage locations _without_ a commit history. History of data and model files
> are tracked in `*.dvc` text files, and these are typically shared with other
> team members as if they were code/text files.

It's possible to use a _local_ directory in the same file system as a _remote_
as well.  This allows fast backups.  We'll use this feature to keep this
scenario simple.

```
dvc remote add --default \
    mystorage /tmp/data-storage
```{{execute}}

You can get a list of configured remotes using:

`dvc remote list`{{execute}}

The configuration is typically stored in Git:

`git diff .dvc/config`{{execute}}

Let's commit the changes to Git: 

```
git commit .dvc/config \
    -m "Configure data storage"
```{{execute}}

[cmdremote]: https://dvc.org/doc/command-reference/remote/add
[bcremote]: https://dvc.org/doc/user-guide/basic-concepts/remote