The commands that we have seen so far (`dvc add`, `dvc push`, `dvc pull`,
etc.) provide a useful framework to track, save and share
models and large data files. In some cases and scenarios this could be
all you need.

But usually in ML scenarios you need to process data and generate
outputs in a reproducible way. This requires establishing a connection
between the data that are processed, the program that processes them,
the parameters of processing, and the outputs of the process. This
relationship between these components should support and facilitate
reproducibility. And this is exactly what stages of DVC do.
