Let's make the dataset smaller. It's not what would you usually do (usually we
want more data), but since there are some RAM limitations to this online
platform we have to do this to being able to run training later:

```
head -n 12000 data/data.xml > data/data.xml.1
mv data/data.xml.1 data/data.xml
```{{execute}}

We check the status of the project:

`dvc status`{{execute}}

When the file `data/data.xml` is changed, DVC can detect it by analyzing the
corresponding `.dvc` file. Run `dvc add` to save its new version to cache and
update `data/data.xml.dvc` to match the new hash of the data file:

`dvc add data/data.xml`{{execute}}

It updates the MD5 hash value in the corresponding `dvc` file: 

`git diff`{{execute}}

We can commit the changed hash value to track the version of the file:

`git commit -a -m "Dataset updates"`{{execute}}

We push the new version of file to the default remote: 

`dvc push`{{execute}}

So, each version of `data/data.xml.dvc` in Git history is linked to a version
of the data file in the DVC cache. This connection is done through
the MD5 hash of the cached file that is also its name on the cache.
