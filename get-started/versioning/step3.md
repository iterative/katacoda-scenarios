# Transfer a tagged experiment to master

Let's assume that `baseline-experiment` has the best metrics, so we
want to put that experiment on top (on the branch `master`):
   
`dvc metrics show -T`{{execute}}

```
git revert baseline-experiment \
    --strategy-option theirs \
    -m "Revert to baseline-experiment"
```{{execute}}

`git status`{{execute}}

`git log --oneline`{{execute}}

`dvc status`{{execute}}

`dvc checkout`{{execute}}

`dvc status`{{execute}}

`dvc repro evaluate.dvc`{{execute}}

`dvc status`{{execute}}

When we merge another experiment on `master`, usually there are
conflicts on MD5 hashes inside the DVC-files. With the option
`--strategy-option theirs` we avoid the conflicts by giving priority
to the version that we are merging. This way hopefully most of the
data files will have correct versions and will not need to be
reproduced.
