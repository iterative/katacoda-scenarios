# Adding a stage to run data preparation

We manage stages in DVC by `dvc stage`. It has two subcommands
`add` and `list`, for adding new stages and listing
them.<sup>1</sup>

We 'll add a stage by [`dvc stage add`][stageadd]. A stage requires a name
(`-n`) and a command, like `python3 src/prepare.py data/data.xml` at the end.
It usually has dependencies (`-d`), and outputs (`-o`) also.

Command supplied to the stage definition does not run immediately.<sup>2</sup>

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

Note the second list shows `data/data.xml.dvc` as a stage that outputs
`data.xml`. From the point of view of DVC, a data file tracked by `.dvc` file is
a stage as well. 

As we said above, `dvc stage add` doesn't immediately run the program supplied.
In order to run a stage, DVC provides another command. In the next step we'll
run the stage we defined. 

We add and commit files changed in this step:

```
git add data/.gitignore dvc.yaml 
git commit -m "added prepare stage"
```{{execute}}

## Notes

<sup>1</sup> Previously, in DVC 1.x, we used `dvc run` to add new stages and running
them. This command is still available but deprecated, and will be removed in a
future version. 

<sup>2</sup> Stages added by `dvc run` are (by default) run immediately. This is an
important difference between DVC 2.0 and DVC 1.x.
