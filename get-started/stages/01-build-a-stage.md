# What's a stage?

[Stages][bcstage] are the basic building blocks of pipelines in DVC. They define
and execute an action, like data import or feature extraction, and usually
produce some output. In this scenario, we create stages and pipelines for a
machine learning project.

[bcstage]: https://dvc.org/doc/user-guide/basic-concepts/stage

We have a machine learning project already provided in `~/stages`. We covered
these steps in previous scenarios. DVC is installed. Data is downloaded from
`https://github.com/iterative/dataset-registry` and made smaller. A _local
remote_ is created in `/tmp/data-storage` named `mystorage`, and the data in the
DVC repository is pushed. Code and python requirements are prepared, and all
changes are committed to Git.

You can use the VS Code editor to browse the project.

# Manual Data Preparation 

The script `src/prepare.py` splits the data into datasets for training and
testing. You can click the button to open the file in the editor.

`stages/src/prepare.py`{{open}}

As a next step, we build a stage based on this script. Let's see what happens
when we run the script:

`python3 src/prepare.py data/data.xml`{{execute}}

It splits the data into datasets for training and testing. We check the
contents:

`head data/prepared/train.tsv`{{execute}}

`head data/prepared/test.tsv`{{execute}}

Our goal is to create a project that classifies the questions and assigns tags
to them. This is a sample of Stack Overflow data. We use DVC to automate such
tasks and provide fully reproducible data and pipeline repositories.

# Adding a stage to run data preparation

We delete the artifacts before reproducing them with DVC.

`rm -fr data/prepared`{{execute}}

We create a stage using `dvc run` command. We give a name to the stage with
`-n`, list dependencies with `-d` and outputs with `-o` options.

It contains a command to run the stage at the end. This is the same
`src/prepare.py` script we used earlier:

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

> Note that reading from dependencies and writing the outputs are
> responsibilities of the command supplied to `dvc run`. DVC only tracks
> whether dependencies or > outputs have _changed_ and does not read and write
> these files.

By default `dvc run` executes the command provided as the final argument. (You
can set `--no-exec` option to prevent it from running.) With the above command
we created a stage named `prepare` that depends on `prepare.py` and `data.xml`.
So if any one of these change, DVC will run this stage to obtain `data/prepared`
directory.

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


# How directories are cached and tracked?

DVC stores the _outputs_ defined in `run` in the `cache` similar to other
data. `data/prepared` directory is defined as an output in `prepare` stage
and its MD5 hash is:

`grep -A 1 'path: data/prepared' dvc.lock`{{execute}}

and this points us to `.dvc/cache/f1/b1d214c4cc7a3efdb200410227b975.dir` file
similar to other directories tracked by DVC. You can see the contents of this
`.dir` file in VS Code.

`stages/.dvc/cache/f1/b1d214c4cc7a3efdb200410227b975.dir`{{open}}

It's a JSON file that lists all individual elements of the directory with
their hash values.

`cat .dvc/cache/f1/b1d214c4cc7a3efdb200410227b975.dir | jq`{{execute}}

For example we can learn individual hash value of `train.tsv` as
`fcebfd4c6f1645ac4987d39f1c5cf610` and check its content

`stages/.dvc/cache/fc/ebfd4c6f1645ac4987d39f1c5cf610`{{open}}.

Note also that DVC adds `/prepared` to `.gitignore` to prevent output data
files to be committed in Git.

You can review changes in the repository from the Source Control tab of VS Code.

Finally we are registering `dvc.yaml`, `dvc.lock` and `.gitignore` to Git and
complete this step.

```
git add dvc.yaml dvc.lock .gitignore
git commit -m "Configured prepare stage"
```{{execute}}

In the next step we add another stage by editing `dvc.yaml` file. 