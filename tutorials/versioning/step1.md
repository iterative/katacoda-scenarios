# Preparation

1. Get the code of the tutorial:

   `git clone https://github.com/iterative/example-versioning`{{execute}}
  
   `cd example-versioning/`{{execute}}
  
   `ls -al`{{execute}}
   
   `git status`{{execute}}
   
   `git remote -v`{{execute}}
   
   `git remote remove origin`{{execute}}
   
   `git remote -v`{{execute}}
   
   `git status`{{execute}}
  
2. Install requirements. It is recommended to install them in a
   virtual environment:

   `virtualenv -p python3 .env`{{execute}}
   
   `source .env/bin/activate`{{execute}}
   
   `cat requirements.txt`{{execute}}
   
   `pip3 install -r requirements.txt`{{execute}}

   `echo -e "\n.env/" >> .gitignore`{{execute}}
   
   `cat .gitignore`{{execute}}
   
   `git add .gitignore`{{execute}}
   
   `git commit -m "Ignore virtualenv directory"`{{execute}}
