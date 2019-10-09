# Get a previous version of the model

Let's say that we want to get a previous version of `model.pkl`, as it
was on tag `baseline-experiment`. Notice that `model.pkl` is an output
of `train.dvc`. We can do it like this:
   
```
git checkout \
    baseline-experiment train.dvc
```{{execute}}

`git status`{{execute}}

`git diff --cached train.dvc`{{execute}}

`dvc status train.dvc`{{execute}}

`dvc checkout train.dvc`{{execute}}

`dvc status train.dvc`{{execute}}

Let's get again the latest version of `train.dvc` and `model.pkl`:

`git status`{{execute}}

`git reset --hard`{{execute}}

`git status`{{execute}}

`dvc status`{{execute}}

`dvc checkout`{{execute}}

`dvc status`{{execute}}

