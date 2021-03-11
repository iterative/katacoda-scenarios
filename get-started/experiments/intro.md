[Experiments][bcexp] proliferate quickly in ML projects where there are many
parameters to tune or other permutations of the code. DVC 2.0 introduces a new
way to organize such projects and only keep what we ultimately need with `dvc
experiments`. DVC can track experiments for you so there's no need to commit
each one to Git. This way your repo doesn't become polluted with all of them.
You can discard experiments once they're no longer needed.

[bcexp]: https://dvc.org/doc/user-guide/basic-concepts/experiment

> 📖 See [Experiment Management](/doc/user-guide/experiment-management) for more
> information on DVC's approach.

