# Track a file or directory

Let's get a data file from the [Get
Started](https://dvc.org/doc/start/data-and-model-versioning) example project:

```
dvc get \
  https://github.com/iterative/dataset-registry \
  get-started/data.xml -o data/data.xml
```{{execute}}

> The command [`dvc get`][cmdget] is like much streamlined and smart `wget`
> that can be used to retrieve artifacts from DVC projects hosted on Git
> repositories. You don't even need an _initialized_ DVC repository to use
> `get`

`ls -lh data/`{{execute}}

To track a large file, ML model or a whole directory with DVC we use `dvc add`:

`dvc add data/data.xml`{{execute}}

DVC has listed `data.xml` on `.gitignore` to make sure that we don't commit it
to Git.

`cat data/.gitignore`{{execute}}

Instead, we track `data/data.xml.dvc` with Git. 

```
git add data/.gitignore \
        data/data.xml.dvc

git commit -m "Add dataset to the project"
```{{execute}}


[cmdget]: https://dvc.org/doc/command-reference/get
