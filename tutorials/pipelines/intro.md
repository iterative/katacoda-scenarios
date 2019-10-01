In this tutorial, we will focus on building a simple ML pipeline that
takes an archive with StackOverflow posts, trains the prediction model
and saves it as an output. For example, we want this classifier to
predict a post that is about the Python language by tagging it
`python`.

The pipeline itself is a sequence of transformations we apply to the
data file, which looks like this:

<img url="/dvc/courses/tutorials/pipelines/assets/example-flow.png" width="400" />

DVC helps to describe these transformations and manage the data
involved - input dataset we are processing, intermediate results
(useful if some transformations take a lot of time to run), output
models, etc. This way we can capture what data and code were used to
produce a specific model in a sharable and reproducible way.
