# Running a stage

We define stages to run them by

`dvc repro prepare`{{execute}}

If the stage outputs are not where they should be, or the dependencies of the
stage has changed, this command runs the stage.

`dvc repro prepare`{{execute}}

It doesn't run the stage because no dependencies have changed, no outputs are
missing and no parameters to the experiment have changed. 

If you want to run the stage even if no dependencies or parameters have changed,
you can use `--force` option:

`dvc repro --force prepare`{{execute}}

Note that as you don't have any other stages currently, you can:  

`dvc repro`{{execute}}

to reproduce the stage. The command runs the whole pipeline and that pipeline
has a single stage. 

In the next step, let's see how DVC tracks stage information in files and how
can we define new stages by editing them.
