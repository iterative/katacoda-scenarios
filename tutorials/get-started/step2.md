# Data tracking

1. Let's get a data file from an example project:

   `mkdir data`{{execute}}
   
   ```
   dvc get \
       https://github.com/iterative/dataset-registry \
       get-started/data.xml \
       -o data/data.xml
   ```{{execute}}

   `ls -lh data/`{{execute}}
   
   The command `dvc get` is like `wget`, but it is used to download
   data artifacts from DVC projects which are hosted on Git
   repositories.
   
   **Note:** The RAM available on the tutorial environment is not
   enough to handle a data file of this size, so let's make it
   smaller:
   
   `cat data/data.xml | wc -l`{{execute}}
   
   `head -n 12000 data/data.xml > data/data.xml.1`{{execute}}
   
   `mv data/data.xml.1 data/data.xml`{{execute}}
   
   `cat data/data.xml | wc -l`{{execute}}
   
2. Track it with `dvc add`:

   `dvc add data/data.xml`{{execute}}
   
   `cat data/.gitignore`{{execute}}
   
   DVC has listed `data.xml` on `.gitignore` to make sure that we
   don't commit it to Git.
      
   `tree .dvc/cache`{{execute}}

   `cat data/data.xml.dvc`{{execute}}
   
   `dos2unix data/data.xml`{{execute}}
   
   `md5sum data/data.xml`{{execute}}

3. How it works:

   The command `dvc add` saves a copy of the file in the DVC cache and
   creates a tracking file with the extension `.dvc`. In
   `data.xml.dvc` it keeps also the MD5 hash of the data file
   `data.xml`, and this effectively creates a pointer to the copy that
   is saved in the cache, since it is named after this MD5 hash.
   
   If the content of the `data.xml` is changed, its MD5 hash will
   change as well and will be different from what is recorded on
   `data.xml.dvc`. This would allow DVC to detect the change.

4. Commit to Git:

   `git add data/.gitignore data/data.xml.dvc`{{execute}}
   
   `git commit -m "Add raw data to project"`{{execute}}

   When the file `data/data.xml` is changed, DVC will save its new
   version to cache again and update `data/data.xml.dvc` to match the
   new hash of the data file. Then the new version of
   `data/data.xml.dvc` will be committed to Git again.
   
   This way we keep in Git a history of the `.dvc` file, and each
   version in this history is linked to a version of the data file in
   the DVC cache. This linking or connection is done through the MD5
   hash of the cached file, which is also its name on the cache.
