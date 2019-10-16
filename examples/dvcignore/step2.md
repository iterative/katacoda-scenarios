# Ignoring files inside a dataset

1. Let's ignore a file of `data/` and then track this directory with
   DVC:

   `echo data/data1 > .dvcignore`{{execute}}
   
   `cat .dvcignore`{{execute}}
   
   `dvc add data`{{execute}}
   
   `tree -a`{{execute}}
   
   `cat data.dvc`{{execute}}
   
   ```
   cat .dvc/cache/54/40cb5e4c57ab54af68127492334a23.dir \
       | python -m json.tool
   ```{{execute}}

   As we can see, `data1` has been ignored, only `data2` has been
   saved to cache.
   
2. Now, let's modify `data/data1` and see if it affects `dvc status`:

   `dvc status`{{execute}}
   
   `echo 123 > data/data1`{{execute}}
   
   `dvc status`{{execute}}

   The file is completely ignored by DVC.
   
3. If we modify instead `data/data2`, the change will be detected:

   `echo 123 > data/data2`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc commit data.dvc`{{execute}}
   
   `dvc status`{{execute}}

4. If we rename (move) the ignored data inside the directory, it will
   be detected as a new file in the tracked data directory:

   `cat .dvcignore`{{execute}}
   
   `ls data/`{{execute}}
   
   `mv data/{data1,data3}`{{execute}}
   
   `ls data/`{{execute}}
   
   `dvc status`{{execute}}
