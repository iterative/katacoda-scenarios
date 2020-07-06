# Track a file or directory

Let's get a data file from the [Get Started](https://dvc.org/doc/start) example
project:

```
dvc get \
  https://github.com/iterative/dataset-registry \
  get-started/data.xml -o data/data.xml
```{{execute}}

> The command `dvc get` is like `wget`, but it is used to download data
> artifacts from DVC projects which are hosted on Git repositories.

`ls -lh data/`{{execute}}

To track a large file, ML model or a whole directory with DVC we use `dvc add`:

`dvc add data/data.xml`{{execute}}

`cat data/.gitignore`{{execute}}

DVC has listed `data.xml` on `.gitignore` to make sure that we don't commit it
to Git.

Instead, we track with Git the file `data/data.xml.dvc`:

```
git add data/.gitignore \
        data/data.xml.dvc
```{{execute}}

```
git commit -m "Add raw data to project"
```{{execute}}
