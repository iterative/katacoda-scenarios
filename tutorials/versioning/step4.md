# Switching between versions

In GIT we get a version of the code with `git checkout`. After that we
need to run `dvc checkout` as well, to get from the DVC cache the
version of the data that corresponds to this version of the code.  The
corresponding version of the data is recorded on `.dvc` files (which
are tracked with GIT).

<img url="/dvc/courses/tutorials/versioning/assets/versioning.png" />

1. Suppose that we want to bring to the current workspace the version
   `v1.0` of the dataset. We can do it like this:
   
   `git tag`{{execute}}
   
   `git checkout v1.0 data.dvc`{{execute}}
   
   `git status`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout data.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
2. Now let's revert back the dataset to the latest version:
   
   `git status`{{execute}}
   
   `git reset HEAD data.dvc`{{execute}}
   
   `git checkout data.dvc`{{execute}}
   
   `git status`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout data.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
3. Suppose that we want to check out the state of the workspace as it
   was on version `v1.0`. We can do it like this:
   
   `git checkout v1.0`{{execute}}
   
   `git status`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
   
4. Let's go back to the latest version:

   `git checkout master`{{execute}}
   
   `git status`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
