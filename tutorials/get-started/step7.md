# Experiments and metrics

Data science process is inherently iterative and R&D like. Data
scientist may try many different approaches, different hyper-parameter
values, and "fail" many times before the required level of a metric is
achieved. DVC provides a framework to capture and compare experiments
performance through metrics.

1. Let's add an evaluation stage to the pipeline:

   ```
   highlight src/evaluate.py \
       -O xterm256 | less -r
   ```{{execute}}

   ```
   dvc run \
       -f evaluate.dvc \
       -d src/evaluate.py \
       -d model.pkl \
       -d data/features \
       -M auc.metric \
       python \
           src/evaluate.py \
           model.pkl \
           data/features \
           auc.metric
   ```{{execute}}
   
   The command calculates AUC value using the test dataset. It reads
   features from the `data/features/test.pkl` file and produces the
   metric file `auc.metric`, which is marked by the option `-M`.  This
   option tells the stage to not store the metrics file in cache;
   since it is just a small text file we can store it in Git. If we
   wanted to store it in the DVC cache instead, we would have used the
   option `-m` (lowercase).

   `git status -s`{{execute}}
   
   `cat evaluate.dvc`{{execute}}
   
   `cat auc.metric`{{execute}}

   `dvc metrics show`{{execute}}

2. Let's get another snapshot of the project by committing changes to
   Git:

   `git add evaluate.dvc auc.metric`{{execute}}
   
   `git commit -m "Create evaluation stage"`{{execute}}
   
   Let's also assign a Git tag. It will serve as a checkpoint for us
   to compare this approach with other experiments in the future, or
   if we need to go back and checkout it and the get the corresponding
   data.
   
   ```
   git tag -a "baseline-experiment" \
       -m "Baseline experiment evaluation"
   ```{{execute}}

3. Let's say that now we want to try a modified feature extraction:

   Edit `src/featurization.py` to enable bigrams and increase the
   number of features. Open it with a text editor (`vim` or `nano`)
   and set `max_features=6000` and `ngram_range=(1, 2)` in
   `CountVectorizer`, line 78, like this:
   
   ```
   bag_of_words = CountVectorizer(
       stop_words='english',
       max_features=6000,
       ngram_range=(1, 2))
   ```
   
   ```
   sed -i src/featurization.py \
       -e 's/max_features.*/max_features=6000, ngram_range=(1, 2))/'
   ```{{execute}}
   
   `git status -s`{{execute}}
   
   `git diff src/featurization.py`{{execute}}
   
   `dvc status`{{execute}}
   
   Try to reproduce the last stage:
   
   `dvc repro evaluate.dvc`{{execute}}
   
   Notice that it will reproduce the stages `featurize.dvc`,
   `train.dvc` and `evaluate.dvc`.
   
   `dvc status`{{execute}}
   
   `dvc repro evaluate.dvc`{{execute}}
   
   `dvc metrics show`{{execute}}
   
4. Commit changes to git:

   `git status -s`{{execute}}
   
   `git diff`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m "Using bigrams"`{{execute}}
   
   Set also a new tag:
   
   ```
   git tag -a "bigrams-experiment" \
       -m "Bigrams experiment"
   ```{{execute}}

5. Compare experiments across the tags:

   `dvc metrics show -T`{{execute}}

   The option `-T, --all-tags` tells it to show the value of the
   metric for all the tags. Since we have set a different tag to each
   experiment, this effectively compares the performance of each
   experiment.
