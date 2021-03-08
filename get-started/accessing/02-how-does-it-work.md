# How does it work?

Remember those `.dvc` files `dvc add` generates? Those files (and `dvc.lock`
that we'll cover later), their history in Git, DVC remote storage config saved
in Git contain all the information needed to access and download any version of
a dataset, file, or model.

Just for fun, let's try to download it with `wget`:

```
storage="https://remote.dvc.org/dataset-registry"
path="a3/04afb96060aad90176268345e10355"
wget -O data.xml.1 $storage/$path
```{{execute}}

`ls -lh`{{execute}}

`diff data.xml data.xml.1`{{execute}}

`dvc get` automated this by reading `https://remote.dvc.org/dataset-registry`
from the
[.dvc/config](https://github.com/iterative/dataset-registry/blob/master/.dvc/config)
and `a3/04afb96060aad90176268345e10355` path from the
[get-started/data.xml.dvc](https://github.com/iterative/dataset-registry/blob/master/get-started/data.xml.dvc).

This makes sense because DVC does not store data files with Git. If you look at
the [dataset-registry](https://github.com/iterative/dataset-registry) you cannot
find it anywhere. Instead they are stored in a data storage (e.g. somewhere
in cloud, in this case in S3).
