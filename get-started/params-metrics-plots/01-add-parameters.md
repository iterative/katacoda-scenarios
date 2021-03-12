# Adding parameters to pipelines

In the previous scenario, we defined a two-stage pipeline to split the data into
training and test sets and extract features for each. In this scenario, the
first step is to add parameters to this pipeline to modify the outputs without
code changes.

The programs that run these stages already have parameter definitions in them.

`src/prepare.py`{{open}}

`src/featurization.py`{{open}}

Specifically, we can see that `params.yaml` is loaded in these files:

`grep 'params.yaml' src/prepare.py src/featurization.py`{{execute}}

and the values are used to populate global variables: 

`grep 'params\[.*\]' src/prepare.py src/featurization.py`{{execute}}

Let's now check the content of `params.yaml` using the link below:

`params.yaml`{{open}}

In this scenario, we'll update the pipeline to see the effects of changes in
these variables. DVC has _first-class support_ for parameters used in
experimentation. It can track the parameter changes defined in YAML, JSON, TOML,
or Python files and run the affected stages.

By default, DVC uses a file named `params.yaml` to track parameters. (What a
coincidence!) However, these parameters should be referenced in `dvc.yaml` to
associate them with the stages.

Let's begin by reproducing the pipeline without parameters as a baseline:

`dvc repro`{{execute}}

and commit changes to Git:

```
git add data/.gitignore dvc.yaml data/prepared/ dvc.lock
git commit -m "baseline experiment without parameters"
```{{execute}}
