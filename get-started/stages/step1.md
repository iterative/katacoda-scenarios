# Prepare

1. First of all let's get the code from the example project:

   `wget https://code.dvc.org/get-started/code.zip`{{execute}}
   
   `unzip code.zip`{{execute}}
   
   `rm code.zip`{{execute}}

   `tree`{{execute}}
   
   `git status -s`{{execute}}
   
   `git add params.yaml src/`{{execute}}
   
   `git status -s`{{execute}}
   
   ```
   git commit \
       -m "Add source code files to repo"
   ```{{execute}}

2. Now let's install the requirements. It is recommended to install
   them in a virtual environment.
   
   `apt install --yes virtualenv`{{execute}}
   
   `virtualenv -p python3 .env`{{execute}}
   
   `echo ".env/" >> .gitignore`{{execute}}
   
   `source .env/bin/activate`{{execute}}
   
   `cat src/requirements.txt`{{execute}}
   
   `pip install -r src/requirements.txt`{{execute}}
   
   `git status -s`{{execute}}
   
   `cat .gitignore`{{execute}}
   
   `git add .gitignore`{{execute}}
   
   ```
   git commit \
       -m "Ignore virtualenv directory"
   ```{{execute}}
   
