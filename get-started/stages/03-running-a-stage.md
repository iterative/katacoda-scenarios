# Running a stage

We run particular stages by supplying their name to `dvc repro`. 

`dvc repro prepare`{{execute}}

It runs the stage if dependencies of a stage has changed or outputs are absent.

`dvc repro prepare`{{execute}}

The second command doesn't run the stage because no dependencies have changed,
no outputs are missing and no other conditions have been modified.

It's possible to run the whole pipeline with a single:

`dvc repro`{{execute}}

In the next step, let's see how DVC tracks stage information in files and how
can we define new stages by editing them.
