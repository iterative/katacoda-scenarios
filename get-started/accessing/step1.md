# Download

`dvc get` can be considered an alternative to `wget`, `scp`, `aws s3 cp`, etc -
any command you would use to download a file or directory from your data
storage.

`cd ..`{{execute}}

> You don't need to be inside a Git or DVC repo to execute it

```
dvc get \
    https://github.com/iterative/dataset-registry \
    get-started/data.xml
```{{execute}}

`ls data.xml`{{execute}}

The obvious difference here is that instead of a remote storage path or HTTP URL
you would usually pass to download a file, we pass a Git repo!

Remember those `.dvc` files `dvc add` generates? Those files (and `dvc.lock`
that we'll cover later), their history in Git, DVC remote storage config saved
in Git contain all the information needed to access and download any version of
datasets, files, and models. It means that Git repository with DVC files becomes
an entry point and can be used instead of accessing files directly:
