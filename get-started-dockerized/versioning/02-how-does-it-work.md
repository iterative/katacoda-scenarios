# How does it work?

Let's take a look at inside the `.dvc` file to learn how it keeps track of our
data: 

`cat data/data.xml.dvc`{{execute}}

> This is a valid YAML 1.2 file. `md5` field is used to keep track changes in
> `data.xml`. Let's check whether the hash calculated by `md5sum` is identical
> with the hash calculated by DVC.

```
md5sum data/data.xml 

grep 'md5' data/data.xml.dvc 
```{{execute}}

DVC uses the hash to address the file in the cache. DVC detects
the change by comparing the new MD5 hash to the hash kept in
`data.xml.dvc`.

Let's see how the cache is organized:

`tree .dvc/cache`{{execute}}

DVC saved a copy of `data/data.xml` to `.dvc/cache/` using the first two
characters as directory and the rest as file name. 

> To save storage space and time when dealing with large files, DVC can use
> `symlinks`, `hardlinks`, or `reflinks` depending on the file system. Read
> more in the user guide for [Large Dataset
> Optimization](https://dvc.org/doc/user-guide/large-dataset-optimization).
