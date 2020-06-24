# Switching between versions

Yes, DVC is technically even not a version control system! `.dvc` files (and
`dvc.lock`, but we'll get to that later) content defines data file versions. Git
itself serves as the version control system. DVC in turn creates these `.dvc`
files, updates them, and synchronizes DVC-tracked data in the workspace
efficiently to match them.

Let's get get the previous version of the dataset `data/data.xml`:

`git checkout HEAD^1 data/data.xml.dvc`{{execute}}

`git diff`

`md5 data/data.xml`{{execute}}

`dvc checkout`{{execute}}

`dvc checkout` command synchronizes data files in the workspace to match the
`.dvc` files content:

`md5 data/data.xml`{{execute}}

Alternatively, `dvc pull` can be used again. The difference is that `dvc pull`
also downloads missing data into cache, while `dvc checkout` only can restore
data that already in cache.
