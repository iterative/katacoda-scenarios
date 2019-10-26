# Setup

1. Create a directory for the project and initialize it:

   `mkdir mnist`{{execute}}
   
   `cd mnist`{{execute}}
   
   `git init`{{execute}}
   
   `dvc init`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
2. Create and config a local data storage:

   `mkdir /root/dvc-storage`{{execute}}

   ```
   dvc remote add --default \
       storage /root/dvc-storage
   ```{{execute}}
   
   `dvc remote list`{{execute}}
   
   `cat .dvc/config`{{execute}}

3. Add the code and create other directories:

   `ls /usr/local/share/`{{execute}}

   `mkdir code data metrics`{{execute}}
   
   ```
   tar -C /tmp -xfzv \
       /usr/local/share/mnist-example-code.tgz
   ```{{execute}}
   
   `tree /tmp/mnist-example-code/`{{execute}}
   
   `cp /tmp/mnist-example-code/SVM/*.py code/`{{execute}}
   
   `tree`{{execute}}
      
4. Create a virtualenv and install the requirements:

   `virtualenv -p python3 .env`{{execute}}
   
   `echo .env/ >> .gitignore`{{execute}}
   
   `echo __pycache__/ >> .gitignore`{{execute}}
   
   `source .env/bin/activate`{{execute}}
   
   ```
   cat << EOF > requirements.txt
   numpy==1.15.4
   pandas==0.23.4
   python-dateutil==2.7.5
   pytz==2018.7
   scikit-learn==0.20.2
   scipy==1.2.0
   six==1.12.0
   sklearn==0.0
   EOF
   ```{{execute}}
   
   `pip install -r requirements.txt`{{execute}}


5. Commit progress to Git:

   `git status -s`{{execute}}
   
   `git add .`{{execute}}
   
   `git commit -m "Initialized project"`{{execute}}
