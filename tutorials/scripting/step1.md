# Initialize

1. Get the code and initialize Git:

   `ls /usr/local/share/`{{execute}}

   `unzip /usr/local/share/code.zip`{{execute}}
  
   `cd dvc-usecase-1.0/`{{execute}}
   
   `ls -al`{{execute}}
  
   `tree -a`{{execute}}
   
   `git init`{{execute}}
   
   `git add .`{{execute}}
   
   `git status -s`{{execute}}
   
   `git commit -m 'Add code'`{{execute}}
   
2. Install requirements. It is recommended to install them in a
   virtual environment:

   `virtualenv -p python3 .env`{{execute}}
   
   `source .env/bin/activate`{{execute}}
   
   `cat requirements.txt`{{execute}}
   
   `pip3 install -r requirements.txt`{{execute}}

   `echo -e "\n.env" >> .gitignore`{{execute}}

   `cat .gitignore`{{execute}}
   
   `git add .gitignore`{{execute}}
   
   `git commit -m 'Ignore .env'`{{execute}}

3. Initialize DVC:
   
   `dvc init`{{execute}}
   
   `git status -s`{{execute}}
   
   `git commit -m 'Initialize DVC'`{{execute}}
 
4. Inspect the code of the project:

   `tree`{{execute}}
   
   `hl 01-loading-housing.py | less -r`{{execute}}
   
   `hl 02-processing.py | less -r`{{execute}}
   
   `hl 03-modeling.py | less -r`{{execute}}
   
   `tree -a data/`{{execute}}
   
   `tree -a lib/`{{execute}}
   
   `hl lib/__init__.py | less -r`{{execute}}
   
   `hl lib/modeling.py | less -r`{{execute}}
   
   `hl lib/processing.py | less -r`{{execute}}
   
   `tree -a test/`{{execute}}
   
   `hl test/test_Metics.py | less -r`{{execute}}
   
5. Inspect the scripts that will build the pipeline:
   
   `tree run/`{{execute}}
   
   `hl run/01-loading-housing.sh`{{execute}}
   
   `hl run/02-processing.sh`{{execute}}
   
   `hl run/03-modeling.sh`{{execute}}
   
   `hl run/configuration-parser.py`{{execute}}
   
   `hl config.ini`{{execute}}
