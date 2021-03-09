# Download

We can download any file in a DVC repository:

```
dvc get \
  https://github.com/iterative/dataset-registry \
  get-started/data.xml
```{{execute}}

`md5sum data.xml`{{execute}}

`dvc get` automated this by reading `https://remote.dvc.org/dataset-registry`
from the
[.dvc/config](https://github.com/iterative/dataset-registry/blob/master/.dvc/config)
and `a3/04afb96060aad90176268345e10355` path from the
[get-started/data.xml.dvc](https://github.com/iterative/dataset-registry/blob/master/get-started/data.xml.dvc).

Just for fun, let's try to download it with `wget`:

```
storage="https://remote.dvc.org/dataset-registry"
path="a3/04afb96060aad90176268345e10355"
wget -O data.xml.1 $storage/$path
```{{execute}}

Check whether they are the same file:

`diff data.xml data.xml.1`{{execute}}

Instead of downloading the data file directly, e.g., with `aws s3 cp`, `scp`,
`wget`, we are accessing it using a Git repo URL as an _entry point_ or as
a [_data/model registry_][data-registries].

[data-registries]: https://dvc.org/doc/use-cases/data-registries

By the way, we didn't initialize DVC in the current directory yet. `dvc get`
doesn't need an initialized project. 

`dvc init`{{execute}}