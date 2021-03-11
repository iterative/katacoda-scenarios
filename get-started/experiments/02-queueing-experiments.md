## Queueing experiments

We have been tuning the `featurize` stage so far, but there are also parameters
for the `train` stage, which trains a [random forest classifier][rfc].

[rfc]: https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestClassifier.html

`project/params.yaml`{{open}}

Let's setup experiments with different hyperparameters. We can define all the
combinations we want to try without executing anything, by using the `--queue`
flag:


```
dvc exp run --queue -S train.min_split=8
dvc exp run --queue -S train.min_split=64
dvc exp run --queue -S train.min_split=2 -S train.n_est=100
dvc exp run --queue -S train.min_split=8 -S train.n_est=100
dvc exp run --queue -S train.min_split=64 -S train.n_est=100
```{{execute}}

Next, run all queued experiments using `--run-all` (and in parallel with
`--jobs`):

`dvc exp run --run-all --jobs 2`{{execute}}
