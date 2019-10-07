# Initialize DVC

1. `dvc init`{{execute}}

2. `tree -a -I .git`{{execute}}

3. `git status`{{execute}}

4. `cat .dvc/.gitignore`{{execute}}

5. `cat .dvc/config`{{execute}}

The directory `.dvc` keeps cached files, configuration, and other DVC
meta files.

6. ```
   git commit \
       -m "Initialize DVC project"
   ```{{execute}}
