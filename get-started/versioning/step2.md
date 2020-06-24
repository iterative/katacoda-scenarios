# How does it work?

`cat data/data.xml.dvc`{{execute}}

`md5sum data/data.xml`{{execute}}

DVC has created a tracking file with the extension `.dvc`.

In `data.xml.dvc` it keeps also the MD5 hash of the data file `data.xml`, and
this effectively creates a pointer to the copy that is saved in the cache, since
it is named after this MD5 hash.

If the content of `data.xml` is changed, its MD5 hash will change as well and
will be different from what is recorded on `data.xml.dvc`. This would allow DVC
to detect the change.

`tree .dvc/cache`{{execute}}

DVC has also saved a copy of `data/data.xml` to `.dvc/cache/` using it's `md5`
as a file name.

> DVC can utilize `symlinks`, `hardlinks`, or `reflinks`, depending on the file
> system and DVC settings. It can save storage space and time if you deal with
> large files. Read more information in the
> [Large Dataset Optimization](https://dvc.org/doc/user-guide/large-dataset-optimization).
