# Python API

Alternatively to the command line `dvc get`, we can also access any DVC-tracked
artifact "natively" from Python code with
[`dvc.api`](https://dvc.org/doc/api-reference):

`cat process.py| highlight -S python -O xterm256`{{execute}}

> We need to install DVC as a Python library to import if from Python code:

`pip3 install --user dvc`

`python3 process.py`{{execute}}

Yes, the interface is similar to the one we've seen already - Git repo URL,
path, etc. And internally it works similar - reads Git repo to get data storage
URL, get file path in it, etc. So, what are the differences then? Let's name a
few important one:

- **It's Python "native"**, we don't have to combine CLI scripts with Python
  code to process data or deploy a model.

- **It doesn't consume space for a file on the file system** - it reads data
  directly into memory, yay! If you want to process a large dataset or deploy a
  huge model you don't have to keep it on the disk.

- **It reads data lazily** - it doesn't allocate a huge array internally to hold
  the data, instead it streams it from the remote storage. Means, you can
  process a huge dataset with a very low memory footprint.
