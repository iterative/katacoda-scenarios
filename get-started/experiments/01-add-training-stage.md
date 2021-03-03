# Add a stage for training

In the previous scenario, we defined a two-stage pipeline to split the data into
training and test sets and extract features for each. 

Here we start by adding a training stage to the pipeline so we can experiment
the results. 

Training is done by `src/train.py`:

`pipelines/src/train.py`

Let's add the stage for training:

```
dvc stage add \
    -n train \
    -d src/train.py \
    -d data/features \
    -o model.pkl \
    python \
        src/train.py \
        data/features \
        model.pkl
```{{execute}}

We can see the list of stages:

`dvc stage list`{{execute}}

Now let's run the whole pipeline to obtain the classification model,
`model.pkl`.

`dvc repro`{{execute}}

This should run the whole pipeline from preparation to training in a single
scoop.

