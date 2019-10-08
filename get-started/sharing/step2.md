# Push cached files to data storage

`dvc status`{{execute}}

`dvc status --cloud`{{execute}}

This command compares the state of the cache with the state of the
data storage (the option `-c, --cloud`). It shows that there is a
new file on the cache that has not been uploaded to the data
storage.

`dvc push`{{execute}}

`dvc status --cloud`{{execute}}

`tree /tmp/data-storage/`{{execute}}

`tree .dvc/cache/`{{execute}}

The command `dvc push` has uploaded the cached file to the data
storage.
