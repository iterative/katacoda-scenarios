Technically speaking DVC is not a version control system.

Although DVC can work without a VCS, history of `.dvc` files is better tracked
with Git. Otherwise we may end up with files in the cache whose paths in the
workspace are missing. 

Git serves as the version control system for text and code files. DVC in turn
creates these `.dvc` files, updates them, and synchronizes DVC-tracked data in
the workspace efficiently to match them.

Let's get the previous version of the dataset `data/data.xml`:

`git checkout HEAD^1 data/data.xml.dvc`{{execute}}

When we check what changed using:

`git diff --staged`{{execute}}

we see that `data.xml.dvc` now contains the previous hash value of `data.xml`.

We can see that current hash and the hash value in `data.xml.dvc` is different. 

`md5sum data/data.xml`{{execute}}

To synchronize `data.xml` with the version addressed in `data.xml.dvc` we use 

`dvc checkout`{{execute}}

and this copies the previous version of `data.xml` from from local cache. `dvc
checkout` command synchronizes data files in the workspace to match the `.dvc`
files content. Now we can see that the value in `data.xml.dvc` and the hash
value of `data.xml` are identical. 

```
grep 'md5' data/data.xml.dvc
md5sum data/data.xml
```{{execute}}

Instead of `checkout` we can use `pull` again.  The difference is that `dvc
pull` also downloads missing data into cache, while `dvc checkout` only can
restore data that already in cache.
