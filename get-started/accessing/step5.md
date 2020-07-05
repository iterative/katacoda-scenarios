# Reusing (importing) data or models

`dvc import` also downloads any file or directory, while also creating a `.dvc`
file that can be saved in the project:

`cd example-get-started`{{execute}}

```
dvc import \
  https://github.com/iterative/dataset-registry \
  get-started/data.xml -o data/data.xml
```{{execute}}

This is similar to `dvc get` + `dvc add`, but the resulting `.dvc` file includes
metadata to track changes in the source repository. This allows you to bring in
changes from the data source later, using `dvc update`.

`git diff data/data.xml.dvc`{{execute}}

The `url` and `rev_lock` subfields under `repo` are used to save the origin and
version of the dependency, respectively.
