The processing steps in an ML project usually look like this:

![](/dvc/courses/get-started/pipelines/assets/example-flow.png)

By using `dvc run` multiple times and specifying outputs of a stage
as dependencies in another one, we can describe a sequence of steps or
processes that are needed to get the desired result.

This is called a _data pipeline_ or _dependency graph_.
