# Compare experiments across the tags

`dvc metrics show -T`{{execute}}

The option `-T, --all-tags` tells it to show the value of the
metric for all the tags. Since we have set a different tag to each
experiment, this effectively compares the performance of each
experiment.
