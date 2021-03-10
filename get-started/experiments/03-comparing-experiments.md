## Comparing many experiments

To compare all of these experiments, we need more than `dvc exp diff`: 

`dvc exp show` compares any number of experiments in one table:

```
dvc exp show --no-timestamp \
               --include-params train.n_est,train.min_split
```{{execute}}

Each experiment is given an arbitrary name by default (although we can specify
one with `dvc exp run -n`.) We can see that `exp-98a96` performed best among
both of our metrics, with 100 estimators and a minimum of 64 samples to split a
node.

You can see several options to present this table: 

`dvc exp show --help`{{execute}}


