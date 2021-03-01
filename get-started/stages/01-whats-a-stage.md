# What's a stage?

[Stages][bcstage] are the basic building blocks of pipelines in DVC. They define
and execute an action, like data import or feature extraction, and usually
produce some output. In this scenario, we create stages and pipelines for a
machine learning project.

[bcstage]: https://dvc.org/doc/user-guide/basic-concepts/stage

We have a machine learning project already provided in `~/stages`. We covered
these steps in previous scenarios. DVC is installed. Data is downloaded from
`https://github.com/iterative/dataset-registry` and made smaller. A _local
remote_ is created in `/tmp/data-storage` named `mystorage`, and the data in the
DVC repository is pushed. Code and python requirements are prepared, and all
changes are committed to Git.

You can use the editor to browse the project.

