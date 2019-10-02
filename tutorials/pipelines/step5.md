# Experimenting

In the `bigrams` experiment we tried to improve the `featurization`
stage. Maybe we should try to improve the model by changing the
hyperparameters. There is no good reason to improve the `bigrams`
model, so let's try this improvement on top of the original model from
the master branch.

1. Create a branch for the new experiment:

   `git branch -a`{{execute}}
      
   `git checkout master`{{execute}}
   
   `dvc status`{{execute}}

   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}

   `dvc repro evaluate.dvc`{{execute}}
   
   Notice that we have both the code and the data from the last
   experiment, so everything is up to date and `dvc repro` has nothing
   to rerun.
   
   `git checkout -b tuning`{{execute}}

   `git branch -a`{{execute}}

2. Edit `code/train_model.py`:

   On line 45, at `RandomForestClassifier`, increase the number of
   trees in the forest to `700`, by changing the `n_estimators`
   parameter, and the number of jobs to `6`, by changing `n_jobs`:
   
   ```
   sed -i code/train_model.py \
       -e 's/n_estimators=100/n_estimators=700/' \
       -e 's/n_jobs=2/n_jobs=6/'
   ```{{execute}}
   ```
   
   `git status -s`{{execute}}
   
   `git diff code/train_model.py`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro evaluate.dvc`{{execute}}
   
   `dvc status`{{execute}}

   `dvc repro evaluate.dvc`{{execute}}
   
   `git status`{{execute}}
   
   `git diff`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m '700 trees in the forest'`{{execute}}
   
   `dvc metrics show -a`{{execute}}
   
3. The current model with 700 trees in the forest seems to be stronger
   and we might be able to get more information using bigrams. So,
   let's incorporate the bigrams changes into the current model using
   Git merge. However let's do it on a new branch, as usual:

   `git branch -a`{{execute}}
   
   `git checkout -b train_bigrams`{{execute}}
   
   ```
   git merge bigrams \
       --strategy-option theirs \
       -m 'Merging bigrams'
   ```{{execute}}
   ```

   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro evaluate.dvc`{{execute}}
   
   `git status`{{execute}}
   
   `git diff`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m 'Merge bigrams into the tuned model'`{{execute}}
   
   `dvc metrics show -a`{{execute}}
   
4. It seems that our current branch contains the best model, so let's
   merge it into master:
   
   `git branch -a`{{execute}}
   
   `git checkout master`{{execute}}
   
   `git merge train_bigrams`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro evaluate.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `git status -s`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m 'Update metrics etc.'`{{execute}}
   
   `dvc metrics show -a`{{execute}}
