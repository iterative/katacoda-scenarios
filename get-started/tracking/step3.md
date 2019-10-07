# Commit to Git

```
git add \
    data/.gitignore \
    data/data.xml.dvc
```{{execute}}

```
git commit \
    -m "Add raw data to project"
```{{execute}}

When the file `data/data.xml` is changed, DVC will save its new
version to cache again and update `data/data.xml.dvc` to match the new
hash of the data file. Then the new version of `data/data.xml.dvc`
will be committed to Git again.

This way we keep in Git a history of the `.dvc` file, and each version
in this history is linked to a version of the data file in the DVC
cache. This linking or connection is done through the MD5 hash of the
cached file, which is also its name on the cache.
