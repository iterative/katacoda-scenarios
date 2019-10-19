# Create the pipeline

1. The second stage is data processing: create a feature matrix (and
   split it into a training set and a test set). This is done by
   `02-processing.py`, which imports `lib/processing.py`.
   
   `hl 02-processing.py | less -r`{{execute}}
   
   `hl lib/processing.py | less -r`{{execute}}
   
   `hl run/02-processing.sh`{{execute}}
   
   `bash -x run/02-processing.sh`{{execute}}
   
   The script runs this DVC command:
   
   ```
   dvc run \
       -f run/02-processing.dvc \
       -d data/01-raw-data/housing.csv \
       -d lib/processing.py \
       -o data/02-feature-matrix/training_data.csv \
       -o data/02-feature-matrix/test_data.csv \
       -M data/02-processing-metrics.txt \
       --overwrite-dvcfile \
       python \
           02-processing.py \
           --test_size 0.4 \
           --random_state 42
   ```
   
   It creates the stage file `run/02-processing.dvc`, which has
   dependencies `data/01-raw-data/housing.csv` and
   `lib/processing.py`, and generates the output files
   `data/02-feature-matrix/training_data.csv` and
   `data/02-feature-matrix/test_data.csv`, as well as the metrics file
   `data/02-processing-metrics.txt`.
   
   `git status -s`{{execute}}
   
   `cat data/02-feature-matrix/.gitignore`{{execute}}
   
   `head data/02-feature-matrix/training_data.csv`{{execute}}
   
   `head data/02-feature-matrix/test_data.csv`{{execute}}
   
   ```
   cat data/02-feature-matrix/training_data.csv \
       | wc -l
   ```{{execute}}
   
   ```
   cat data/02-feature-matrix/test_data.csv \
       | wc -l
   ```{{execute}}
   
   `cat data/02-processing-metrics.txt`{{execute}}
   
   `cat run/02-processing.dvc`{{execute}}
   
   Let's save the progress in Git:
   
   `git add .`{{execute}}
   
   `git status -s`{{execute}}
   
   `git commit -m 'Data processing'`{{execute}}

2. The third stage is data modeling. We train an elastic net model,
   evaluate the model (RMSE) and store the trained model in a joblib
   format.

   `hl 03-modeling.py | less -r`{{execute}}
   
   `hl lib/modeling.py | less -r`{{execute}}
   
   `hl run/03-modeling.sh`{{execute}}

   `bash -x run/03-modeling.sh`{{execute}}

   The script runs this DVC command:
   
   ```
   dvc run \
       -f run/03-modeling.dvc \
       -d data/02-feature-matrix/training_data.csv \
       -d data/02-feature-matrix/test_data.csv \
       -d lib/modeling.py \
       -o data/03-model/model.joblib \
       -M data/03-modeling-metrics.txt \
       --overwrite-dvcfile \
       python 03-modeling.py
   ```

   `git status -s`{{execute}}
   
   `cat data/03-model/.gitignore`{{execute}}
   
   `cat data/03-modeling-metrics.txt`{{execute}}
   
   `cat run/03-modeling.dvc`{{execute}}
      
   `git add .`{{execute}}
   
   `git status -s`{{execute}}
   
   `git commit -m 'Baseline model (elastic net)'`{{execute}}

3. Show the pipeline:

   ```
   dvc pipeline show \
       run/03-modeling.dvc
   ```{{execute}}

   ```
   dvc pipeline show \
       run/03-modeling.dvc --tree
   ```{{execute}}

   ```
   dvc pipeline show \
       run/03-modeling.dvc --ascii
   ```{{execute}}

   ```
   dvc pipeline show \
       run/03-modeling.dvc --ascii -c
   ```{{execute}}

4. Show the metrics:

   `dvc metrics show`{{execute}}
   
   `dvc metrics show -a`{{execute}}
