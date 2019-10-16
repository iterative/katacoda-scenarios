# Location of .dvcignore

1. If we try to create `.dvcignore` inside a directory tracked by DVC,
   it will give an error:
   
   `echo data3 > data/.dvcignore`{{execute}}
   
   `tree -a data`{{execute}}
   
   `cat data/.dvcignore`{{execute}}
   
   `dvc status`{{execute}}

2. We should create it on the directories above the tracked one:
   
   `rm data/.dvcignore`{{execute}}
   
   `echo data/data3 > .dvcignore`{{execute}}
   
   `tree -a dir/`{{execute}}
   
   `cat .dvcignore`{{execute}}
   
   `dvc status`{{execute}}
   
3. However we can place `.dvcignore` on `dir/`, since it is the files
   inside this directory that are tracked, not the directory itself:

   `rm .dvcignore`{{execute}}
   
   `echo data1.dvc > dir/.dvcignore`{{execute}}
   
   `cat dir/.dvcignore`{{execute}}
   
   `dvc status`{{execute}}

4. We can have several `.dvcignore` files:

   `echo data.dvc > .dvcignore`{{execute}}
   
   `echo stage.dvc >> .dvcignore`{{execute}}
   
   `tree -a -I .dvc`{{execute}}
   
   `cat .dvcignore`{{execute}}
   
   `cat dir/.dvcignore`{{execute}}
   
   `dvc status`{{execute}}
   
   `rm .dvcignore`{{execute}}
   
   `dvc status`{{execute}}
