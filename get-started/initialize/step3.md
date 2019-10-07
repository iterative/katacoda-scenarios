# Initialize DVC

`dvc init`{{execute}}

`tree -a -I .git`{{execute}}

`git status`{{execute}}

`cat .dvc/.gitignore`{{execute}}

`cat .dvc/config`{{execute}}

The directory `.dvc` keeps cached files, configuration, and other DVC
meta files.

`git commit -m "Initialize DVC project"`{{execute}}
