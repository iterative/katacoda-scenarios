# Add a stage for feature extraction

Feature extraction is done by `src/featurization.py`:

```
highlight src/featurization.py \
    -O xterm256 | less -r
```{{execute}}

Let's create another stage for it:

```
dvc run \
    -f featurize.dvc \
    -d src/featurization.py \
    -d data/prepared \
    -o data/features \
    python \
        src/featurization.py \
        data/prepared \
        data/features
```{{execute}}

`git status -s`{{execute}}

`git diff data/.gitignore`{{execute}}

`ls -lh data/features/`{{execute}}

`cat featurize.dvc`{{execute}}

Add changes to Git:

`git add data/.gitignore featurize.dvc`{{execute}}
