# Track a data file

`dvc add data/data.xml`{{execute}}

`cat data/.gitignore`{{execute}}

DVC has listed `data.xml` on `.gitignore` to make sure that we don't
commit it to Git.

`tree .dvc/cache`{{execute}}

`cat data/data.xml.dvc`{{execute}}

`apt install dos2unix`{{execute}}

`md5sum data/data.xml`{{execute}}

The command `dvc add` saves a copy of the file in the DVC cache and
creates a tracking file with the extension `.dvc`. In `data.xml.dvc`
it keeps also the MD5 hash of the data file `data.xml`, and this
effectively creates a pointer to the copy that is saved in the cache,
since it is named after this MD5 hash.

If the content of the `data.xml` is changed, its MD5 hash will change
as well and will be different from what is recorded on
`data.xml.dvc`. This would allow DVC to detect the change.
