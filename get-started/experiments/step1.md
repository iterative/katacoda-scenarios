# Add evaluation stage

Evaluation is done by `src/evaluate.py`:

```
highlight src/evaluate.py \
    -O xterm256 | less -r
```{{execute}}

Let's add an evaluation stage to the pipeline:

```
dvc run \
    -f evaluate.dvc \
    -d src/evaluate.py \
    -d model.pkl \
    -d data/features \
    -M auc.metric \
    python \
        src/evaluate.py \
        model.pkl \
        data/features \
        auc.metric
```{{execute}}

The evaluation command calculates an AUC value using the test
dataset. It reads features from the `data/features/test.pkl` file and
produces the metric file `auc.metric`, which is marked by the option
`-M`.  This option tells the stage to not store the metrics file in
cache; since it is just a small text file we can track it with Git. If
we wanted to store it in the DVC cache instead, we would have used the
option `-m` (lowercase).

`git status -s`{{execute}}

`cat evaluate.dvc`{{execute}}

`cat auc.metric`{{execute}}

`dvc metrics show`{{execute}}

Let's get another snapshot of the project by committing changes to
Git:

`git add evaluate.dvc auc.metric`{{execute}}

`git commit -m "Create evaluation stage"`{{execute}}

Let's also assign a Git tag. It will serve as a checkpoint for us to
compare this approach with other experiments in the future, or if we
need to come back and check it out and the get the corresponding data.

```
git tag -a "baseline-experiment" \
    -m "Baseline experiment evaluation"
```{{execute}}
