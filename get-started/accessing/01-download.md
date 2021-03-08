# Download

We can download any file in a DVC repository:

```
dvc get \
  https://github.com/iterative/dataset-registry \
  get-started/data.xml
```{{execute}}

`ls`{{execute}}

`md5sum data.xml`{{execute}}

We don't need to be in a DVC repository to use `dvc get`. Let's initialize DVC
now. 

`dvc init`{{execute}}

Instead of downloading the data file directly, e.g., with `aws s3 cp`, `scp`,
`wget`, we are accessing it using a Git repo URL as an _entry point_ or as
a [_data/model registry_][data-registries].

[data-registries]: https://dvc.org/doc/use-cases/data-registries