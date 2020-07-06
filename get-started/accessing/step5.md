# Reusing (importing) data or models

Modern programming languages have a way to package, distribute, and reuse code
as libraries (in the Python world - [PyPI](https://pypi.org/) + `pip`, `conda` -
are some well known examples). It's an important feature that significantly
simplified managing complexity of the development process.

How about datasets? How about ML models?

DVC repositories and `dvc import` command are enough to export data and models,
reuse them, track upstream changes, etc. Let's give it a try:

`cd example-get-started`{{execute}}

```
dvc import \
  https://github.com/iterative/dataset-registry \
  get-started/data.xml -o data/data.xml
```{{execute}}

`ls data/`{{execute}}

The `url` and `rev_lock` subfields under `repo` are used to save the origin and
version of the dependency, respectively:

`git diff`{{execute}}

The effect of using `dvc import`, is similar to running `dvc get` + `dvc add`,
but the resulting `.dvc` file includes metadata to track changes in the source
repository. This allows you to bring in changes from the data source later,
using:

`dvc update data/data.xml.dvc`{{execute}}

In this case everything is up to date, but if someone creates a new version
of the `data.xml` in the data registry repository this command will detect this
and update the `data/data.xml.dvc` file accordingly.
