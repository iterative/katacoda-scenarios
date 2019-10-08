# Where is the data file?

Note that the data file itself (`get-started/data.xml`) is not
retrieved from the Git repository. If you look at
https://github.com/iterative/dataset-registry you cannot find it
anywhere. However it is listed on this `.dvc` file:
https://github.com/iterative/dataset-registry/blob/master/get-started/data.xml.dvc

This makes sense because DVC does not store data files on Git. Instead
they are stored on a data storage (somewhere on cloud).

So, `dvc get` and `dvc import` retrieve a data file from the
**default data storage** of the given Git project, the data storage
that is added with `dvc remote add --default`, and that is stored on
the file `.dvc/config` of the remote project.

If you check
https://github.com/iterative/dataset-registry/blob/master/.dvc/config
you will see that the url of the default data storage is
https://remote.dvc.org/dataset-registry, and that is where `dvc get`
and `dvc import` retrieve the data file from.

However there is one more catch: the data storage is just a backup for
the DVC cached files, so don't expect to find there the path
`get-started/data.xml`. Instead you may find there the path
`a3/04afb96060aad90176268345e10355` which is derived from the MD5 hash
of the data file. You can find this hash on:
https://github.com/iterative/dataset-registry/blob/master/get-started/data.xml.dvc

Just for fun, let's try to download it with `wget`:

```
storage=https://remote.dvc.org/dataset-registry
wget -O data.xml.1 \
  $storage/a3/04afb96060aad90176268345e10355
```{{execute}}

`diff data.xml data.xml.1`{{execute}}
