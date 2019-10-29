# Start Defining the Pipeline

In this section we start creating our basic pipeline, which is going
to use a multi-class Support Vector Machine (SVM) to classify the
data.

1. Download training and test data:

   ```
   wget https://pjreddie.com/media/files/mnist_train.csv \
       -O data/train_data.csv
   ```{{execute}}

   ```
   wget https://pjreddie.com/media/files/mnist_test.csv \
       -O data/test_data.csv
   ```{{execute}}

   `cat data/train_data.csv | wc -l`{{execute}}

   `cat data/test_data.csv | wc -l`{{execute}}
   
2. Add them to DVC:
   
   `dvc add data/train_data.csv`{{execute}}

   `dvc add data/test_data.csv`{{execute}}
   
   `git status -s`{{execute}}

   `git status -s data/`{{execute}}
   
   `cat data/.gitignore`{{execute}}

   `cat data/train_data.csv.dvc`{{execute}}

   `cat data/test_data.csv.dvc`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
3. Commit changes to Git:
   
   `git add .`{{execute}}
   
   `git commit -m "Imported training and test datasets"`{{execute}}

4. Create a featurization (pre-processing) stage:

   `hl code/featurization.py | less -r`{{execute}}
   
   ```
   dvc run \
       -f featurization.dvc \
       -d data/train_data.csv \
       -d data/test_data.csv \
       -d code/featurization.py \
       -o data/norm_params.json \
       -o data/processed_train_data.npy \
       -o data/processed_test_data.npy \
       python3 code/featurization.py
   ```{{execute}}
   
   `git status -s`{{execute}}
   
   `git diff data/.gitignore`{{execute}}
   
   `cat featurization.dvc`{{execute}}
   
   ```
   cat data/norm_params.json \
       | python -m json.tool
   ```{{execute}}
   
   `git add .`{{execute}}
