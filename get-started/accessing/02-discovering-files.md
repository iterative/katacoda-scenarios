# Discovering files

As we mentioned, if you look at the
[Get Started](https://github.com/iterative/example-get-started) repository
you won't see `data/data.xml` or `model.pkl`, or any DVC-tracked files. They are
not stored in Git. `dvc get` can download them, but how do we first even know
what exactly there before downloading (or accessing in other ways we'll cover
later)?

If `dvc get` is analog of `wget` or `curl`, then `dvc list` is analog of `ls`
or `aws s3 ls` and similar commands:

```
dvc list \
  https://github.com/iterative/example-get-started \
  data/
```{{execute}}

Again, the only difference is that we pass Git URL. Same interface as with
`dvc get`. Now, you can see the `data.xml` file. As well as regular Git files.
