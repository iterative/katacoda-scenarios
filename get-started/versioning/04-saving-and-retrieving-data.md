In order to see the status of tracked data and model files and if they are
stored in remotes, we can use 

`dvc status --cloud`{{execute}}

to compare files between the data stored on cache and the default remote.

Without the `-c, --cloud` option 

`dvc status`{{execute}}

checks whether workspace files are up to date with _local cache._

As `dvc status --cloud` shows we have a missing file in `mystorage`.  

We manage
data and model files in remotes with `dvc push` and `dvc pull`. These are used
to save and retrieve DVC tracked files from local `.dvc/cache` to and from a
data remote. 

Now we are ready to push `data.xml` to `mystorage` remote we configured in the
previous step: 

`dvc push`{{execute}}

> Note that `dvc push` uses _default remote_. There can be multiple remotes for
> a project and if you want to push to a particular one, you can use `--remote`
> option for `dvc push`. 

After pushing let's check the status again: 

`dvc status --cloud`{{execute}}

Now, let's take a look at the content of `/tmp/data-storage` to see what
happens in when we push a file to the cache. 

`tree /tmp/data-storage/`{{execute}}

As you can see the structure of `.dvc/cache` and `/tmp/data-storage` is
similar. Both of them contains the same files addressed by the same hash
values. 

`tree .dvc/cache`{{execute}}

Suppose we deleted `data.xml` from the workspace _and_ from the cache.

`rm -rf .dvc/cache`{{execute}}

`rm -f data/data.xml`{{execute}}

We deleted all _local_ versions of `data.xml`. Neither `.dvc/cache` nor `data/` contains our data file.

`tree -a -I .git` 

This is also reported by 

`dvc status`{{execute}}

In order to retrieve missing data and model files from remotes we can use:

`dvc fetch`{{execute}}

This command copies files from remote to _local_ cache but it doesn't update
the workspace with the data file. 

Let's see the status of workspace now: 

`dvc status`{{execute}}

Note that `data.xml` is missing from the workspace but we can get it from local
cache: 

`dvc checkout`{{execute}}

`checkout` command copies (or creates link to) local cache files to the
workspace. Let's check the status again: 

`dvc status`{{execute}}

DVC has a single command that both copies to local cache and the workspace. Instead of two step operation with `fetch` and `checkout`, we can use `pull`. Let's delete the data file and the cache again.

```
rm -rf .dvc/cache 
rm -f data/data.xml```{{execute}}

We can retrieve the file from remote with a single command: 

`dvc pull`{{execute}}

`dvc pull` is usually used after `git clone`, `git pull`, or `git checkout` to
synchronize the data with the code. Along with `dvc push`, it provides a basic
collaboration workflow, similar to `git push` and `git pull`, that facilitates
sharing of data.
