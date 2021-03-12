# Reproduce the outputs of the stage

In a machine learning project, stages usually depend on more than one element
and when one of these change, the part of the pipeline that depends on the
updated element becomes invalid.

In the previous stage, we created a stage by editing `dvc.yaml`.

Now we are ready to execute the pipeline with a single command.

Note that we didn't update `dvc.lock` file when we update `dvc.yaml`. Currently,
the lock file doesn't contain any information about the new stage.

We have two options to run the whole pipeline. We saw the first one earlier,
while running the `prepare` step. We can use `dvc exp run` to run the whole
pipeline.

The other option is `dvc repro` command to (re)run a stage and (re)produce its
outputs. We will use `repro` in this step to run the pipeline. 

First we check the status of the stage by `dvc status` command:

`dvc status prepare`{{execute}}

and rerun the stage:

`dvc repro prepare`{{execute}}

DVC didn't run `src/prepare.py` because the dependencies of the
stage (`data/data.xml` and `src/prepare.py`) didn't change, and the outputs of the
stage (`data/prepared/`) are already where expected. Unlike `dvc exp run`, `dvc
repro` doesn't report an error in subsequent runs.

Let's check the next stage's status:

`dvc status featurize`{{execute}}

For the _featurization_ stage, however, DVC runs the script because the outputs
are not where they should be, and the dependencies (as their MD5 hashes are
missing from `dvc.lock`) are considered changed.

`dvc repro featurize`{{execute}}

We can see the status of the whole pipeline using:

`dvc status`{{execute}}

The pipeline is fully run, outputs are all in the cache and without any
changes `dvc repro` won't rerun any part of it.

`dvc repro`{{execute}}

Suppose we decided to update our code for `src/prepare.py` by adding the
following line to it.

<pre class="file" data-filename="src/prepare.py" data-target="append">
# THIS COMMENT CHANGES MD5 HASH OF THE FILE
</pre>

Now when we run the pipeline again, we see that `prepare` script is run again. 

`dvc repro`{{execute}}

But as the _content_ of files in `prepared/` directory didn't change, DVC
doesn't run `featurize` again. DVC checks the actual content of outputs to see
whether a stage has to be run or not.
