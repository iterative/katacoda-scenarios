# Add a stage for training

Training is done by `src/train.py`:
   
```
highlight src/train.py \
    -O xterm256 | less -r
```{{execute}}

Let's add another stage for it:

```
dvc run \
    -f train.dvc \
    -d src/train.py \
    -d data/features \
    -o model.pkl \
    python \
        src/train.py \
        data/features \
        model.pkl
```{{execute}}

`git status -s`{{execute}}

`git diff .gitignore`{{execute}}

`ls -lh model.pkl`{{execute}}

`cat train.dvc`{{execute}}

Add changes to Git and commit:

`git add .gitignore train.dvc`{{execute}}

`git status -s`{{execute}}

`git commit -m "Create featurization and training stages"`{{execute}}

Push cached files to the data storage:

`dvc status -c`{{execute}}

`dvc push`{{execute}}

`dvc status -c`{{execute}}
