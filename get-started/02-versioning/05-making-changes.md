# Making Changes

Let's make the dataset smaller. It's not what we'd usually do. In general, we
want more data, but since there are limitations in this platform, we need to do
this to run the training later:

```
head -n 12000 data/data.xml > data/data.xml.1
mv data/data.xml.1 data/data.xml
```{{execute}}

We check the status of the project:

`dvc status`{{execute}}

Run `dvc add` to save its new version to cache and update `data/data.xml.dvc`.

`dvc add data/data.xml`{{execute}}

It updates the hash value in the corresponding `dvc` file: 

`git diff`{{execute}}

Commit the changed hash value to track the version of the file:

`git commit -a -m "Dataset updates"`{{execute}}

Push the new version of the file to the default remote: 

`dvc push`{{execute}}

So, each version of `data/data.xml.dvc` in the Git history is linked to a
version of the data file in the DVC cache.