## Comparing many experiments

To compare all of these experiments, we need more than `dvc exp diff`: 

`dvc exp show` compares any number of experiments in one table:

```
dvc exp show --no-timestamp \
             --include-params model.mlp.units \
             --no-pager
```{{execute}}

As we have the most hidden units in MLP for `exp-4`, it has the highest
`categorical_accuracy`. 