# Fetching data for specific stages only

We usually want to be conservative when downloading data (download no
more than it's needed for the time being). We have seen that `dvc
fetch` is by default conservative. However it also allows us to
further narrow down the amount of data that is to be downloaded. We
can do this by passing it specific stages as arguments, and it will
download only the data related to these stages.

1. First let's delete the data and the cache that were downloaded on
   the previous steps:
   
   `dvc remove *.dvc data/*.dvc`{{execute}}
   
   `rm -rf .dvc/cache/`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}
   
2. Let's download only the data required by the file
   `data/data.xml.dvc` (which is the first stage in the pipeline):
   
   `cat data/data.xml.dvc | grep path:`{{execute}}
   
   `dvc status data/data.xml.dvc`{{execute}}
   
   `dvc status data/data.xml.dvc --cloud`{{execute}}
   
   `dvc fetch data/data.xml.dvc`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `dvc status data/data.xml.dvc -c`{{execute}}

   `dvc status data/data.xml.dvc`{{execute}}
   
   `dvc checkout data/data.xml.dvc`{{execute}}

   `dvc status data/data.xml.dvc`{{execute}}
   
3. We can give more than one argument as targets for `dvc fetch`:

   `cat data/data.xml.dvc prepare.dvc | grep path:`{{execute}}
   
   `dvc status data/data.xml.dvc prepare.dvc`{{execute}}
   
   `dvc status data/data.xml.dvc prepare.dvc -c`{{execute}}
   
   `dvc fetch data/data.xml.dvc prepare.dvc`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
   `dvc status data/data.xml.dvc prepare.dvc -c`{{execute}}

   `dvc status data/data.xml.dvc prepare.dvc`{{execute}}
   
   `dvc checkout data/data.xml.dvc prepare.dvc`{{execute}}

   `dvc status data/data.xml.dvc preoare.dvc`{{execute}}

4. For `data/data.xml.dvc` it is OK to download only its own data
   files, since it is the first stage of the pipeline. However usually
   we need the dependencies of a stage as well, in order to reproduce
   it, and then the dependencies of the dependencies, and so on. This
   is what the option `-d, --with-deps` does, when some `.dvc` files
   are specified as targets.
   
   `dvc status train.dvc --with-deps`{{execute}}
   
   `dvc status train.dvc --with-deps --cloud`{{execute}}
   
   `dvc fetch train.dvc --with-deps`{{execute}}
   
   `dvc status train.dvc -dc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro train.dvc`{{execute}}

   As you see, all the data for the dependencies of `train.dvc` has
   been downloaded as well, so its reproduction runs instantly.
