The command `dvc get` is like `wget`, but it is used to download data
artifacts from DVC projects which are hosted on Git repositories.

The command `dvc add` saves a copy of the file in the DVC cache and
creates a tracking file with the extension `.dvc`.

We keep in Git a history of the `.dvc` file, and each version in this
history is linked to a version of the data file in the DVC cache. This
linking or connection is done through the MD5 hash of the cached file,
which is also its name on the cache.
