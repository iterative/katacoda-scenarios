# First model version

1. Let's get some data:

   ```
   dvc get \
       https://github.com/iterative/dataset-registry \
       tutorial/ver/data.zip
   ```{{execute}}
   
   The command `dvc get` is similar to `wget` but for DVC
   repositories.
   
   `ls -al`{{execute}}
   
   `unzip data.zip`{{execute}}
   
   `rm -f data.zip`{{execute}}
   
   `du -hs data/`{{execute}}
   
   `tree -L 2 data`{{execute}}
   
   `tree data | head`{{execute}}
   
   `ls -l data/train/dogs/ | head -10`{{execute}}
   
   `ls data/train/dogs/ | wc -l`{{execute}}

   `ls -l data/train/cats/ | head -10`{{execute}}
   
   `ls data/train/cats/ | wc -l`{{execute}}

   `ls -l data/validation/dogs/ | head -10`{{execute}}
   
   `ls data/validation/dogs/ | wc -l`{{execute}}

   `ls -l data/validation/cats/ | head -10`{{execute}}
   
   `ls data/validation/cats/ | wc -l`{{execute}}
   
   
   There are 500 dog images for _training_ and 500 cat images. There
   are also 400 dog images for _validation_ and 400 cat images.

2. Let's get a snapshot of the dataset `data/` with `dvc add`:

   `dvc add data`{{execute}}
   
   `ls`{{execute}}
   
   `git status`{{execute}}
   
   `cat data.dvc`{{execute}}
   
   `ls .dvc/cache/b8/f4d5a78e55e88906d5f4aeaf43802e.dir`{{execute}}
   
   ```
   cat .dvc/cache/b8/f4d5a78e55e88906d5f4aeaf43802e.dir \
       | python3 -m json.tool 2>/dev/null \
       | head -20
   ```{{execute}}
   
   `cat .gitignore`{{execute}}
   
   Since `data/` is large and contains binary files, we use DVC to
   track it, instead of Git. The command `dvc add` saves a copy of it
   into the DVC cache, creates the file `data.dvc` which may be
   considered as a pointer to the cached data, and tells git to ignore
   this directory.

3. Next, let's do the training with `python train.py`:

   `python3 train.py`{{execute}}
   
   Although we are using a small dataset (just for training purposes),
   it may still take a few minutes until the training is finished.
   
   `ls`{{execute}}
   
   It produces a bunch of files, among them `model.h5` (weights of the
   trained model) and `metrics.json`.
   
   We can store a copy of the produced model on the DVC cache (using
   `dvc add` again):
   
   `dvc add model.h5`{{execute}}
   
   `ls`{{execute}}
   
   `cat model.h5.dvc`{{execute}}
   
   `cat .gitignore`{{execute}}

4. Let's take a snapshot of the current state of the project with a
   Git commit and a tag:
   
   `git status`{{execute}}
   
   `git add .gitignore model.h5.dvc data.dvc metrics.json`{{execute}}
   
   `git commit -m "First model, trained with 1000 images"`{{execute}}

   `git tag -a "v1.0" -m "model v1.0, 1000 images"`{{execute}}

   Note that we did not commit the dataset itself and the model file
   (which are actually listed on `.gitignore` to make sure that they
   will not be committed). They are stored on the DVC cache. Instead,
   we committed to git the `.dvc` files that track them on DVC (point
   to them on the DVC cache).

   For the time being we are just ignoring the `*.npy` files produces
   by the training process, but we are going to use them later.


Storing the data files to the DVC cache, and committing `.dvc` files to
Git, provides us a full picture/snapshot of the current state. Later
we can switch back to this state, if needed, by first restoring from
Git the tagged version of `.dvc` files, and these `.dvc` files will
allow us to restore from DVC cache the correct versions of the data
files.
