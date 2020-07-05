# Download

Let's first get/download any file that was added to DVC:

> You don't need to be inside a Git or DVC repo to execute it

```
dvc get \
    https://github.com/iterative/dataset-registry \
    get-started/data.xml
```{{execute}}

`ls data.xml`{{execute}}

`md5sum data.xml`{{execute}}

Here we see that instead of accessing data file directly (e.g. with `aws s3 cp`,
or `scp`, `wget`, etc) we are accessing it using a Git repo URL as an _entry
point_ or as a _data/model registry_.
