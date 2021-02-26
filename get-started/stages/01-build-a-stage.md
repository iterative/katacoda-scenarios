# Build a stage

[Stages][bcstage] are the basic building blocks of pipelines in DVC. They
define and perform an action, like data import or feature extraction and
usually produce some output. In this scenario we will create stages and
pipelines for a basic machine learning project.

[bcstage]: https://dvc.org/doc/user-guide/basic-concepts/stage

We have a machine learning project already provided in
`~/example-get-started`. We covered these steps in previous scenarios. DVC is
installed. Data is downloaded from
`https://github.com/iterative/dataset-registry` and made smaller. A _local
remote_ is created in `/tmp/data-storage` called `mystorage` and the data is
pushed. Code and python requirements are also prepared and all changes are
commit to Git.

You can use the editor to browse the project. 

The script `src/prepare.py` splits the data into datasets for training
and testing. You can click the button to open the file in the editor. 

`src/prepare.py`{{open}}

We will build a stage based on this script.

Now, let's run and see what happens when we run this script: 

`python3 src/prepare.py data/data.xml`{{execute}}

A stage is created using `dvc run` command. It gives a name to the stage with
`-n`, lists dependencies with `-d` and outputs with `-o`. It contains a
command to run the stage at the end.

```
dvc run \
    -n prepare \
    -d src/prepare.py \
    -d data/data.xml \
    -o data/prepared \
    python3 \
        src/prepare.py \
        data/data.xml
```{{execute}}

The output of `dvc run` is telling us that it is running the given
python command. The output of this command is supposed to be on the
directory `data/prepared`, as indicated by the option `-o`
(output). So, after running the command, the output directory is added
to `data/.gitignore` and is saved in `.dvc/cache/`. Finally, the
information needed for rerunning this stage is saved in the `prepare`
section of `dvc.yaml`, which is indicated by the option `-n`
(stage name). The options `-d` indicate the dependencies of this stage.
We will see later what are dependencies and how they are used by DVC.

`git status -s`{{execute}}

`git diff data/.gitignore`{{execute}}

`tree -a data/`{{execute}}

Notice that `train.tsv` and `test.tsv` have been created on
`data/prepared/`.

`cat dvc.yaml`{{execute}}

The stage created in `dvc.yaml` by `dvc run` is similar to the `.dvc`
file created by `dvc add`, but it also has the field `cmd:` for the
command and the field `deps:` for dependencies.

`tree .dvc/cache/`{{execute}}

Notice how the MD5 hash of `data/prepared` output corresponds to
the path of the cached directory.

`cat .dvc/cache/*/*.dir`{{execute}}

```
cat .dvc/cache/*/*.dir \
    | python -m json.tool \
    | highlight -S json -O xterm256
```{{execute}}

So, the cached directory entry contains a list of the paths and MD5
hashes of the files that are inside the tracked directory, in JSON
format, and these files themselves are also saved in the cache,
named after their MD5 hashes.
