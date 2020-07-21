# Data remotes

Using `dvc push` and `dvc pull`, you can save and retrieve DVC tracked 
data files from the `.dvc/cache` to and from a data remote — similar 
to how you use `git push` and `git pull` to save and retrieve commits 
to and from Github.

You can use DVC data remotes to give other team members or systems access
to your work and to create backups.

To set up a data remote, you would typically use Amazon S3, Google Cloud, or 
another supported storage type like this:

```
dvc remote add --default \
    my-storage s3://my-bucket/dvc-storage
```

To keep this scenario simple and not dependent on a specific storage type,
we'll use local "remote" storage instead. A local data remote can also be
used to back up data to a locally-mounted volume.

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

> DVC supports the following remote storage types: Google Drive, Amazon S3,
> Azure Blob Storage, Google Cloud Storage, Aliyun OSS, SSH, HDFS, and HTTP.
> Please refer to
> [dvc remote add](https://dvc.org/doc/command-reference/remote/add) for more
> details and examples.
