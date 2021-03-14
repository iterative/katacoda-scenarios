# Visualize the pipeline

As we learned earlier, we can list the stages with 

`dvc stage list`{{execute}}

This command lists the names and outputs of each stage. 

There is another command to visualize DVC pipelines. With `dvc dag` it's
possible to get an ASCII diagram of the stage dependencies. Let's see what our
pipeline is doing:

`DVC_PAGER=cat dvc dag`{{execute}}

Instead of stage names, we can also get the outputs of each stage.

`DVC_PAGER=cat dvc dag --outs`{{execute}}

DVC also provides `.dot` output in GraphViz format. If you like, you can
convert this output to an image (or PS, PDF), first installing
[GraphViz][graphviz].

`apt update & apt install -y graphviz`{{execute}}


`dvc dag --dot | dot -Tpng -o pipeline.png `{{execute}}

Now we can view the pipeline [here][pipeline].

[pipeline]: https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/pipeline.png

Let's commit the changes in this step to Git.

```
git add dvc.yaml 

git commit -m "another stage to the pipeline is added"
```{{execute}}

In the next step, we'll see how to run these two stages together.

[graphviz]: https://graphviz.org