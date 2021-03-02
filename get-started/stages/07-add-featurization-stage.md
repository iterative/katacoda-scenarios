# Add featurization stage

Our next step is to create a new stage by editing `dvc.yaml` file. Instead of
using `dvc stage add`, we create a new stage by editing `dvc.yaml` and run it
with DVC.

_Featurization_ step is run by `src/featurization.py`. You can check the
contents of this program by clicking the link below.

`stages/src/featurization.py`{{open}}

We use `dvc.yaml` file in the previous step to add another stage. We name the
stage `featurize`. It has two dependencies: one is the code file, and
the other is the prepared data we got from the previous stage. It produces features
ready for training as an output.

Please click the below link to open the file in the editor.

`stages/dvc.yaml`{{open}}

Now please click the below text to append the stage configuration to the file.

<pre class="file" data-filename="stages/dvc.yaml" data-target="append">
  featurize:
    cmd: >-
      python3 src/featurization.py data/prepared data/features
    deps:
      - src/featurization.py
      - data/prepared
    outs:
      - data/features
</pre>

Please save the file after adding the stage configuration.

We created a [pipeline][bcpipeline] that receives the raw data in `data.xml`,
partitions it into the train and test sets and extracts features for the
dataset.

[bcpipeline]: https://dvc.org/doc/user-guide/basic-concepts/pipeline

