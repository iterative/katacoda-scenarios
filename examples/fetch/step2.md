# Default behavior

1. Notice that this project comes with a predefined HTTPS _remote
   storage_ (which is called **storage**):
   
   `dvc remote list`{{execute}}
   
   `cat .dvc/config`{{execute}}
   
2. The data itself is not stored on GitHub but on the remote storage
   (https://remote.dvc.org/get-started). So, the project does not have
   any data yet, and the cache is empty as well. Let's confirm it:
   
   `tree .dvc/cache`{{execute}}
   
   `dvc status`{{execute}}

   `dvc status --cloud`{{execute}}
   
   The status `deleted:` shows that these data files are available on
   the remote storage, but are missing from the local cache.
   
3. With the command `dvc fetch` we can download the missing data files
   from the remote storage to the local cache:
   
   `dvc fetch`{{execute}}
   
   `tree .dvc/cache`{{execute}}
   
   `dvc status --cloud`{{execute}}
   
   Now the cache and the remote storage are in sync.
      
4. However the data are not yet in the project:

   `dvc status`{{execute}}

   In this case we need a `dvc checkout` to get the data from the
   cache to the project:
   
   `dvc checkout`{{execute}}
   
   `dvc status`{{execute}}
