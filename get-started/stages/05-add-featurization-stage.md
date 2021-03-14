# Add featurization stage

This time, we'll add a stage by editing `dvc.yaml` instead of `dvc stage add`.

_Featurization_ step is run by `src/featurization.py`. 

`src/featurization.py`{{open}}

We name the stage `featurize`. It has two dependencies: one is the code file,
and the other is the `prepared` data we got from the previous stage. It
produces the features ready for training as an output.

`dvc.yaml`{{open}}

Please click the below text to append the stage configuration to the file.

<pre class="file" data-filename="project/dvc.yaml" data-target="append">
  featurize:
    cmd: >-
        python3 src/featurization.py data/prepared data/features
    deps:
      - src/featurization.py
      - data/prepared
    outs:
      - data/features
</pre>

We created a [pipeline][bcpipeline] that receives the raw data in `data.xml`,
partitions it into the train and test sets and extracts features for the
dataset.

[bcpipeline]: https://dvc.org/doc/user-guide/basic-concepts/pipeline

```
git add dvc.yaml dvc.lock data/.gitignore
git commit -m "Configured prepare stage"
```{{execute}}
