# Importing data

In a previous step we have used `dvc get` to download a DVC data file
from a Git repository. If we want to get an updated copy of that file
we have to rerun the same command again. However if some time has
passed, we might even forget where did we get that file from, or even
that it was downloaded from another project. A better alternative
would be to use `dvc import`.

1. Import a data file from an example project:
   
   ```
   dvc import \
       https://github.com/iterative/dataset-registry \
       get-started/data.xml
   ```{{execute}}
   
   `git status`{{execute}}
   
   `cat .gitignore`{{execute}}
   
   `cat data.xml.dvc`{{execute}}
   
2. How it works:

   Same as `dvc get` it downloads the file `data.xml`, but it also
   creates the tracking file `data.xml.dvc`, which contains among
   others the url of the Git repository and the revision of the file
   that was downloaded.

   Note that the data file itself (`data.xml`) is not retrieved from
   the Git repository (because data files are not stored on Git).
   Instead it is retrieved from the default data storage of the
   project (the one that is listed on `.dvc/config` of the example
   project).

3. Update the imported file:

   `dvc status data.xml.dvc`{{execute}}
   
   `dvc update data.xml.dvc`{{execute}}
   
   This DVC file is locked, so its data file can be updated only with
   `dvc update`. This is done when we want to check whether there is
   any new version of the imported file, and if yes download it.
   
4. We are not going to use this file in the rest of the tutorial, so
   let's remove it again:
   
   `rm data.xml data.xml.dvc .gitignore`{{execute}}
   
