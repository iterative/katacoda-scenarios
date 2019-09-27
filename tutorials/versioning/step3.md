# Second model version

Let's imagine that our images dataset has grown, and we want to
retrain the model with this larger set of images.

1. Let's download some more images and add them to the dataset:

   ```
   dvc get \
     https://github.com/iterative/dataset-registry \
     tutorial/ver/new-labels.zip
   ```{{execute}}
   
   `unzip new-labels.zip`{{execute}}
   
   `ls -al`{{execute}}
   
   `rm -f new-labels.zip`{{execute}}
   
   `tree -L 2 data`{{execute}}
   
   `ls data/train/*/*.jpg | wc -l`{{execute}}

   `ls data/validation/*/*.jpg | wc -l`{{execute}}

   `du -hs data/`{{execute}}
   
   For simplicity we have kept the validation dataset the same. Now our
   dataset has 2000 images for training and 800 images for validation,
   with a total size of 67 MB.

2. Let's record the new state of the dataset, and then let's generate
   a new trained model:
   
   `dvc status`{{execute}}
   
   `dvc commit data.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `python3 train.py`{{execute}}
   
   After retraining, the file `model.h5` has been changed. Let's
   commit (save) to DVC cache its new state:
   
   `dvc status`{{execute}}
   
   `dvc commit model.h5.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
3. When we committed the DVC files `data.dvc` and `model.h5.dvc`,
   besides storing in cache the current version of their corresponding
   data files, the contents of `data.dvc` and `model.h5.dvc` have been
   updated as well (to point to the latest versions of the cached
   data).  The file `metrics.json` has been changed as well by the
   training process.
   
   To record the state of the project after the second training, let's
   commit these modifications to Git. Let's also mark the second
   version of the dataset, model and metrics with another tag:

   `git status`{{execute}}
   
   `git add model.h5.dvc data.dvc metrics.json`{{execute}}
   
   `git commit -m "Second model, trained with 2000 images"`{{execute}}
   
   `git status`{{execute}}

   `git tag -a "v2.0" -m "model v2.0, 2000 images"`{{execute}}
   
   `git tag`{{execute}}
