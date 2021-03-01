# How DVC tracks the stages?

DVC stores stage configuration in `dvc.yaml` files. These files are
automatically created by DVC to check the change in data and code, and also
define relationships between data, code, and stages.

Let's take a look at `dvc.yaml` file to see what it contains:

`stages/dvc.yaml`{{open}}

It defines what we asked `dvc run` to do. It lists stages by name and defines
`cmd`, `deps` and `outs` for each of them.

Along with `dvc.yaml`, there is another file created by `dvc run` that shows
the hash values for dependencies and outputs.

`stages/dvc.lock`{{open}}

You can see that the structure of `dvc.lock` and `dvc.yaml` are similar.
`dvc.lock` also has `prepare` to show the stage name and lists `cmd`, `deps`
and `outs`. Additionally, it lists MD5 hashes we remember from adding files to
DVC.

DVC uses these hash values to track the change in dependencies.
Usually, `dvc.yaml` files are considered manually editable, and
`dvc.lock` files are exclusively for DVC's consumption. Maintaining the hash
values for each dependency should be the work of programs!

Note that we didn't `dvc add src/prepare.py`, and DVC wasn't tracking it
before `dvc run.` We can add code dependencies to stages without checking in
them first. 

Listing DVC-tracked files with

`dvc list --dvc-only --recursive .`{{execute}}

does not show `src/prepare.py`, but we are able to track its changes using
`dvc.lock` file.

For `data.xml`, MD5 values in `dvc.lock` and `data/data.xml.dvc` are
identical:

````
grep 'md5' data/data.xml.dvc
grep -A 1 'path: data/data.xml' dvc.lock
```{{execute}}

