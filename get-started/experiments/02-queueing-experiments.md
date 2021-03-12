## Queueing experiments

We have been tuning the `featurize` stage so far, but there are also parameters
for the `train` stage, which trains a [random forest classifier][rfc].

[rfc]: https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestClassifier.html

`params.yaml`{{open}}

Let's setup experiments with different hyperparameters. We can define all the
combinations we want to try without executing anything, by using the `--queue`
flag:

```
dvc exp run --queue -S featurize.max_features=500 -S train.min_split=8
dvc exp run --queue -S featurize.max_features=1500 -S train.min_split=32
dvc exp run --queue -S featurize.max_features=1500 -S train.n_est=20
dvc exp run --queue -S featurize.max_features=1500 -S train.n_est=60
dvc exp run --queue -S featurize.max_features=1500 -S train.n_est=100
```{{execute}}

Next, run all queued experiments using `--run-all`:

`dvc exp run --run-all`{{execute}}

