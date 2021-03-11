## Running experiments

In the [parameters and metrics scenario][scparams], we learned how to tune
pipelines and compare their performance. When the number of parameters
increase, however, it becomes unfeasible to keep track of the changes through
Git commits. Because of this DVC introduced a new way of running and comparing
experiments in repositories, without checking in them to Git.

All commands we'll see in this scenario are used as subcommands of `dvc exp`.
Let's see the help text first: 

`dvc exp --help`{{execute}}

The first command we'll use is `dvc exp run`. It's like `dvc repro` with added
features for experiments, like changing the hyperparameters with command line
options: 

`dvc exp run --set-param featurize.max_features=3000`{{execute}}

The `--set-param` (or `-S`) flag sets the values for parameters, as a shortcut
to editing `params.yaml`.

Check that the `featurize.max_features` value has been updated in `params.yaml`:

`git diff params.yaml`{{execute}}

We can compare the experiment results with:

`dvc exp diff`{{execute}}

