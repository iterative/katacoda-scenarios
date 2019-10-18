# Create the first stage

1. Stages of the pipeline are built with the help of the scripts in
   `run/`:
   
   `tree run/`{{execute}}
   
   These scripts, on the other hand, use settings from `config.ini`:
   
   `hl config.ini`{{execute}}
   
   These configuration settings are converted to Bash arrays with the
   help of `run/configuration-parser.py`:
   
   `hl run/configuration-parser.py`{{execute}}
   
   ```
   run/configuration-parser.py \
       --ini config.ini | hl -S sh
   ```{{execute}}
   
   `run/configuration-parser.py | hl -S sh`{{execute}}
   
   These Bash arrays are _sourced_ (included) to the scripts like
   this:
   
   ```
   source <(run/configuration-parser.py --ini config.ini)
   ```

   `hl run/01-loading-housing.sh`{{execute}}
   
2. Create the stage for data loading:

   The program `01-loading-housing.py` generates some data and stores
   it under `data/01-raw-data`.

   `hl 01-loading-housing.py | less -r`{{execute}}
   
   To create the stage we would use a DVC command like this:
   
   ```
   dvc run \
       -f run/01-loading-housing.dvc \
       -d 01-loading-housing.py \
       -o data/01-raw-data/housing.csv \
       -M data/01-loading-metrics.txt
       --overwrite-dvcfile \
       python \
           01-loading-housing.py \
           --round 1
   ```
   
   The stage file will be saved on `run/01-loading-housing.dvc`. The
   program itself is listed a a dependency with `-d 01-loading-housing.py`.
   The output will be saved on `data/01-raw-data/housing.csv`
   (which will be added to `.gitignore` and will be saved to the DVC cache).
   A metrics file is generated as well, `data/01-loading-metrics.txt`,
   which will not be saved to the cache will be tracked by Git.
   
3. However to ensure consistency of file names with the other stages,
   and to make it configurable, we use the bash script to build this
   stage:
   
   `bash -x run/01-loading-housing.sh`{{execute}}
   
   `git status -s`{{execute}}
   
   `cat data/01-raw-data/.gitignore`{{execute}}
   
   `head data/01-raw-data/housing.csv`{{execute}}
   
   `cat data/01-loading-metrics.txt`{{execute}}
   
   `cat run/01-loading-housing.dvc`{{execute}}
   
   Let's track the progress so far with Git:
   
   `git add .`{{execute}}
   
   `git commit -m 'Data loading round 1'`{{execute}}
