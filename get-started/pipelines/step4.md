# Reproducing the model

Let's use the pipeline to produce `model.pkl` again:

`dvc status`{{execute}}

`dvc repro`{{execute}}

Since nothing has changed and all the outputs are up to date, there is
nothing to be executed and nothing to be reproduced.

But let's delete the first line of `data/data.xml` and see what
happens:

`sed -i data/data.xml -e '1d'`{{execute}}

`dvc status`{{execute}}

`dvc repro`{{execute}}

- Since we changed the data file, the stage `prepare` was rerun
  and its outputs changed (in directory `data/prepared/`).

- But `data/prepared` is a dependency of `featurize`, so this
  stage was rerun as well and its outputs changed (in directory
  `data/features/`).

- Finally, directory `data/features` is a dependency of the stage
  `train`, so this stage was rerun and `model.pkl` was reproduced.

Along the way, `dvc repro` has saved to cache all the changed
dependencies and outputs of the stages, and `dvc status` confirms
that everything is up to date with the cache:

`dvc status`{{execute}}

`dvc repro`{{execute}}

As a result, `dvc repro` does not have to rerun anything.

`git status -s`{{execute}}

`git diff`{{execute}}

However `data/data.xml.dvc` and `dvc.lock` are now pointing to new versions of
cached files (indicated by the changed MD5 hashes of dependencies and
outputs). We should take a snapshot of the current state of the
project by committing them to git:

`git add .`{{execute}}

```
git commit \
    -m "Produced another version of model.pkl"
```{{execute}}

If we want to share these data files and outputs with other people,
we should also upload them to the data storage:

`dvc status -c`{{execute}}

`dvc push`{{execute}}

`dvc status -c`{{execute}}
