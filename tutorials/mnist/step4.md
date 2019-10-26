# Try Principle Component Analysis (PCA)

Now that we have established our pipeline, it's time to enjoy the
fruits of our labor. This mainly comes in the form of easy
experimentation and automatic reproducibility.

1. Let's say that we decide to see what results we get by reducing the
   number of features in our data, from 784 (28*28 pixels) to 15
   (using Principle Component Analysis (PCA)).
   
   Let's start by creating a new branch for this experiment:
   
   `git checkout -b PCA`{{execute}}
   
   `dvc repro eval.dvc`{{execute}}
   
   Nothing has changed yet, so nothing to re-run.
   
2. Let's start changing our code. For this experiment we edit only the
   featurization stage (`featurization.py`). Logically that means that
   we'll need to re-run the featurization stage, followed by model
   training and evaluation.

   `cp /tmp/*/PCA/featurization.py code/`{{execute}}
   
   `git status -s`{{execute}}
   
   `git diff code/featurization.py`{{execute}}
   
   `hl code/featurization.py | less -r`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro eval.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
3. Commit changes to Git:
   
   `git status -s`{{execute}}
   
   `git diff *.dvc`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m "Performed PCA to choose 15 features"`{{execute}}
   
4. Now that we committed the results to Git, we can see the change in
   metrics:

   `dvc metrics show -a`{{execute}}

5. Upload caches to the data storage:
   
   `dvc push`{{execute}}
   
   Notice that this time, only changed files are uploaded to the
   storage. The imported data for example, doesn't need to be pushed
   again, and this saves a lot of time.

