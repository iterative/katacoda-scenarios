# Continue building the pipeline

The command of the last stage failed because there is not enough RAM
to handle all the data. Let's try to fix it by reducing the size of
input that is to be processed.

1. First, let's cut down the size of `data/Posts.tsv`:
   
   `cat data/Posts.tsv | wc -l`{{execute}}
   
   `cp data/{Posts.tsv,Posts.tsv.1}`{{execute}}
   
   ```
   head -n 15000 \
       data/Posts.tsv.1 \
       > data/Posts.tsv
   ```{{execute}}
   ```
   
   `cat data/Posts.tsv | wc -l`{{execute}}
   
   `rm data/Posts.tsv.1`{{execute}}
   
   `dvc status`{{execute}}
   
   We see that the stage `prepare.dvc` is modified. If we reproduce
   it, it is going to overwrite the changes that we made manually to
   `data/Posts.tsv`. To prevent this we can _lock_ this stage:
   
   `dvc lock prepare.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
2. Let's also modify the split ratio from `0.2` to `0.3` on the
   command of `split.dvc`:
   
   ```
   sed -i split.dvc \
       -e '/cmd:/ s/0.2/0.3/'
   ```{{execute}}
   ```
   
   `dvc status`{{execute}}
   
   The stage `split.dvc` has changed, since its command has been
   modified. Let's reproduce it:
   
   `dvc repro split.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `cat data/Posts-train.tsv | wc -l`{{execute}}
   
   `cat data/Posts-test.tsv | wc -l`{{execute}}
   
3. Finally, let's try to define `featurize.dvc` again:

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
   ```

   `git status -s`{{execute}}
   
   `git diff data/.gitignore`{{execute}}

   `cat featurize.dvc`{{execute}}
   
   `ls -lh data/`{{execute}}

   `git add .`{{execute}}
   
   `dvc status`{{execute}}
   
4. We can continue with training a ML model on the training dataset
   and with evaluating the model on the testing dataset:

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

   Here `20191001` is a seed value.

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
   
   `git status -s`{{execute}}
   
   `git diff data/.gitignore`{{execute}}

   `ls -lh data/`{{execute}}
   
   `cat auc.metric`{{execute}}

5. Let's save the pipeline and check the results:

   `git add .`{{execute}}
   
   `git status`{{execute}}
   
   `git commit -m 'Add tag prediction pipeline (6 stages)'`{{execute}}
   
   `tree .dvc/cache`{{execute}}
   
   We are just saving a snapshot of the `.dvc` files that describe
   data, transformations (stages), and relationships between them.
   The data files themselves are stored in the cache:
   
   `dvc metrics show`{{execute}}

   ```
   dvc pipeline show \
       evaluate.dvc --ascii
   ```{{execute}}

   ```
   dvc pipeline show \
       evaluate.dvc --ascii -o
   ```{{execute}}
