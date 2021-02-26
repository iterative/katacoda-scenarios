# Build a stage

[Stages][bcstage] are the basic building blocks of pipelines in DVC. They
define and perform an action, like data import or feature extraction and
usually produce some output. In this scenario we will create stages and
pipelines for a basic machine learning project.

[bcstage]: https://dvc.org/doc/user-guide/basic-concepts/stage

We have a machine learning project already provided in
`~/stages`. We covered these steps in previous scenarios. DVC is
installed. Data is downloaded from
`https://github.com/iterative/dataset-registry` and made smaller. A _local
remote_ is created in `/tmp/data-storage` called `mystorage` and the data is
pushed. Code and python requirements are also prepared and all changes are
commit to Git.

You can use the editor to browse the project. 

The script `src/prepare.py` splits the data into datasets for training
and testing. You can click the button to open the file in the editor. 

`stages/src/prepare.py`{{open}}

We will build a stage based on this script. Let's run and see what happens
when we run the script:

`python3 src/prepare.py data/data.xml`{{execute}}

It splits the data into datasets for training
and testing. You can see the contents of these files by clicking below: 

`stages/data/prepared/train.tsv`{{open}}

`stages/data/prepared/test.tsv`{{open}}

Our goal in DVC is to automate such tasks and define relationships between them. 

Let's delete the artifacts from previous step before producing them with DVC. 

`rm -fr data/prepared`{{execute}}

A stage is created using `dvc run` command. We give a name to the stage with
`-n`, list dependencies with `-d` and outputs with `-o`. 

It contains a command to run the stage at the end. This is the same command we used earlier. 

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

`dvc run` runs the command provided at the end. We created a stage named
`prepare` that depends on `prepare.py` and `data.xml`. So if any one of these
change DVC will run this stage to obtain `data/prepared` directory.

Information about stages is stored in `dvc.yaml` file. These files are
automatically created by DVC to check the change of data and code, and also
define relationships between these.

Let's take a look at `dvc.yaml` file to see what it contains: 

`stages/dvc.yaml`{{open}}


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
