# Visualize the pipeline

Let's see the pipeline that we have built so far:

`dvc pipeline show train.dvc`{{execute}}

`dvc pipeline show train.dvc --ascii`{{execute}}

```
dvc pipeline show train.dvc \
    --ascii --commands
```{{execute}}

```
dvc pipeline show train.dvc \
    --ascii --outs
```{{execute}}
