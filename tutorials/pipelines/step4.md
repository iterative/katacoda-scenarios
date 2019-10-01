# Reproduce

Reproducing a stage means rerunning its command and regenerating its
outputs, but only if the dependencies have changed. If these
dependencies are outputs from some previous stages, then those stages
are reproduced first, to see whether there are any changes on the
results (outputs). This is done recursively for all the previous
stages.

1. Reproduce the last stage of the pipeline:

   `ls *.dvc`{{execute}}
   
   `dvc pipeline show evaluate.dvc`{{execute}}
   
   `dvc status`{{execute}}

   `dvc repro evaluate.dvc`{{execute}}
   
   This will try to reproduce the whole pipeline. However, as nothing
   has changed (confirmed by `dvc status`), no stage will be rerun.
   
2. Let's see what happens if we change/improve `code/featurization.py`
   (which is one of the dependencies of the stage
   `featurize.dvc`). Please open it with a text editor (`vim` or
   `nano`) and set the `ngram_range` parameter in `CountVectorizer`
   (lines 72–73) like this:
   
   ```
   vim code/featurization.py
   :72
   2dd
   i
   ```{{execute}}
   
   ```
   bag_of_words = CountVectorizer(
       stop_words='english',
       max_features=5000,
       ngram_range=(1, 2))
   ```{{execute}}
   
   Press `<Esc>`, then `:wq`{{execute}}
   
   `git status -s`{{execute}}
   
   `git diff code/featurization.py`{{execute}}
   
   `dvc status`{{execute}}
   
   Now try to reproduce the last stage:
   
   `dvc repro evaluate.dvc`{{execute}}
   
   Notice that it will reproduce all the stages from `featurize.dvc`.
   
   `dvc status`{{execute}}
   
   `dvc repro evaluate.dvc`{{execute}}
   
3. Commit changes to git:

   `git status -s`{{execute}}
   
   `git diff`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m 'Using ngram'`{{execute}}

4. Check the metrics again:

   `dvc metrics show -a`

   The option `-a, --all-branches` tells it to show the value of the
   metric for all the branches.
