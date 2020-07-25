# Add a stage for training

Training is done by `src/train.py`:
   
```
highlight src/train.py \
    -O xterm256 | less -r
```{{execute}}

Let's add another stage for it:

```
dvc run \
    -n train \
    -d src/train.py \
    -d data/features \
    -o model.pkl \
    python \
        src/train.py \
        data/features \
        model.pkl
```{{execute}}

`git status -s`{{execute}}

`git diff .gitignore dvc.yaml`{{execute}}

`ls -lh model.pkl`{{execute}}

`cat dvc.yaml`{{execute}}

Add changes to Git and commit:

`git add .gitignore dvc.yaml dvc.lock`{{execute}}

`git status -s`{{execute}}

`git commit -m "Create featurization and training stages"`{{execute}}

Push cached files to the data storage:

`dvc status -c`{{execute}}

`dvc push`{{execute}}

`dvc status -c`{{execute}}
