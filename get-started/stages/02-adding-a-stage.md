# Adding a stage to run data preparation

We manage stages in DVC by `dvc stage`. It has two subcommands `add` and
`list`, for adding new stages and listing them.<sup>1</sup>

We 'll add a stage by [`dvc stage add`][stageadd]. A stage requires a name
(`-n`) and a command, like `python3 src/prepare.py data/data.xml` at the end.
It usually has dependencies (`-d`), and outputs (`-o`) also.

[stageadd]: https://dvc.org/doc/command-reference/stage/add

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
`src/prepare.py` and the data file `data/data.xml`. The stage produces
`data/prepared` directory. 

> 💡 Reading from the dependencies and writing to the outputs are
> responsibilities of the command supplied to `dvc stage add`. DVC cannot
> guarantee that the outputs are produced/changed by the command. It only
> checks whether these outputs have changed. 

See the stages in the project:

`dvc stage list`{{execute}}

By default, `dvc stage list` lists the stages defined in `dvc.yaml` found
in the current directory. When you want to change the scope, you can add
`--all` or `--recursive` as options, and list stages in other `*/dvc.yaml`
as well. 

`dvc stage list --all`{{execute}}

Note the second list shows `data/data.xml.dvc` as a stage that outputs
`data.xml`. A data file tracked by `.dvc` is a _stage_ as well.

We add and commit files modified in this step:

```
git add data/.gitignore dvc.yaml 
git commit -m "Added prepare stage"
```{{execute}}

## Notes

<sup>1</sup> Previously, in DVC 1.x, we used `dvc run` to add new stages
and running them. This command is still available but deprecated. It will
be removed in a future version. 

<sup>2</sup> Stages added by `dvc run` are (by default) run immediately.
This is an important difference between DVC 2.0 and DVC 1.x.
