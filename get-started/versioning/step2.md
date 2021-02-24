# How does it work?

Let's take a look at inside the `.dvc` file to learn how it keeps track of our
data file: 

For a data file named `data.xml`, DVC keeps the tracking information in
`data.xml.dvc`. 

`cat data/data.xml.dvc`{{execute}}

Note that this is valid YAML 1.2 file. There is a field named `md5` in the
file. 

This field is used to keep track the changes in `data.xml`. Let's check whether
the hash calculated by `md5sum` is identical with the hash calculated by DVC. 

``` md5sum data/data.xml 

grep 'md5' data/data.xml.dvc 
```{{execute}}

DVC uses `md5` field to actually address the file in its cache. The hash
is a pointer to the content in DVC cache. 

If the content of `data.xml` is changed, its MD5 hash will change. DVC is able
to detect the change by comparing the new MD5 hash to the MD5 hash kept in
`data.xml.dvc`.

Now let's see how cache is organized:

`tree .dvc/cache`{{execute}}

DVC saved a copy of `data/data.xml` to `.dvc/cache/` using its MD5 hash as a
file name. The first two characters of the hash is used as a directory name and
the rest as a file name. 

When a data or model file's content changes, its address in the cache changes
too. This allows to keep track history of large data files.

> The default setting for DVC is to copy content both in the cache and the
> workspace. To save storage space and time when dealing with large files, DVC
> can use `symlinks`, `hardlinks`, or `reflinks`, depending on the file system. 
> Read more in the user guide for [Large Dataset
> Optimization](https://dvc.org/doc/user-guide/large-dataset-optimization).
