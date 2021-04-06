# Reusing (importing) data or models

Modern programming languages have a way to package, distribute, and reuse code
as libraries (in the Python world - [PyPI](https://pypi.org/), `pip`, `conda`
are some well-known examples). It's an important feature that significantly
simplifies managing the complexity of the development process.

What about datasets and ML models?

A DVC repository and the `dvc import` command are enough to export data and models,
reuse them, track upstream changes, etc. Let's give it a try:

```
mkdir data
dvc import \
  https://github.com/iterative/dataset-registry \
  get-started/data.xml -o data/data.xml
```{{execute}}

`dvc import` command creates `data/data.xml.dvc` to track the dependency. You
can view this file in the editor: 

`example-get-started/data/data.xml.dvc`{{open}}

The `url` and `rev_lock` subfields under `repo` are used to save the origin and
the version of the dependency, respectively:

The effect of using `dvc import` is similar to running `dvc get` + `dvc add`,
but the resulting `.dvc` file includes metadata to track changes in the source
repository. This allows you to bring in changes from the data source later,
using:

`dvc update data/data.xml.dvc`{{execute}}

In this case, everything is up to date, but if someone creates a new version of
`data.xml` in the data registry, this command can detect the change and update the
`data/data.xml` file accordingly.
