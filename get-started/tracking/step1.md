# Get a data file

Let's get a data file from an example project:

`mkdir data`{{execute}}

```
dvc get \
    https://github.com/iterative/dataset-registry \
    get-started/data.xml \
    -o data/data.xml
```{{execute}}

`ls -lh data/`{{execute}}

The command `dvc get` is like `wget`, but it is used to download data
artifacts from DVC projects which are hosted on Git repositories.

**Note:** The RAM available on the tutorial environment is not enough
to handle a data file of this size, so let's make it smaller:

`cat data/data.xml | wc -l`{{execute}}

`head -n 12000 data/data.xml > data/data.xml.1`{{execute}}

`mv data/data.xml.1 data/data.xml`{{execute}}

`cat data/data.xml | wc -l`{{execute}}
