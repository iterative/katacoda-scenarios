# Go back to baseline-experiment

Let's assume that we want to go back to the tag `baseline-experiment`
to check it again. We can do it like this:
   
`git checkout baseline-experiment`{{execute}}

`git status`{{execute}}

`dvc status`{{execute}}

`dvc checkout`{{execute}}

`dvc status`{{execute}}

`dvc repro evaluate.dvc`{{execute}}

With `dvc checkout` we bring back (from cache) all the data files
and outputs that correspond to the checked out version of `.dvc`
files. This is possible because the MD5 hashes of the data files,
which are kept inside the `.dvc` files, point to the right version
of data on the cache.

After the data are synchronized with `.dvc` files, `dvc status`
finds that everything is up to date, and `dvc repro` finds that no
commands need to be re-executed, because all the dependencies and
outputs are unchanged.

Let's go forward to the latest version again:

`git checkout master`{{execute}}

`dvc status`{{execute}}

`dvc checkout`{{execute}}

`dvc status`{{execute}}

`dvc repro evaluate.dvc`{{execute}}
