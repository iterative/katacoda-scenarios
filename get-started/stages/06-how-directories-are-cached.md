# How are directories cached and tracked?

By default, DVC stores the _outputs_ defined in `stage add` in the `cache`
similar to other data. `data/prepared` directory is defined as an output in
`prepare` stage, and the hash value is:

`grep -A 1 'path: data/prepared' dvc.lock`{{execute}}

and this points us to `.dvc/cache/f1/b1d214c4cc7a3efdb200410227b975.dir` file.

It's a JSON file that lists all individual elements of the directory with
their hash values.

`cat .dvc/cache/f1/b1d214c4cc7a3efdb200410227b975.dir | jq`{{execute}}

For example we see that the individual hash value of `train.tsv` as
`fcebfd4c6f1645ac4987d39f1c5cf610` and check its content

`project/.dvc/cache/fc/ebfd4c6f1645ac4987d39f1c5cf610`{{open}}.

Note also that DVC adds `/prepared` to `.gitignore` to prevent output data
files to be committed in Git.

You can review changes in the repository from the Source Control tab of VS Code.

Finally we are registering `dvc.yaml`, `dvc.lock` and `.gitignore` to Git and
complete this step.

```
git add dvc.yaml dvc.lock data/.gitignore
git commit -m "Configured prepare stage"
```{{execute}}
