# Initialize

1. Install DVC:

   `pip3 install dvc`{{execute}}
   
   `dvc version`{{execute}}

2. Create a Git repository:

   `mkdir example-get-started`{{execute}}
   
   `cd example-get-started/`{{execute}}
   
   `git init`{{execute}}
   
   DVC doesn't require Git and can work without it, but in practice it
   is almost always used with Git.
   
3. Initialize DVC:

   `dvc init`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
   `git status`{{execute}}
   
   `cat .dvc/.gitignore`{{execute}}
   
   `cat .dvc/config`{{execute}}
   
   The directory `.dvc` keeps cached files, configuration, and other
   DVC meta files.
   
   `git commit -m "Initialize DVC project"`{{execute}}
