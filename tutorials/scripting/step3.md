# Create the pipeline

1. The second stage is data processing: create a feature matrix (and
   split it into a training set and a test set). This is done by
   `02-processing.py`, which imports `lib/processing.py`.
   
   `hl 02-processing.py | less -r`{{execute}}
   
   `hl lib/processing.py | less -r`{{execute}}
   
   `hl run/02-processing.sh`{{execute}}
   
   `bash -x run/02-processing.sh`{{execute}}
   
   `git status -s`{{execute}}
   
