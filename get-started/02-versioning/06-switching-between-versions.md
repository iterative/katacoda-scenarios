# Switching between Versions

Technically speaking, DVC is not a version control system.

Git serves as the VCS for text and code files, although DVC can work without it.

Let's get the previous version of `data/data.xml`:

`git checkout HEAD~ data/data.xml.dvc`{{execute}}

When we check what changed using:

`git diff --staged`{{execute}}

We see that `data.xml.dvc` now contains the previous hash value of `data.xml`. 

`md5sum data/data.xml`{{execute}}

To synchronize `data.xml` with the version addressed in `data.xml.dvc`:

`dvc checkout`{{execute}}

Now we can see that the value in `data.xml.dvc` and the hash value of
data.xml` are identical.

```
grep 'md5' data/data.xml.dvc
md5sum data/data.xml
```{{execute}}

Instead of `dvc checkout`, we could use `dvc pull` again.  Pulling also
downloads missing data from the remote storage, whereas `dvc checkout` can only
restore that's already in the local cache.
