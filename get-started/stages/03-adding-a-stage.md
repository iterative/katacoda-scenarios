# Adding a stage to run data preparation

We manage stages in DVC by `dvc stage`. It has two subcommands `add` and `list`,
for adding new stages and listing the existing.[^1]

We don't have any stages now. We'll add one by `dvc stage add`. A stage requires
a name (`-n`), one or more dependencies (`-d`), one or more outputs (`-o`) and a
command, like `python3 src/prepare.py data/data.xml` we used in the previous
step. 

Command supplied to the stage definition does not run immediately.[^2] At first we
simply define a stage like:

```
dvc stage add \
    -n prepare \
    -d src/prepare.py \
    -d data/data.xml \
    -o data/prepared \
    python3 \
        src/prepare.py \
        data/data.xml
```{{execute}}

This definition adds a stage named `prepare`, which depends on the program file
`src/prepare.py` and the data file `data/data.xml`. The stage should produce
`data/prepared` directory. 

> Note that reading from data dependencies and writing to outputs are
> responsibilities of the command supplied to `dvc stage add`. DVC cannot
> guarantee that the outputs will be produced by the command. 

In order to check the stages in a project, we can use: 

`dvc stage list`{{execute}}

and see stage names and outputs listed. By default `dvc stage list` lists the
stages defined in `dvc.yaml`, in the current directory. When you want to change
the scope you can add `--all` or `--recursive` as options, and list stages in
other `*/dvc.yaml` as well. 

`dvc stage list --all`{{execute}}

This is identical to the above list because we only have a single stage for now.

As we mentioned, `dvc stage add` doesn't immediately run the program supplied.
In order to run a stage, DVC provides `dvc exp run` command.[^3] In the next
step we'll run the stage we defined. 

[^1]: Previously, in DVC 1.x, we used `dvc run` to add new stages and running
them. This command is still available but deprecated, and will be removed in a
future version. 

[^2]: Stages added by `dvc run` are (by default) run immediately. This is an
important difference between DVC 2.0 and DVC 1.x.

[^3]: `dvc exp` is a new command introduced in DVC 2.0. It has much more
capabilities than just running the stages. We'll cover it in a later scenario.