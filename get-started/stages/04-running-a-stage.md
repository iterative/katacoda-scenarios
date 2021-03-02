# Running a stage

We use `dvc exp run` to run the stages we defined by `dvc stage`. In order to
run a single stage found in the current directory, we provide the name to `dvc
exp run` like

`dvc exp run prepare`{{execute}}

If the stage outputs are not where they should be, or the dependencies of the
stage has changed, this command runs the stage. 

If there is no change in dependencies, it doesn't run the stage and skips
silently:

`dvc exp run prepare`{{execute}}

If you want to run the stage even if the dependencies have not changed, you can
use `--force` option:

`dvc exp run --force prepare`{{execute}}

`dvc exp run` has much more capabilities, like running a set of chained
dependencies but we'll cover them in a later scenario.

In the next step, let's see how DVC tracks stage information in files and how
can we define new stages by editing this file.  
