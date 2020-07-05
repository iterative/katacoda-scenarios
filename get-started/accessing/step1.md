# Download

Let's first get/download any file that was added to DVC:

> You don't need to be inside a Git or DVC repo to execute it

```
dvc get \
    https://github.com/iterative/dataset-registry \
    get-started/data.xml
```{{execute}}

`ls data.xml`{{execute}}


Here we see that instead of accessing data file directly (e.g. with `aws s3 cp`,
or `scp`, `wget`, etc) we access it using a Git repo URL as an "entry point" or
"registry".

Remember those `.dvc` files `dvc add` generates? Those files (and `dvc.lock`
that we'll cover later), their history in Git, DVC remote storage config saved
in Git contain all the information needed to access and download any version of
datasets, files, and models.
