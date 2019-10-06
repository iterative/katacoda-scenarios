# Pipelines

By using `dvc run` multiple times, and specifying outputs of a stage
as dependencies in another one, we can describe a sequence of steps or
processes that are needed to get a desired result. This is called a
_data pipeline_ or _dependency graph_.

1. Let's create another stage for feature extraction:

   ```
   highlight src/featurization.py \
       -O xterm256 | less -r
   ```{{execute}}

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
   
   `git add data/.gitignore featurize.dvc`{{execute}}
   
2. Create another stage for training:
   
   ```
   highlight src/train.py \
       -O xterm256 | less -r
   ```{{execute}}
   
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
   
   `git add .gitignore train.dvc`{{execute}}
   
   `git commit -m "Create featurization and training stages"`{{execute}}
   
   `dvc push`{{execute}}
   
3. Let's see the pipeline that we have built so far:

   `dvc pipeline show train.dvc`{{execute}}
   
   `dvc pipeline show train.dvc --ascii`{{execute}}

   ```
   dvc pipeline show train.dvc \
       --ascii --commands
   ```{{execute}}

   ```
   dvc pipeline show train.dvc \
       --ascii --outs
   ```{{execute}}

4. Let's use this pipeline to produce `model.pkl` again:

   `dvc status`{{execute}}
   
   `dvc repro train.dvc`{{execute}}

   Since nothing has changed and all the outputs are up to date, there
   is nothing to be executed and nothing to be reproduced. But let's
   delete the first line of `data/data/xml` and see what happens:
   
   `sed -i data/data.xml -e '1d'`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro train.dvc`{{execute}}

   `dvc status`{{execute}}
   
   `dvc repro train.dvc`{{execute}}
   
   Since we changed the data file, the stage `prepare.dvc` was rerun
   and its outputs changed (in directory `data/prepared/`). But
   `data/prepared` is a dependency of `featurize.dvc`, so this stage
   was rerun as well and its outputs changed (in directory
   `data/features/`). Finally, directory `data/features` is a
   dependency of the stage `train.dvc`, so this stage was rerun and
   `model.pkl` was reproduced.
   
   Along the way, `dvc repro` has saved to cache all the changed
   dependencies and outputs of the stages, and `dvc status` confirms
   that everything is up to date with the cache.

   `git status -s`{{execute}}
   
   `git diff`{{execute}}
   
   However the stage files (`*.dvc`) are now pointing to new versions
   of cached files (indicated by the changed MD5 hashes of
   dependencies and outputs). We should take a snapshot of the current
   state of the project by committing them to git:
   
   `git add .`{{execute}}
   
   `git commit -m "Produced another version of model.pkl"`{{execute}}
   
   If we want to share these data files and outputs with other people,
   we should also upload them to the data storage:
   
   `dvc status -c`{{execute}}
   
   `dvc push`{{execute}}
   
   `dvc status -c`{{execute}}
