The commands that we have seen so far (`add`, `push`, `pull`, etc.) provide a
useful framework to track, save and share models and large data files. In
some cases and projects, this could be all you need.

Usually, in ML projects, you need to process data and generate
outputs in a reproducible way. This requires establishing a connection
between the data processed, the program that processes them,
the parameters, and the outputs.

In a typical machine learning project we have the following stages: 

![](/dvc/courses/get-started/stages/assets/example-flow.png)

This process is reflected in DVC with a [pipeline][bcpipeline]. In this scenario
we begin to build pipelines using stage definitions and connect them together.

[bcpipeline]: https://dvc.org/doc/user-guide/basic-concepts/pipeline