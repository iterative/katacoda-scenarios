# Python API

Besides using DVC commands in the command line, we can also access any
DVC-tracked artifact "natively" from Python with 
[the API](https://dvc.org/doc/api-reference). Please click the below link to open the Python script:

`process.py`{{open}}

The script downloads the data like `dvc get` and counts the number of lines in it: 

`python3 ~/process.py`{{execute}}

Note that the script doesn't download the data to a file before counting the lines. 

The interface of [`dvc.api.open`][apiopen] is similar to the one we've
seen already. It receives Git repo URL and path as arguments, and works
the same way. There are also a few important differences:

[apiopen]: https://dvc.org/doc/api-reference/open

- **It's Python "native"**, we don't have to combine CLI scripts with Python
  code to process data or deploy a model.

- **It doesn't consume space for a file on the file system** - `open()` doesn't
  consume space in the file system - it loads the data into the memory as
  needed.  If you want to process a large dataset or deploy a huge model you
  don't have to keep it on the disk.

- **It reads data lazily** - it doesn't allocate a huge array internally to hold
  the data, instead it streams it from the remote storage. This means you can
  process a huge dataset with a very low memory footprint.

- **It unifies storage access** - it doesn't matter if actual data is stored on
  S3, or Google Cloud, or SSH - the interface is the same.
