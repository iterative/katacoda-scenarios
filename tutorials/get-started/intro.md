
In this project we will build a simple ML project from scratch. It
explores the NLP problem of predicting tags for a given StackOverflow
question. For example, we want the model to classify posts about the
Python language by tagging them with `python`.

The processing steps in a ML project usually look like this:

![](/dvc/courses/tutorials/get-started/assets/example-flow.png)

DVC is designed to be pretty agnostic of frameworks, languages,
etc. If you have data files or datasets and/or you produce other data
files, models, datasets, and you want to:

- capture and save those data artifacts the same way we capture code
- track and switch between different versions of the data easily
- be able to answer the question of how data artifacts (e.g. ML
  models) were built in the first place
- be able to compare them
- bring best practices to your team and get everyone on the same page

then DVC might be the right tool for you.

**Note:** This interactive lesson is complementary to the
[Get Started](https://dvc.org/doc/get-started) tutorial. Please check
that for more details and elaborate explanations, as well as references
to other doc resources.
