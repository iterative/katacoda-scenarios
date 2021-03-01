# Visualize the pipeline

We can visualize DVC pipelines using `dvc dag` command. Let's see what our pipeline is doing:

`dvc dag`{{execute}}

Now we are ready to execute the pipeline with a single command.

Note that we didn't update `dvc.lock` file. Currently, it doesn't contain
any information about the new stage.

Let's commit the changes to Git.

```
git add dvc.yaml 

git commit -m "another stage to the pipeline is added"
```{{execute}}

In the next step, we'll see how to run these two stages together.
