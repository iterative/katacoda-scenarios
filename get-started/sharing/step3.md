# Pull files from data storage

With `dvc pull` we can download a file from a data storage to the
cache.

For the sake of example, let's remove first the data file and the
cache, and then let's try to retrieve it from the data storage.

`rm data/data.xml`{{execute}}

`rm -rf .dvc/cache/*`{{execute}}

`git status`{{execute}}

`ls data/`{{execute}}

`tree .dvc/cache/`{{execute}}

`dvc status`{{execute}}

`dvc status -c`{{execute}}

So, the file tracked by `data/data.xml.dvc` is missing. It is neither
in the workspace nor in the cache. However the `deleted:` status shows
us that it is available on the data storage.

Let's try to get it from the data storage:

`dvc pull data/data.xml.dvc`{{execute}}

`ls data/`{{execute}}

`tree .dvc/cache/`{{execute}}

`dvc status -c`{{execute}}

`dvc status`{{execute}}

The command `dvc pull` is usually used after `git clone`, `git pull`,
or `git checkout` to synchronize the data with the code. Along with
`dvc push`, it provides a basic collaboration workflow, similar to
`git push` and `git pull`, that facilitates sharing of data.

**Note:** Similarly to `git pull`, `dvc pull` is actually a shortcut
for `dvc fetch` and `dvc checkout`. The first one retrieves the
missing data from the data storage to the cache, and the second one
copies them from the cache to the workspace.
