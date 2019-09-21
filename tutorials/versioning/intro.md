To show how DVC can be used to manage and version control machine
learning models and datasets, let's play with a
[tutorial](https://blog.keras.io/building-powerful-image-classification-models-using-very-little-data.html)
that [François Chollet](https://twitter.com/fchollet) put together to
show how to build a powerful image classifier, using only a small
dataset. The goal of this example is to get some hands-on experience
with a very basic scenario – working with multiple versions of
datasets and ML models using DVC commands.

<img url="/dvc/courses/tutorials/versioning/assets/cats-and-dogs.jpg" />

We first train a classifier model using 1000 labeled images, then we
double the number and retrain our model. We capture both datasets and
both results and show how to use dvc checkout along with git checkout
to switch between different versions.

The specific algorithm that is used to train and validate the
classifier is not important. No prior knowledge is required about
Keras. We reuse the script in a "black box" way – it takes some data
and produces a model file.
