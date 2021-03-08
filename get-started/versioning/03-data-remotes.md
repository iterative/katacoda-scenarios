Most of the times it's necessary to share data files with team members. DVC
allows to set up a central location to share such content safely.
[Remotes][bcremote] that are accessible by other systems or team members can be
set up and versioned data and model files can be shared by uploading to and
downloading from them. 

[bcremote]: https://dvc.org/doc/user-guide/basic-concepts/remote

To set up a data remote, you would typically use Amazon S3, Google Cloud, or
another supported storage type like this:

```
dvc remote add --default \
    my-storage s3://my-bucket/dvc-storage
```

> Note that DVC remotes are unlike Git remotes. DVC remotes are cache and content
> storage locations _without_ a commit history. History of data and model files
> are tracked in `*.dvc` text files and these are typically shared with other
> team members as if they are code/text files. 

It's possible to use another directory in the same disk as a _remote_ also.
This allows fast backups and we'll use this feature to keep this scenario
simple. 

```
dvc remote add --default \
    mystorage /tmp/data-storage
```{{execute}}

You can get a list of configured remotes using:

`dvc remote list`{{execute}}

These configurations are typically stored in Git:

`git diff .dvc/config`{{execute}}

Let's commit the configuration to Git: 

```
git commit .dvc/config \
    -m "Configure data storage"
```{{execute}}


> DVC supports the following remote storage types: Google Drive, Amazon S3,
> Azure Blob Storage, Google Cloud Storage, Aliyun OSS, SSH, HDFS, and HTTP.
> Please refer to
> [dvc remote add](https://dvc.org/doc/command-reference/remote/add) for more
> details and examples.
