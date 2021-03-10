In ML projects, usually we need to process data and generate outputs in a
reproducible way. This requires establishing a connection between the data
processed, the program that processes them, its parameters, and the outputs.

![](/dvc/courses/get-started/stages/assets/example-flow.png)

This process is reflected in DVC with a [data pipeline][bcpipeline]. In this
scenario, we begin to build pipelines using stage definitions and connect them
together.

[bcpipeline]: https://dvc.org/doc/user-guide/basic-concepts/pipeline

[Stages][bcstage] are the basic building blocks of pipelines in DVC. They define
and execute an action, like data import or feature extraction, and usually
produce some output. 

[bcstage]: https://dvc.org/doc/user-guide/basic-concepts/stage

We have a machine learning project already provided in `~/project`. We provided
source files in `~/project/src/`, downloaded data to `data/data.xml`, and made
it smaller. You can review these steps in more detail in [Data and Model
Versioning][v] and [Accessing Data and Models][a] scenarios.

[v]: https://katacoda.com/dvc/courses/get-started/versioning
[a]: https://katacoda.com/dvc/courses/get-started/accessing

You can use the editor to browse the project.
