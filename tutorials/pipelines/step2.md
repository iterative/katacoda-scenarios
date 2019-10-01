# Define stages

1. Extract XML from the archive:

   ```
   dvc run \
       -f extract.dvc \
       -d data/Posts.xml.zip \
       -o data/Posts.xml \
       'unzip data/Posts.xml.zip -d data'
   ```{{execute}}
   ```
   
   `git status -s`{{execute}}
   
   `git diff data/.gitignore`{{execute}}
   
   `cat extract.dvc`{{execute}}
   
   `tree .dvc/cache`{{execute}}
   
   ```
   diff \
       data/Posts.xml \
       .dvc/cache/a3/04afb96060aad90176268345e10355
   ```{{execute}}
   ```
   
   Notice that the given command is executed, the output file is saved
   to cache, and the stage file `extract.dvc` is created.
   
   `git add data/.gitignore extract.dvc`{{execute}}
   
   `git status -s`{{execute}}
   
2. Convert XML into TSV to make feature extraction easier:

   ```
   dvc run \
       -f prepare.dvc \
       -d code/xml_to_tsv.py \
       -d data/Posts.xml \
       -o data/Posts.tsv \
       python \
           code/xml_to_tsv.py \
           data/Posts.xml \
           data/Posts.tsv
   ```{{execute}}
   ```
   
   `git status -s`{{execute}}
   
   `git diff data/.gitignore`{{execute}}
   
   `cat prepare.dvc`{{execute}}
   
   `git add data/.gitignore prepare.dvc`{{execute}}
   
   `git status -s`{{execute}}
   
   `ls -lh data/`{{execute}}
   
3. Split training and test datasets:
   
   ```
   dvc run \
       -f split.dvc \
       -d code/split_train_test.py \
       -d data/Posts.tsv \
       -o data/Posts-train.tsv \
       -o data/Posts-test.tsv \
       python \
           code/split_train_test.py \
           data/Posts.tsv \
           0.2 \
           20191001 \
           data/Posts-train.tsv \
           data/Posts-test.tsv
   ```{{execute}}
   ```

   Here `0.2` is a test dataset split ratio, `20191001` is a seed for
   randomization.

   `git status -s`{{execute}}
   
   `git diff data/.gitignore`{{execute}}

   `cat split.dvc`{{execute}}
   
   `ls -lh data/`{{execute}}

   `git add .`{{execute}}
   
4. Extract features and labels from the data:

   ```
   dvc run \
       -f featurize.dvc \
       -d code/featurization.py \
       -d data/Posts-train.tsv \
       -d data/Posts-test.tsv \
       -o data/matrix-train.pkl \
       -o data/matrix-test.pkl \
       python \
           code/featurization.py \
           data/Posts-train.tsv data/Posts-test.tsv \
           data/matrix-train.pkl data/matrix-test.pkl
   ```{{execute}}
   ```
   
   `git status -s`{{execute}}
   
   `git diff data/.gitignore`{{execute}}

   `cat featurize.dvc`{{execute}}
   
   `ls -lh data/`{{execute}}

   `git add .`{{execute}}

5. Train a ML model on the training dataset:

   ```
   dvc run \
       -f train.dvc \
       -d code/train_model.py \
       -d data/matrix-train.pkl \
       -o data/model.pkl \
       python \
           code/train_model.py \
           data/matrix-train.pkl \
           20191001 \
           data/model.pkl
   ```{{execute}}
   ```

   Here `20191001` is a seed value.

   `git status -s`{{execute}}
   
   `git diff data/.gitignore`{{execute}}

   `cat featurize.dvc`{{execute}}
   
   `ls -lh data/`{{execute}}

   `git add .`{{execute}}

6. Evaluate the model on the test dataset and get the metric file:

   ```
   dvc run \
       -f evaluate.dvc \
       -d code/evaluate.py \
       -d data/model.pkl \
       -d data/matrix-test.pkl \
       -M auc.metric \
       python \
           code/evaluate.py \
           data/model.pkl \
           data/matrix-test.pkl \
           auc.metric
   ```{{execute}}
   ```
   
   `git status -s`{{execute}}
   
   `cat evaluate.dvc`{{execute}}
   
   `cat auc.metric`{{execute}}
   
   `git add .`{{execute}}
