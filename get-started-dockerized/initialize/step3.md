# Initialize DVC

`dvc init` creates a new `.dvc/` directory for internal configuration and cache
files:

`dvc init`{{execute}}

The directory is automatically staged on git:

`git status -s`{{execute}}

Some files and folders in `.dvc/` are automatically added to `.gitignore`.

`cat .dvc/.gitignore`{{execute}}

```
git commit \
    -m "Initialize DVC project"
```{{execute}}
