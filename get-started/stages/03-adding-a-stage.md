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
