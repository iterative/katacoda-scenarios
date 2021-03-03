# Running a stage

There are basically two options when it comes to run a stage in DVC 2.0. The
first is running a stage as a part of `dvc experiment`. The command `dvc exp
run` can be used to run the stages we defined by `dvc stage add`. We'll see the
second option later in this scenario. 

In order to run a single stage found in the current directory, we provide the
name to `dvc exp run` like:

`dvc exp run prepare`{{execute}}

If the stage outputs are not where they should be, or the dependencies of the
stage has changed, this command runs the stage.

Note that it provides an auto-generated experiment name for the run. This
experiment name is deterministic and depends on various factors that make up a
stage unique. If none of these change, the _experiment_ we run will not be
repeated by default. 

`dvc exp run prepare`{{execute}}

The command reports an error because no dependencies have changed, no outputs
are missing and no params to the experiment have changed. 

If you want to run the stage even if no dependencies or parameters have changed,
you can use `--force` option:

`dvc exp run --force prepare`{{execute}}

`dvc exp run` has much more capabilities, like running a set of chained
dependencies

`dvc exp` is the _experiment management_ command introduced in DVC 2.0 and we'll
delve into it in another scenario.

In the next step, let's see how DVC tracks stage information in files and how
can we define new stages by editing them.
