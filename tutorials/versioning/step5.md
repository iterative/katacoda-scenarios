# Tracking outputs of a process

In the previous steps we have used `dvc add` and `dvc commit` to track
the changes of `model.h5`. However notice that this is one of the
output results of running `train.py`, which takes `data/` as
input. Since training and generating the model file takes significant
time, it would be desirable not to run this process again, unless
`data/` has changed, since this would generate
the same results (`model.h5`).

We can do this with stages, which track the state of a process that
takes some inputs and generates some outputs. Whenever the outputs of
the stage are changed, they are automatically saved to cache.

1. Right now we are tracking `model.h5` as an independent data file.
   Let's untrack it first (so that we can track it as an output of a
   stage):
   
   `dvc remove -pf model.h5.dvc`{{execute}}

2. Now let's create a stage file:

   ```
   dvc run -f train.dvc \
           -d data \
           -d train.py \
           -M metrics.csv \
           -o model.h5 -o bottleneck_features_train.npy -o bottleneck_features_validation.npy \
           python3 train.py
   ```{{execute}}
   
   The last line is the command `python train.py`.
   
   The options `-d data` and `-d train.py` are the dependencies (inputs) of
   this stage.
   
   With the option `-o` we define the outputs of the command. These
   outputs are tracked automatically by DVC. This means that whenever
   we run this stage again (with `dvc repro`) and it generates some
   new outputs, they will be automatically committed (saved) to the DVC
   cache.
   
   Metrics on the other hand are small outputs of the command, so they
   are tracked with Git, instead of storing them in cache.
   
   The option `-f train.dvc` gives the name of the file where this
   stage is saved. It is created after the command is finished
   successfully.

   `cat train.dvc`{{execute}}

   `git status`{{execute}}
   
   `git rm model.h5.dvc`{{execute}}
   
   `git add train.dvc`{{execute}}
   
   `git add metrics.csv`{{execute}}
   
   `git commit -m "Tracking model.h5 as an output of stage train.dvc"`{{execute}}
   
   We can run this stage again with `dvc repro`:
   
   `dvc repro train.dvc`{{execute}}
