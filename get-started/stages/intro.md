The commands that we have seen so far (`add`, `push`, `pull`, etc.) provide a
useful framework to track, save and share models and large data files. In
some cases and projects, this could be all you need.

Usually, in ML projects, you need to process data and generate
outputs in a reproducible way. This requires establishing a connection
between the data processed, the program that processes them,
the parameters, and the outputs. This
relationship between these components should support and facilitate
reproducibility. 

This is exactly what stages in DVC do.
