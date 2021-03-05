# Add a stage for training

In this step we'll see how parameters are defined using arguments supplied to
`dvc stage add`. 

We can check the list of current stages:

`dvc stage list`{{execute}}

We will add a training stage that runs `train.py` and produces `model.pkl`. It
will depend on featurization stage's output. As you may have already seen in
`params.yaml` file, the stage also has 3 parameters, `seed`, `n_est` and
`min_split`. These are used to populate the global variables in `train.py`.

`project/src/train.py`{{open}}

We use `-p / --params` option of `dvc stage add` to associate parameters in
`params.yaml` to a stage. When you need to use another filename for parameters,
you can also specify the name similar to `-p
myparamsfile.toml:myparam,another_param`. For this scenario, we stick to the
default filename, so no need to specify the file. 

We add a training stage and parameters using:

```
dvc stage add \
  -n train \
  -d src/train.py \
  -d data/features \
  -p seed,n_est,min_split \
  -o model.pkl \
  python3 src/train.py data/features model.pkl
```{{execute}}


Now let's get a diagram of the pipeline:

`dvc dag --dot | dot -Tpng -o pipeline.png`{{execute}}

and see it using VS Code:

`project/pipeline.png`{{open}}

Now let's run the whole pipeline to obtain the classification model,
`model.pkl`.

`dvc repro`{{execute}}

This runs the whole pipeline from preparation to training in a single
scoop with the parameter we supplied in `param.yaml`.

Finally, we commit the changes to Git. 

```
git add dvc.yaml dvc.lock params.yaml
git commit -m "Added training stage"
```