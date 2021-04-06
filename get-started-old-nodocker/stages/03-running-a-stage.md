# Running a stage

We run particular stages by supplying their name to `dvc repro`. 

`dvc repro prepare`{{execute}}

It runs the stage if the dependencies of a stage have changed or the
outputs are absent.

`dvc repro prepare`{{execute}}

The command doesn't run the second time as no dependencies have been
modified, no outputs are missing, and no other conditions have been
changed.

It's possible to run the whole pipeline in a single command:

`dvc repro`{{execute}}

In the next step, let's see how DVC tracks stage information in files and how
we can define new stages by editing them.
