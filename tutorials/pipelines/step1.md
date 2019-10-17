# Preparation

1. Setup a Git repository and add the code:

   `mkdir example-pipeline`{{execute}}
   
   `cd example-pipeline`{{execute}}
   
   `git init`{{execute}}
   
   ```
   dvc get \
       https://github.com/iterative/dataset-registry \
       tutorial/nlp/pipeline.zip
   ```{{execute}}
   
   With `dvc get` we can download DVC data from a Git repository (like
   `wget` but for DVC data). In this case we use the example project
   [iterative/dataset-registry](https://github.com/iterative/dataset-registry)
   as a data source.
   
   `ls -l`{{execute}}
   
   `unzip pipeline.zip`{{execute}}
   
   `tree`{{execute}}
   
   `rm pipeline.zip`{{execute}}
   
   `git add code/`{{execute}}
   
   `git status`{{execute}}
   
   `git commit -m 'Add code to Git repo'`{{execute}}
   
   `git status`{{execute}}
  
2. Install requirements. It is recommended to install them in a
   virtual environment:

   `apt install --yes virtualenv`{{execute}}
   
   `virtualenv -p python3 .env`{{execute}}
   
   `source .env/bin/activate`{{execute}}
   
   `cat code/requirements.txt`{{execute}}
   
   `pip3 install -r code/requirements.txt`{{execute}}

   `echo ".env/" >> .gitignore`{{execute}}
   
   `cat .gitignore`{{execute}}
   
   `git add .gitignore`{{execute}}
   
   `git commit -m "Ignore virtualenv directory"`{{execute}}

3. Initialize DVC:

   `dvc init`{{execute}}
   
   `git status`{{execute}}
   
   `git commit -m 'Initialize DVC'`{{execute}}

4. Download an input dataset and track it with DVC:

   `mkdir data`{{execute}}
   
   ```
   dvc get \
       https://github.com/iterative/dataset-registry \
       tutorial/nlp/Posts.xml.zip \
       -o data/Posts.xml.zip
   ```{{execute}}
   
   With the option `-o, --out` we set the destination of the
   downloaded file.
   
   `dvc add data/Posts.xml.zip`{{execute}}
   
   `tree -a data/`{{execute}}
   
   `cat data/.gitignore`{{execute}}
   
   `cat data/Posts.xml.zip.dvc`{{execute}}
   
   ```
   git add \
       data/.gitignore \
       data/Posts.xml.zip.dvc
   ```{{execute}}
   
   `git status`{{execute}}
   
   `git commit -m 'Add dataset archive'`{{execute}}
