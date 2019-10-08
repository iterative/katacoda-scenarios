# Import a data file

First let's create an example project:

`mkdir try-import`{{execute}}

`cd try-import/`{{execute}}

`git init`{{execute}}

`dvc init -q`{{execute}}

`git commit -m "Initialize DVC project"`{{execute}}

Now let's import a data file from the git repository
https://github.com/iterative/dataset-registry:
   
```
git_repo=https://github.com/iterative/dataset-registry
dvc import \
    $git_repo get-started/data.xml
```{{execute}}

`ls -alh`{{execute}}

`git status -s`{{execute}}

`cat .gitignore`{{execute}}

`cat data.xml.dvc`{{execute}}

Same as `dvc get`, it downloads the file `get-started/data.xml`, but
it also creates the tracking file `data.xml.dvc`. This tracking file
contains among others the url of the Git repository and the revision
of the file that was downloaded.
