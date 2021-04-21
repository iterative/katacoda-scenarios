Experiments proliferate quickly in ML projects where there are many parameters
to tune or other permutations of the code. DVC 2.0 introduces a new way to
organize such projects and only keep what we ultimately need with `dvc
experiments`. DVC can track experiments for you so there's no need to commit
each one to Git. This way your repo doesn't become polluted with all of them.
You can discard experiments once they're no longer needed.

For this scenario we have a new project that uses Tensorflow and the venerable
[MNIST](http://yann.lecun.com/exdb/mnist/) dataset.  The project has
two Artifical Neural Networks with several hyperparameters.

> 📖 See [Experiment Management](https://dvc.org/doc/user-guide/experiment-management) for more
> information on DVC's approach.

If you prefer to run locally, you can also supply the commands in this scenario
in a container: 

```
docker run -it dvcorg/doc-katacoda:start-experiments
```{{copy}}
