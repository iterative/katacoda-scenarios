# Stages

The commands that we have seen so far: `dvc add`, `dvc push`, `dvc
pull`, etc. provide a useful framework to track, save and share models
and large data files. In some cases and scenarios this could be all
you need. But usually in ML scenarios you need to process data and
generate outputs in a reproducible way. This requires establishing a
connection between the data that are processed, the program that
processes them, the parameters of processing, and the outputs of the
process. This relationship between these components should support and
facilitate reproducibility. And this is exactly what stages of DVC do.

1. First of all let's get the code from the example project:

   `wget https://code.dvc.org/get-started/code.zip`{{execute}}
   
   `unzip code.zip`{{execute}}
   
   `tree`{{execute}}
   
   `rm code.zip`{{execute}}

   `git status -s`{{execute}}
   
   `git add src/`{{execute}}
   
   `git status -s`{{execute}}
   
   `git commit -m "Add source code files to repo"`{{execute}}

2. Now let's install the requirements. It is recommended to install
   them in a virtual environment.
   
   `virtualenv -p python3 .env`{{execute}}
   
   `echo ".env/" >> .gitignore`{{execute}}
   
   `source .env/bin/activate`{{execute}}
   
   `cat src/requirements.txt`{{execute}}
   
   `pip install -r src/requirements.txt`{{execute}}
   
   `git status -s`{{execute}}
   
   `cat .gitignore`{{execute}}
   
   `git add .gitignore`{{execute}}
   
   `git commit -m "Ignore virtual env directory"`{{execute}}
   
3. Let's build a stage based on the script `src/prepare.py`:

   ```
   highlight src/prepare.py -O xterm256 \
       | less -r
   ```{{execute}}
   
   ```
   dvc run \
       -f prepare.dvc \
       -d src/prepare.py \
       -d data/data.xml \
       -o data/prepared \
       python \
           src/prepare.py \
           data/data.xml
   ```{{execute}}
   
   The output of `dvc run` is telling us that it is running the given
   python command. The output of this command is supposed to be on the
   directory `data/prepared`, as indicated by the option `-o`
   (output). So, after running the command, the output directory is
   added to `data/.gitignore` and is saved in `.dvc/cache/`. Finally,
   the information needed for rerunning this stage is saved in the
   file `prepare.dvc`, which is indicated by the option `-f`
   (filename). The options `-d` indicate the dependencies of this
   stage. We will see later what are dependencies and how they are
   used by DVC.
   
   `git status -s`{{execute}}
   
   `git diff data/.gitignore`{{execute}}
   
   `tree -a data/`{{execute}}
   
   Notice that `train.tsv` and `test.tsv` have been created on
   `data/prepared/`.
   
   `cat prepare.dvc`{{execute}}
   
   The stage file created by `dvc run` is similar to the data-tracking
   file created by `dvc add`, but it also has the field `cmd:` for the
   command and the field `deps:` for dependencies.

   `tree .dvc/cache/`{{execute}}
   
   Notice how the MD5 hash of `data/prepared` output corresponds to
   the path of the cached directory.

   `cat .dvc/cache/*/*.dir`{{execute}}
   
   ```
   cat .dvc/cache/*/*.dir \
       | python -m json \
       | highlight -S json -O xterm256
   ```{{execute}}
   
   So, the cached directory entry contains a list of the paths and MD5
   hashes of the files that are inside the tracked directory, in JSON
   format, and these files themselves are also saved in the cache,
   named after their MD5 hashes.
   
   This was a lot of new information, `dvc run` really does a lot of
   things!

4. Reproducing the outputs of the stage:

   `cat prepare.dvc`{{execute}}

   `dvc status prepare.dvc`{{execute}}
   
   `dvc repro prepare.dvc`{{execute}}
   
   Before running again the command of the stage and reproducing the
   outputs, DVC checks whether the dependencies have changed. The
   dependencies usually include the inputs, the program that processes
   them, the configuration parameters, etc. If none of them has
   changed, then it is guaranteed that the outputs will be the same as
   before. So it makes no sense to run the command again, since we
   already have the outputs, and even have them saved in cache.

   Our stage has as dependencies `src/prepare.py`, which has not
   changed, and `data/data.xml`, which is tracked by
   `data/data.xml.dvc`. So, in order to decide whether the outputs of
   the stage `prepare.dvc` need to be reproduced, DVC has to check
   `data/data.xml.dvc` as well. In our case nothing has changed, so
   nothing needs to be reproduced.
   
5. Save the current state of the project to Git and push the data
   files to the data storage:

   `git status -s`{{execute}}
   
   `git add data/.gitignore prepare.dvc`{{execute}}
   
   `git commit -m "Create data preparation stage"`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc push`{{execute}}
   
   `dvc status -c`{{execute}}
