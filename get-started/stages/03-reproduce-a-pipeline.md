# Reproduce the outputs of the stage

In a machine learning project, stages usually depend on more than one element
and when one of these change, the part of the pipeline that depends on the
updated element becomes invalid.

In the previous stage, we created a stage without actually running by editing
`dvc.yaml`.

We use `dvc repro` command to (re)run a stage and (re)produce its outputs.

In the first step, we run the `prepare` stage by supplying it to `dvc run` and
let's see what happens when we reproduce. First we check the status of the stage
by `dvc status` command:

`dvc status prepare`{{execute}}

and rerun the stage:

`dvc repro prepare`{{execute}}

As you can see, DVC didn't run `src/prepare.py` because the dependencies of the
stage (`data/data.xml` and `src/prepare.py`) didn't change, and the outputs of the
stage (`data/prepared/`) are already where expected.

Let's check the next stage's status:

`dvc status featurize`{{execute}}

For the `featurization` stage, however, DVC runs the script because the outputs
are not there and the dependencies (as their MD5 hashes are missing from
`dvc.lock`) is considered changed.

`dvc repro featurize`{{execute}}

We can see the status of the whole pipeline using:

`dvc status`{{execute}}

The pipeline is fully run, outputs are fully in the cache and without any
changes `dvc repro` won't rerun any part of it.

`dvc repro`{{execute}}

Suppose we decided to update our code for `src/prepare.py` by adding the
following line to it.

<pre class="file" data-filename="stages/src/prepare.py" data-target="append">
# THIS COMMENT CHANGES MD5 HASH OF THE FILE
</pre>

Now when we run the pipeline again, we see that `prepare` step is run again. 

`dvc repro`{{execute}}

But as the _content_ of files in `prepared/` directory didn't change because of
the line we added, DVC doesn't run `featurize` again. DVC checks the actual
content of outputs to see whether a stage has to be run or not. 

In the next step we'll see how to clean artifacts and rerun everything. 


Finally, let's save the current state of the project to Git:

`git status -s`{{execute}}

`git add data/.gitignore dvc.yaml dvc.lock`{{execute}}

`git commit -m "Create data preparation stage"`{{execute}}
   
It is also recommended to push the data files to the storage:
   
`dvc status -c`{{execute}}

`dvc push`{{execute}}

`dvc status -c`{{execute}}
