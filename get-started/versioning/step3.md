# Data remotes

`dvc push` and `dvc pull` commands can save and retrieve data files from the
`.dvc/cache` to a data remote - for backup, for other team members or systems
to have access to your work, etc. It's very similar to how we `git push` and
`git pull` Git commits to and from Github, but for DVC tracked data files.

Usually, you would use S3 bucket, Google cloud or a bunch of other supported
storage to setup a remote like this:

```
dvc remote add --default \
    my-storage s3://my-bucket/dvc-storage
```

> DVC supports the following remote storage types: Google Drive, Amazon S3,
> Azure Blob Storage, Google Cloud Storage, Aliyun OSS, SSH, HDFS, and HTTP.
> Please refer to
> [dvc remote add](https://dvc.org/doc/command-reference/remote/add) for more
> details and examples.

```
dvc remote add --default \
    mystorage /tmp/data-storage
```{{execute}}

For the sake of keeping this scenario simple and do not depend on some external
storage we'll use artificial "local" remote storage. Sometimes it can be useful
to backup data to a large mounted volume.

`dvc remote list`{{execute}}

`git status -s`{{execute}}

`git diff .dvc/config`{{execute}}

```
git commit .dvc/config \
    -m "Configure data storage"
```{{execute}}
