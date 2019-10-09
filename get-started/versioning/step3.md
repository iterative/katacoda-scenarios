# Transfer a tagged experiment to master

Let's assume that `baseline-experiment` has the best metrics, so we
want to put that experiment on top (on the branch `master`):
   
`dvc metrics show -T`{{execute}}

`git log --oneline`{{execute}}

`git revert -n baseline-experiment..HEAD`{{execute}}

`git status`{{execute}}

`git diff --cached`{{execute}}

`git revert --continue`{{execute}}

`git log --oneline`{{execute}}

Move the tag `baseline-experiment` to the current commit:

`git tag -d baseline-experiment`{{execute}}

`git tag`{{execute}}

`git tag baseline-experiment`{{execute}}

`git log --oneline`{{execute}}

Synchronize the data with the current version of code:

`dvc status`{{execute}}

`dvc checkout`{{execute}}

`dvc status`{{execute}}

`dvc repro evaluate.dvc`{{execute}}

`dvc status`{{execute}}

`dvc metrics show -T`{{execute}}
