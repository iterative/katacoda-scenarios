# Saving and Retrieving Data

The command `dvc status` can compare the data on the workspace with the data saved
on the cache. 

`dvc status --cloud`{{execute}}

Without the `-c, --cloud` option 

`dvc status`{{execute}}

checks whether workspace files are up to date with the _local cache._

As `dvc status --cloud` shows, we have a missing file in `mystorage`.  

We manage
data and model files in remotes with `dvc push` and `dvc pull`. These are used
to save and retrieve DVC tracked files from local `.dvc/cache` to and from a
data remote. 

Now we are ready to push `data.xml` to `mystorage` remote we configured in the
previous step: 

`dvc push`{{execute}}

> Note that `dvc push` uses _default remote_. There can be multiple remotes for
> a project, and if you want to push to a particular one, you can use the `--remote`
> option for `dvc push`. 

Let's check the status again: 

`dvc status --cloud`{{execute}}

Now, let's take a look at the content of `/tmp/data-storage` (location of our
remote) to see what happens when we push a file to the cache.

`tree /tmp/data-storage/`{{execute}}

The structure of `.dvc/cache` and `/tmp/data-storage` is identical. Both of them
contains the same files addressed by the same hash values.

`tree .dvc/cache`{{execute}}

Suppose we deleted `data.xml` from the workspace _and_ from the cache.

`rm -rf .dvc/cache`{{execute}}

`rm -f data/data.xml`{{execute}}

We deleted all _local_ versions of `data.xml`. Neither `.dvc/cache`, nor `data/`
contains our data file. 

`ls -R | grep 'data.xml'`{{execute}}

This is also reported by:

`dvc status`{{execute}}

In order to retrieve missing data and model files from remotes, we can use:

`dvc fetch`{{execute}}

This command copies files from remote to _local_ cache, but it doesn't update
the workspace with the data file.

`dvc status`{{execute}}

Note that `data.xml` is still missing from the workspace, but we can get it
from the local cache:

`dvc checkout`{{execute}}

`dvc checkout` links (or copies) from local cache files to the workspace.

`dvc status`{{execute}}

Instead of a two-step operation with `fetch` and `checkout`, we can use `pull`. Let's delete the data file and the cache again.

```
rm -rf .dvc/cache 
rm -f data/data.xml
```{{execute}}

We can retrieve the file from remote with a single command: 

`dvc pull`{{execute}}

`dvc pull` is usually used after `git clone`, `git pull`, or `git checkout` to
synchronize the data with the code. Along with `dvc push`, it provides a basic
collaboration workflow, similar to `git push` and `git pull`.
