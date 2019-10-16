# Initialize

1. Create a test project:

   `mkdir proj1`{{execute}}
   
   `cd proj1/`{{execute}}
   
   `dvc init --no-scm -q`{{execute}}
   
2. Create a data directory:
   
   `mkdir data`{{execute}}
   
   `echo data1 > data/data1`{{execute}}
   
   `echo data2 > data/data2`{{execute}}
   
   `tree -a`{{execute}}
