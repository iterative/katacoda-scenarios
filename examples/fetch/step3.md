# Fetching and tags/branches

1. Let's say that we want to check again a previous iteration, for
   example the tag `baseline-experiment`:

   `git tag`{{execute}}
   
   `git checkout baseline-experiment`{{execute}}
   
   `git status`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}
   
   Why are some files missing from the cache? Didn't we fetch them
   from the remote storage on the previous step? The catch is that
   `dvc fetch` by default downloads only data that are needed in the
   current state (tag/branch/revision) of the project (it looks at
   `.dvc` files to find out the data files that are needed).
   
2. Let's get the needed files:

   `dvc fetch`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
   
   `tree .dvc/cache`{{execute}}
   
3. As we saw, by default `dvc fetch` is conservative, it downloads the
   least amount of data that resolves the problems (only the data
   files that are currently needed). And this is usually a good thing.
   However, if we want to download all the data files, for all the
   tags and branches, we can use the options `-a, --all-branches` and
   `-T, --all-tags`:
   
   `git checkout master`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `git status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status -c -a -T`{{execute}}
   
   `dvc fetch -a -T`{{execute}}

   `dvc status -c -a -T`{{execute}}

   Now the cache contains all the data files that are on the remote
   storage.
