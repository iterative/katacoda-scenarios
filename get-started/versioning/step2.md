# How does it work?

`cat data/data.xml.dvc`{{execute}}

`md5sum data/data.xml`{{execute}}

DVC created a tracking file with the extension `.dvc`.

The MD5 hash of the data file `data.xml` is kept in `data.xml.dvc`. Since the
copy of `data.xml` saved in the cache is named after its MD5 hash, the hash is
effectively a pointer to the cached copy.

If the content of `data.xml` is changed, its MD5 hash will change. DVC is able
to detect the change by comparing the new MD5 hash to the MD5 hash kept in
`data.xml.dvc`.

`tree .dvc/cache`{{execute}}

DVC has also saved a copy of `data/data.xml` to `.dvc/cache/` using its MD5 hash
as a file name.

> To save storage space and time when dealing with large files, DVC can use
> `symlinks`, `hardlinks`, or `reflinks`, depending on the file system and DVC
> settings. Read more in the user guide for
> [Large Dataset Optimization](https://dvc.org/doc/user-guide/large-dataset-optimization).
