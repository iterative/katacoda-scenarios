# How DVC stores the stage information?

DVC stores stage configuration in `dvc.yaml` files. These files are
automatically created by DVC to store various attributes of stages. 

`example-get-started/dvc.yaml`{{open}}

It lists stages by name and defines `cmd`, `deps`, and `outs` for each of
them.

There is another file, `dvc.lock`, to track the changes in dependencies
and outputs.

`example-get-started/dvc.lock`{{open}}

The structure of `dvc.lock` and `dvc.yaml` are similar. Along with the
attributes found in `dvc.yaml`, it lists the hash values to track the changes. 

Usually, `dvc.yaml` files are considered manually editable, and
`dvc.lock` files are for DVC's consumption.

> 🦉 We didn't `dvc add src/prepare.py`, and DVC wasn't tracking it
> before. We can add code dependencies to stages without checking in them
> first.

Listing DVC-tracked files with:

`dvc list --dvc-only --recursive .`{{execute}}

does not show `src/prepare.py`, but we can track its changes using `dvc.lock`.
