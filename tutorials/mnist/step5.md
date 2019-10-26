# Try Neural Networks (CNN)

Let's assume that the results of the previous experiment are not good
enough for us. This time we turn to the awesome power of neural
networks to tackle this digit classification problem.
   
1. Let's go back to the master branch and create a new branch for
   the CNN experiment:

   `git checkout master`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro eval.dvc`{{execute}}
   
   After checking out the Git files, our DVC tracked files (data,
   model and metrics), still refer to the PCA branch. Using the second
   command, `dvc checkout` takes care of that, as DVC looks for the
   appropriate hash in our cache folder and retrieves it to the
   working copy.
   
   Create another branch:
   
   `git checkout -b CNN`{{execute}}
   
2. For this experiment, we are going to use PyTorch, and therefore
   need to install this package:
   
   `pip install torch==1.0.0`{{execute}}
   
   `pip freeze > requirements.txt`{{execute}}
   
3. We need `my_torch_model.py` which contains a class definition of
   our CNN:
   
   `cp /tmp/*/CNN/my_torch_model.py code/`{{execute}}
   
   `hl code/my_torch_model.py | less -r`{{execute}}
   
   Next, let's get a new code for the model training:
   
   `cp /tmp/*/CNN/train_model.py code/`{{execute}}
   
   `git diff code/train_model.py`{{execute}}
   
   `hl code/train_model.py | less -r`{{execute}}
   
   We must also change `eval.py` to properly evaluate our new model:
   
   `cp /tmp/*/CNN/eval.py code/`{{execute}}
   
   `git diff code/eval.py`{{execute}}
   
   `hl code/eval.py | less -r`{{execute}}
   
4. Let's reproduce the model. We expect only the model and evaluation
   stages to be rerun:
   
   `dvc status`{{execute}}
   
   `dvc repro eval.dvc`{{execute}}
   
   `dvc status`{{execute}}

5. Let's commit this experiment to Git:
   
   `git status -s`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m "Experiment with CNN model"`{{execute}}
   
   Let's check the change in metrics:
   
   `dvc metrics show -a`{{execute}}
   
6. This model took much longer to train, but performed better than our
   best previous work. Let's merge this branch with the master:
   
   `git checkout master`{{execute}}
   
   `git merge CNN`{{execute}}
   
   To make sure we have all the updated files, lets get the relevant
   DVC files as well, and try `dvc repro`:
   
   `dvc checkout`{{execute}}
   
   `dvc repro eval.dvc`{{execute}}
   
7. Let's also make sure that the caches of all the branches are pushed
   to the storage:
   
   `dvc status -c -a`{{execute}}
   
   `dvc push -a`{{execute}}
