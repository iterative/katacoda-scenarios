# More realistic examples

Let's see some more realistic examples with `dvc get` and `dvc import`.

1. Let's get the model file from the [get-started example
   repo](https://github.com/iterative/example-get-started).
   
   `rm *.*`{{execute}}
   
   ```
   git_repo=https://github.com/iterative/example-get-started
   dvc get $git_repo model.pkl
   ```{{execute}}
   
   `ls -alh`{{execute}}

   If you look at the [Git
   repo](https://github.com/iterative/example-get-started) you cannot
   find there the file `model.pkl`, because data files are not stored
   on Git.
   
   In order to download this file, first of all we need to know what
   is the url of the **default data storage** of the DVC project. We
   can find on
   [.dvc/config](https://github.com/iterative/example-get-started/blob/master/.dvc/config)
   that it is `https://remote.dvc.org/get-started`).
   
   We also need to know the MD5 hash of the file that we want to
   download.  We can find on
   [train.dvc](https://github.com/iterative/example-get-started/blob/master/train.dvc)
   that it is `662eb7f64216d9c2c1088d0a5e2c6951`.
   
   Now we can download it with `wget` like this:
   
   ```
   storage='https://remote.dvc.org/get-started'
   path='66/2eb7f64216d9c2c1088d0a5e2c6951'
   wget -O model.pkl.1 $storage/$path
   ```{{execute}}
   
   `ls -alh`{{execute}}

   `diff model.pkl model.pkl.1`{{execute}}
   
   The command `dvc get` automates all these steps for us.
   
2. Let's get a previous version of the file `model.pkl`:

   ```
   git_repo=https://github.com/iterative/example-get-started
   dvc get \
       $git_repo model.pkl \
       --rev=7-train \
       --out model.monograms.pkl
   ```{{execute}}
   
   To specify the revision we are using the tag `7-train`.
   
   `ls -alh`{{execute}}
   
   `diff model.pkl model.monograms.pkl`{{execute}}

3. Now let's try to _import_ the file `data/data.xml` from the same
   Git repo:
   
   `rm -rf *.* .dvc/cache`{{execute}}
   
   `dvc status`{{execute}}
   
   ```
   git_repo=https://github.com/iterative/example-get-started
   dvc import $git_repo data/data.xml
   ```{{execute}}
   
   `tree -a`{{execute}}
   
   `cat data.xml.dvc`{{execute}}
   
   It has also created a `.dvc` file and has saved the downloaded file
   to cache.

   Notice the `url:` and `rev_lock:` fields that are used to specify
   the origin and version of the dependency. When we do a `dvc update`,
   the field `rev_lock:` is updated.
   
   Same as `dvc get`, the data file is not downloaded from the git
   repo itself, and the details for downloading it can be found on
   [data/data.xml.dvc](https://github.com/iterative/example-get-started/blob/master/data/data.xml.dvc)
   and on
   [.dvc/config](https://github.com/iterative/example-get-started/blob/master/.dvc/config).
   
   Also same as `dvc get`, we can import a different version with the
   option `--rev`, and we can save it on a different file name with
   the option `-o, --out`.
