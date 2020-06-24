# Saving and retrieving data

The command `dvc status` compares the data on the workspace with the data saved
on the cache.

`dvc status`{{execute}}

In this case it shows that everything is up to date. However with the option
`-c, --cloud` it compares instead the cache with the data remote storage:

`dvc status --cloud`{{execute}}

In this case it shows that there is a new file on the cache that has not been
uploaded yet to the data storage. Let's upload it:

`dvc push`{{execute}}

`dvc status --cloud`{{execute}}

`tree /tmp/data-storage/`{{execute}}

`tree .dvc/cache/`{{execute}}

Now the cached file is also saved on the data storage.

Let's now remove everything and retrieve it again:

`rm -rf .dvc/cache`{{execute}}

`rm -f data/data.xml`{{execute}}

`dvc pull`{{execute}}

`tree data/`{{execute}}

`tree .dvc/cache/`{{execute}}

`dvc pull` is usually used after `git clone`, `git pull`, or `git checkout` to
synchronize the data with the code. Along with `dvc push`, it provides a basic
collaboration workflow, similar to `git push` and `git pull`, that facilitates
sharing of data.
