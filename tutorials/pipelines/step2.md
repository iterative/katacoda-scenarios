# Defining stages

The pipeline itself is a sequence of transformations we apply to the
data file, which looks like this:

![](/dvc/courses/tutorials/pipelines/assets/example-flow.png)

Let's create these stages.

1. Extract XML from the archive:

   ```
   dvc run \
       -f extract.dvc \
       -d data/Posts.xml.zip \
       -o data/Posts.xml \
       'unzip data/Posts.xml.zip -d data'
   ```{{execute}}
   
   `git status -s`{{execute}}
   
   `git diff data/.gitignore`{{execute}}
   
   `cat extract.dvc`{{execute}}
   
   `tree .dvc/cache`{{execute}}
   
   ```
   diff \
       data/Posts.xml \
       .dvc/cache/a3/04afb96060aad90176268345e10355
   ```{{execute}}
   
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

   Here `0.2` is a test dataset split ratio, `20191001` is a seed for
   randomization.

   `git status -s`{{execute}}
   
   `git diff data/.gitignore`{{execute}}

   `cat split.dvc`{{execute}}
   
   `ls -lh data/`{{execute}}
   
   `cat data/Posts-train.tsv | wc -l`{{execute}}
   
   `cat data/Posts-test.tsv | wc -l`{{execute}}

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
           data/Posts-train.tsv \
           data/Posts-test.tsv \
           data/matrix-train.pkl \
           data/matrix-test.pkl
   ```{{execute}}
   
   **Note:** This command fails because the virtual environment of
   Katacoda does not have enough RAM to handle it:
   
   `free -h`{{execute}}
   
   We will try to fix it in the next step.
