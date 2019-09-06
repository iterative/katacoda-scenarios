# Initialize a DVC project

1. Create a project directory:

   `mkdir proj1`{{execute}}
   
2. Initialize DVC:

   `cd proj1`{{execute}}
  
   `dvc init --no-scm`{{execute}}
   
   `ls -al`{{execute}}
  
   With the option `--no-scm` we are telling it that we are not going
   to use it togather with GIT.
  
3. Check the `.dvc` directory that was created:

   `tree -a`{{execute}}
   
   `cat .dvc/config`{{execute}}
   
   It has created an empty cache directory and an empty config file.
   
4. Create a file and track it with DVC:

   `echo 'test 1' > file1.txt`{{execute}}
   
   `cat file1.txt`{{execute}}
   
   `dvc add file1.txt`{{execute}}
   
   `ls -l`{{execute}}
      
   `tree -a`{{execute}}
   
   DVC is now tracking `file1.txt`.

5. Disengage DVC:

   `dvc destroy`{{execute}}
   
   `ls -al`{{execute}}
   
   `tree -a`{{execute}}
   
   Notice that the data-tracking file `file1.txt.dvc` (which tracks
   `file1.txt`) is removed, while the data file itself (`file1.txt`)
   is not. The DVC directory `.dvc/` is removed as well, along with
   the cache, config and meta-data files.
