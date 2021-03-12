## Comparing many experiments

To compare all of these experiments, we need more than `dvc exp diff`: 

`dvc exp show` compares any number of experiments in one table:

```
dvc exp show --no-timestamp \
               --include-params train.n_est,train.min_split
```{{execute}}

Each experiment is given an arbitrary name by default (although we can specify
one with `dvc exp run -n`.) 

Although there are no clear winners (mostly due to the small size of the
data set), we can see that `exp-e25f6` has the best average precision
score, and `exp-ed009` has the best ROC score. 



