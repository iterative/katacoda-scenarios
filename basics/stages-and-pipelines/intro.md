A data pipeline, in general, is a series of data processes (for
example console commands that take an input and produce an output). A
pipeline may produce intermediate data, and has a final
result. 

DVC has a built-in way to connect ML steps into a DAG and run the full
pipeline end-to-end. DVC handles caching of intermediate results and
does not run a step again if input data or code are the same.

Let's see how it works.
