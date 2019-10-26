# Complete the Pipeline

Let's create stages for training and evaluation.

1. Create a stage for training, which creates and trains the model
   based on the training dataset:
   
   `hl code/train_model.py | less -r`{{execute}}
   
   ```
   dvc run \
       -f training.dvc \
       -d data/processed_train_data.npy \
       -d code/train_model.py \
       -M metrics/train_metric.json \
       -o data/model.pkl \
       python3 code/train_model.py
   ```{{execute}}

   `git status -s`{{execute}}
   
   `git diff data/.gitignore`{{execute}}
   
   `cat training.dvc`{{execute}}
   
   ```
   cat data/train_metric.json \
       | python json.tool
   ```{{execute}}

   `git add .`{{execute}}
   
   `git commit -m "Trained basic multiclass SVM model"`{{execute}}
   
   `dvc metrics show`{{execute}}

2. Create an evaluation stage, in which our model is scored for
   performance on the testing dataset:
   
   `hl code/eval.py | less -r`{{execute}}
   
   ```
   dvc run \
       -f eval.dvc \
       -d data/processed_test_data.npy \
       -d data/model.pkl \
       -d code/eval.py \
       -M metrics/eval.json \
       python3 code/eval.py
   ```{{execute}}
   
   `git status -s`{{execute}}
   
   `cat eval.dvc`{{execute}}

   `dvc metrics show`{{execute}}
   
3. We can tell DVC what type of files we are using in order to store
   our metrics, and where in the file our metric is stored:
   
   ```
   dvc metrics modify \
       metrics/train_metric.json \
       -t json -x training_time
   ```{{execute}}
   
   ```
   dvc metrics modify \
       metrics/eval.json \
       -t json -x accuracy
   ```{{execute}}

   `dvc metrics show`{{execute}}
   
4. Commit to Git:
   
   `git add .`{{execute}}
   
   `git commit -m "Evaluate basic SVM model"`{{execute}}
   
5. View the pipeline:
   
   ```
   dvc pipeline show \
       eval.dvc --ascii
   ```{{execute}}

   ```
   dvc pipeline show \
       eval.dvc --ascii -c
   ```{{execute}}

   ```
   dvc pipeline show \
       eval.dvc --ascii -o
   ```{{execute}}

6. Push cached data to the storage:
   
   `dvc status -c`{{execute}}
   
   `dvc push`{{execute}}
   
   `dvc status -c`{{execute}}
