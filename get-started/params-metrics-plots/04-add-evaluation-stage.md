# Add evaluation stage

After adding the parameters to the pipeline, we want to see the effects these
parameters have in performance of the model. 

In order to evaluate the resulting model's performance, we use: 

`project/src/evaluate.py`{{open}}

We add this as another stage to the pipeline:

```
dvc stage add \
    -n evaluate \
    -d src/evaluate.py \
    -d model.pkl \
    -d data/features \
    --metrics-no-cache scores.json \
    --plots-no-cache prc.json \
    python \
        src/evaluate.py \
        model.pkl \
        data/features \
        scores.json \
        prc.json
```{{execute}}

Note the `--metrics-no-cache` argument used in `dvc stage add`. This defines
`scores.json` as a metric file. Metrics files show the differences in metrics
between runs of the pipeline. By using `-M / --metrics-no-cache` we ask DVC not
to cache the JSON file, as it's a text file that can be tracked with Git.

The evaluation command calculates an AUC value using the test
dataset. It reads features from the `data/features/test.pkl` file and
produces the metric file `scores.json`. 

The other option `--plots-no-cache` is used to generate a plots file
`prc.json`. A plot file is used by DVC to generate plots showing vairous
metrics to compare pipeline runs. `evaluate.py` writes precision, recall and
thresholds in an array to plots file. In a later step we'll generate a plot
showing the change in performance w.r.t. parameters. 

Now let's run the pipeline to generate first metrics and plots files. 

`dvc repro`{{execute}}

We can see the generated metric file: 

`project/scores.json`{{open}}

Let's get another snapshot of the project by committing changes to
Git:

`git add dvc.yaml dvc.lock scores.json prc.json`{{execute}}

`git commit -m "Create evaluation stage"`{{execute}}

Let's also assign a Git tag. It will serve as a checkpoint for us to
compare this approach with other experiments in the future, or if we
need to come back and check it out, and then get the corresponding data.

```
git tag -a "baseline-experiment" \
    -m "Baseline experiment evaluation"
```{{execute}}


