In ML projects, usually we need to process data and generate outputs in a
reproducible way. This requires establishing a connection between the data
processed, the program that processes them, its parameters, and the outputs.

![](/dvc/courses/get-started/stages/assets/example-flow.png)

This process is reflected in DVC with a [data pipeline][bcpipeline]. In this
scenario, we begin to build pipelines using stage definitions and connect them
together.


[bcpipeline]: https://dvc.org/doc/user-guide/basic-concepts/pipeline

[Stages][bcstage] are the basic building blocks of the pipelines in DVC. They
define and execute an action, like data import or feature extraction, and
usually produce some output. 

[bcstage]: https://dvc.org/doc/user-guide/basic-concepts/stage

In this scenario, our goal is to create a project that
classifies the questions and assigns tags to them. Tasks like
data preparation, training, testing, evaluation are run
manually, and this is prone to errors caused by too many moving
parts. Pipelines provide a reproducible way to organize these
tasks. 

If you prefer to run locally, you can also supply the commands in this scenario
in a container: 

```
docker run -it dvcorg/doc-katacoda:start-stages
```{{copy}}
