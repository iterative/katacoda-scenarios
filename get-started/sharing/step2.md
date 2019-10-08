# Push cached files to data storage

`dvc status`{{execute}}

`dvc status --cloud`{{execute}}

This command compares the cache with the data storage. It shows that
there is a new file on the cache that has not been uploaded yet to the
data storage.

**Note:* The option is called `-c, --cloud` because usually a data
storage is provided by a cloud service (like Amazon Simple Storage
Service, Google Cloud Storage, Azure Blob Storage, etc.). However it
can also be on your own (SSH) server, or on a local directory (like in
this example).

Let's upload the missing file to the data storage with:

`dvc push`{{execute}}

`dvc status --cloud`{{execute}}

`tree /tmp/data-storage/`{{execute}}

`tree .dvc/cache/`{{execute}}

Now the cached file is also saved on the data storage.
