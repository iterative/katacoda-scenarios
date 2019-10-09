# Push cached files to data storage

The command `dvc status` compares the data on the workspace with the
data saved on the cache.

`dvc status`{{execute}}

In this case it shows that everything is up to date.

However with the option `-c, --cloud` it compares instead the cache
with the data storage:

`dvc status --cloud`{{execute}}

In this case it shows that there is a new file on the cache that has
not been uploaded yet to the data storage.

**Note:** The option is called `-c, --cloud` because usually a data
storage is provided by a cloud service (like Amazon Simple Storage
Service, Google Cloud Storage, Azure Blob Storage, etc.). However it
can also be on your own (SSH) server, or on a local directory (like in
this example).

Let's upload the missing file to the data storage:

`dvc push`{{execute}}

`dvc status --cloud`{{execute}}

`tree /tmp/data-storage/`{{execute}}

`tree .dvc/cache/`{{execute}}

Now the cached file is also saved on the data storage.
