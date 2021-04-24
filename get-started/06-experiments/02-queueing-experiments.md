## Queueing experiments

For the MLP version of the project, we have two parameters that change the
number of hidden units and the activation function. 

`example-get-started/params.yaml`{{open}}

Let's setup experiments with different hyperparameters. We can define all the
combinations we want to try without executing anything, by using the `--queue`
flag:

```
dvc exp run --queue -n exp-1 -S model.mlp.units=32
dvc exp run --queue -n exp-2 -S model.mlp.units=64
dvc exp run --queue -n exp-3 -S model.mlp.units=128
dvc exp run --queue -n exp-4 -S model.mlp.units=256
```{{execute}}

The `-n` option is used to label the experiments. If it's not specified,
DVC provides a name. We set the names for easier reference here. 

Next, run all queued experiments using `--run-all`:

`dvc exp run --run-all`{{execute}}

