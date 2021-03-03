# Visualize the pipeline

As we learned earlier, we can list the stages with 

`dvc stage list`{{execute}}

This command lists the names and outputs of each stage. 

There is another command to visualize DVC pipelines. With `dvc dag` it's
possible to get an ASCII diagram of the stage dependencies. Let's see what our
pipeline is doing:

`dvc dag`{{execute}}

Instead of stage names, we can also get the outputs of each stage.

`dvc dag --outs`{{execute}}

When we need to convert this graph into a graphical one, DVC aids us by
providing a `.dot` file in GraphViz format: 

`dvc dag --dot`{{execute}}

If you like, you can convert this output to an image (or PS, PDF) file by
[GraphViz][graphviz]. You can install GraphViz via: 

`apt update & apt install -y graphviz`{{execute}}

and convert the `.dot` file to PNG using: 

`dvc dag --dot | dot -Tpng -o pipeline.png `{{execute}}

Now we can view the pipeline in an image format by clicking the link below: 

`stages/pipeline.png`{{open}}

Let's commit the changes in this step to Git.

```
git add dvc.yaml 

git commit -m "another stage to the pipeline is added"
```{{execute}}

In the next step, we'll see how to run these two stages together.

[graphviz]: https://graphviz.org