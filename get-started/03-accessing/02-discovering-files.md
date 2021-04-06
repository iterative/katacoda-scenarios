# Discovering files

If you look at the [repository][dr], you won't see `data/data.xml` or
`model.pkl`, or any DVC-tracked files. They are not stored in Git. We can
`dvc get` them, but how do we even know what data is tracked in a remote DVC
repo before accessing it?

[dr]: https://github.com/iterative/dataset-registry

If `dvc get` is the analog of `wget` or `curl`, then `dvc list` is the analog
of `ls` or `aws s3 ls` and similar commands:

```
dvc list \
  https://github.com/iterative/example-get-started \
  data/
```{{execute}}

The only difference is that we pass a Git URL. Same interface as `dvc get`. Now
we can see `data.xml` as well as regular Git files.
