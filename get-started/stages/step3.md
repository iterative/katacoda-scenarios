# Reproduce the outputs of the stage

The command `dvc repro` is used to rerun the command of the stage and
to reproduce its outputs:

`cat prepare.dvc`{{execute}}

`dvc status prepare.dvc`{{execute}}

`dvc repro prepare.dvc`{{execute}}

However, before running again the command of the stage, DVC checks
whether the dependencies have changed. The dependencies usually
include the inputs, the program that processes them, the configuration
parameters, etc. If none of them has changed, then it is guaranteed
that the outputs will be the same as before. So it makes no sense to
run the command again, since we already have the outputs (and even
have them saved in cache).

Our stage has as dependencies `src/prepare.py`, which has not changed,
and `data/data.xml`, which is tracked by `data/data.xml.dvc`. So, in
order to decide whether the outputs of the stage `prepare.dvc` need to
be reproduced, DVC has to check `data/data.xml.dvc` as well.

In our case nothing has changed, so nothing needs to be reproduced.
   
Finally, let's save the current state of the project to Git:

`git status -s`{{execute}}

`git add data/.gitignore prepare.dvc`{{execute}}

`git commit -m "Create data preparation stage"`{{execute}}
   
It is also recommended to push the data files to the storage:
   
`dvc status -c`{{execute}}

`dvc push`{{execute}}

`dvc status -c`{{execute}}
