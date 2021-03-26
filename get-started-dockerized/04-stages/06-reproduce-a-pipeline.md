# Reproduce the outputs of the stage

Now we are ready to execute the pipeline with a single command.

> 🦉 Note that we didn't update `dvc.lock` file when we updated
> `dvc.yaml`. Currently, the lock file doesn't contain any information
> about the new stage.

Let's check the status of the pipeline first:

`dvc status`{{execute}}

Now, run the pipeline with a single command:

`dvc repro`{{execute}}

DVC doesn't run the `prepare` stage as its dependencies didn't change, and
outputs are already where they should be. For the _featurization_ stage
DVC runs the script.

Let's see the status of the whole pipeline using:

`dvc status`{{execute}}

The pipeline is fully run, the outputs are all in the cache, and without
changes `dvc repro` won't rerun any part of it.

`dvc repro`{{execute}}

Suppose we decided to update our code for `src/prepare.py` by adding the
following line to it.

`example-get-started/src/prepare.py`{{open}}

<pre class="file" data-filename="src/prepare.py" data-target="append">
# THIS COMMENT CHANGES MD5 HASH OF THE FILE
</pre>

This time, we see that `prepare` is run.

`dvc repro`{{execute}}

But as the _content_ of files in `prepared/` directory didn't change, DVC
doesn't run `featurize`.
