# Getting previous versions

If we want to get back to the code of a previous experiment we can use
`git checkout`. To get the corresponding data as well we need to
follow that with a `dvc checkout`.


1. Let's assume that we want to go back to the tag
   `baseline-experiment` to check it again. We can do it like this:
   
   `git checkout baseline-experiment`{{execute}}
   
   `git status`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro evaluate.dvc`{{execute}}

   With `dvc checkout` we bring back (from cache) all the data files
   and outputs that correspond to the checked out version of `.dvc`
   files. This is possible because the MD5 hashes of the data files,
   which are kept inside the `.dvc` files, point to the right version
   of data on the cache.
   
   After the data are synchronized with `.dvc` files, `dvc status`
   finds that everything is up to date, and `dvc repro` finds that no
   commands need to be re-executed, because all the dependencies and
   outputs are unchanged.
   
2. Let's go to the latest version again:
   
   `git checkout master`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro evaluate.dvc`{{execute}}

3. Let's say that we want to get only the model of
   `baseline-experiment`. This is the file `model.pkl`, and it is an
   output of `train.dvc`. We can do it like this:
   
   `git checkout baseline-experiment train.dvc`{{execute}}
   
   `git status`{{execute}}
   
   `git diff --cached train.dvc`{{execute}}
   
   `dvc status train.dvc`{{execute}}
   
   `dvc checkout train.dvc`{{execute}}
   
   `dvc status train.dvc`{{execute}}
   
4. Let's go again to the latest version of `train.dvc` and
   `model.pkl`:
   
   `git status`{{execute}}
   
   `git reset --hard`{{execute}}
   
   `git status`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
   
5. Let's assume that `baseline-experiment` has the best metrics, so we
   want to put that experiment on top (on the branch `master`):
   
   `dvc metrics show -T`{{execute}}
   
   ```
   git revert baseline-experiment \
       --strategy-option theirs \
       -m "Getting back to baseline-experiment"
   ```{{execute}}
   
   `git status`{{execute}}
   
   `git log --oneline`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro evaluate.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   When we merge another experiment on `master`, usually there are
   conflicts on MD5 hashes inside the DVC-files. With
   `--strategy-option theirs` we avoid the conflicts by giving
   priority to the version that we are merging. This way hopefully
   most of the data files will have correct versions and will not need
   to be reproduced.
