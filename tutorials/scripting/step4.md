# Try other experiments

1. Let's try another model (in another branch):

   `git checkout -b randomforest`{{execute}}

   In `lib/modeling.py` we change two lines `32` and `33` as follows
   (comment the first one and uncomment the second):
   
   ```
   #pipeline, param_grid, name = elastic_net(**kwargs)
   pipeline, param_grid, name = random_forest(**kwargs)
   ```

   This `sed` command makes this edit:
   
   ```
   sed -i lib/modeling.py \
       -e '32 s/pipeline/#pipeline/' \
       -e '33 s/#pipeline/pipeline/'
   ```{{execute}}
   
   `git diff lib/modeling.py`{{execute}}
   
   This change switches from the elastic net to the random
   forest. Then we reproduce the pipeline with `dvc repro`:

   `dvc status`{{execute}}
   
   `dvc repro run/03-modeling.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   As you see, DVC detects the change in the script (because it is a
   dependency of the third stage), and executes the command of the
   third stage again.
   
   Let's commit the changes:

   `git status -s`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m 'random forest'`{{execute}}

   Let's compare the metrics:
   
   `dvc metrics show -a`{{execute}}

2. Let's say that we are getting some new data. Before getting and
   processing it, we should move to a new branch:
   
   `git checkout master`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `git checkout -b round2`{{execute}}
   
   Then set `round = 2` in `config.ini`:
   
   ```
   sed -i config.ini \
       -e '/^round/ c round = 2'
   ```{{execute}}
   
   `git diff config.ini`{{execute}}
   
   Then we need to rebuild the first stage, which retrieves the new
   data:
   
   `bash -x run/01-loading-housing.sh`{{execute}}
   
   You can check the result in `data/01-loading-metrics.txt`:
   
   `cat data/01-loading-metrics.txt`{{execute}}
   
   Commit the change:
   
   `git add .`{{execute}}
   
   `git status -s`{{execute}}
   
   `git commit -m 'Data loading round2'`{{execute}}
   
   Reproduce the model:
   
   `dvc status`{{execute}}
   
   `dvc repro run/03-modeling.dvc`{{execute}}
   
   Check the whole pipeline by looking at the metrics:
   
   `dvc metrics show`{{execute}}
   
   Compare this branch/experiment with the other ones:
   
   `dvc metrics show -a`{{execute}}
