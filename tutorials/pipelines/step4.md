# Reproduce

As we have seen, reproducing a stage means rerunning its command and
regenerating its outputs, but only if the dependencies have changed,
and if the stage is not locked. If these dependencies are outputs from
some previous stages, then those stages are reproduced first, to see
whether there are any changes on the results (outputs). This is done
recursively for all the previous stages.

1. Let's reproduce the last stage of the pipeline:

   `ls *.dvc`{{execute}}
   
   `dvc pipeline show evaluate.dvc`{{execute}}
   
   `dvc status`{{execute}}

   `dvc repro evaluate.dvc`{{execute}}
   
   This will try to reproduce the whole pipeline. However, as nothing
   has changed (confirmed also by `dvc status`), no stage will be
   rerun.
   
2. Our NLP model was based on unigrams only. Let's improve the model
   by adding bigrams. The bigrams model will extract signals not only
   from separate words but also from two-word combinations. This
   eventually increases the number of features for the model and
   hopefully improves the target metric.
   
   Before editing the `code/featurization.py` file, lets move the
   current master to a branch called `unigrams`, then let's create and
   checkout a new branch called `bigrams`:
   
   `git checkout -b unigrams`{{execute}}
   
   `git checkout master`{{execute}}
   
   `git checkout -b bigrams`{{execute}}
   
   `git branch -a`{{execute}}

3. Now let's edit `code/featurization.py` (which is one of the
   dependencies of stage `featurize.dvc`). Open it with a text editor
   (`vim` or `nano`) and set the `ngram_range` parameter in
   `CountVectorizer` (lines 72–73) like this:
   
   ```
   bag_of_words = CountVectorizer(
       stop_words='english',
       max_features=5000,
       ngram_range=(1, 2))
   ```
   
   ```
   sed -i code/featurization.py \
       -e 's/max_features.*/max_features=5000, ngram_range=(1, 2))/'
   ```{{execute}}
   
   `git status -s`{{execute}}
   
   `git diff code/featurization.py`{{execute}}
   
   `dvc status`{{execute}}
   
   Try to reproduce the last stage:
   
   `dvc repro evaluate.dvc`{{execute}}
   
   Notice that it will reproduce the stages `featurize.dvc`,
   `train.dvc` and `evaluate.dvc`.
   
   `dvc status`{{execute}}
   
   `dvc repro evaluate.dvc`{{execute}}
   
4. Commit changes to git:

   `git status -s`{{execute}}
   
   `git diff`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m 'Using bigrams'`{{execute}}

5. Check the metrics again:

   `dvc metrics show -a`{{execute}}

   The option `-a, --all-branches` tells it to show the value of the
   metric for all the branches.
   
   It's convenient to keep track of information even for failed
   experiments. Sometimes a failed hypothesis gives more information
   than a successful one.
