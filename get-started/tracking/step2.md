# Track a data file

To track a file with DVC we use the command `dvc add`.

`dvc add data/data.xml`{{execute}}

`cat data/.gitignore`{{execute}}

DVC has listed `data.xml` on `.gitignore` to make sure that we don't
commit it to Git.

`tree .dvc/cache`{{execute}}

`diff data/data.xml .dvc/cache/*/*`{{execute}}

DVC has saved a copy of `data/data.xml` to `.dvc/cache/`.

`cat data/data.xml.dvc`{{execute}}

`dos2unix data/data.xml`{{execute}}

`md5sum data/data.xml`{{execute}}

`cat data/data.xml.dvc | grep -e '- md5:'`{{execute}}

`tree .dvc/cache`{{execute}}

DVC has created a tracking file with the extension `.dvc`.

In `data.xml.dvc` it keeps also the MD5 hash of the data file
`data.xml`, and this effectively creates a pointer to the copy that is
saved in the cache, since it is named after this MD5 hash.

If the content of `data.xml` is changed, its MD5 hash will change as
well and will be different from what is recorded on
`data.xml.dvc`. This would allow DVC to detect the change.
