# Ignoring a .dvc file

1. Let's create and track another data file:

   `mkdir dir`{{execute}}
   
   `echo data1 > dir/data1`{{execute}}
   
   `dvc add dir/data1`{{execute}}
   
   `tree`{{execute}}
   
   `echo 123 > dir/data1`{{execute}}

   `dvc status`{{execute}}
   
2. Let's see what happens if we ignore this data file:
   
   `echo dir/data1 > .dvcignore`{{execute}}
   
   `cat .dvcignore`{{execute}}
   
   `dvc status`{{execute}}
   
   DVC is still checking it, because it checks the status of the
   tracking file `dir/data1.dvc`.
   
3. Let's try ignoring the tracking file `dir/data1.dvc`:
   
   `echo dir/data1.dvc > .dvcignore`{{execute}}
   
   `cat .dvcignore`{{execute}}
   
   `dvc status`{{execute}}
   
   This time it does not check the ignored tracking file.
   
4. Let's try ignoring `data.dvc`:

   `echo data.dvc >> .dvcignore`{{execute}}
   
   `cat .dvcignore`{{execute}}
   
   `dvc status`{{execute}}

   If we remove `.dvcignore` it will start checking them again:

   `rm .dvcignore`{{execute}}
   
   `dvc status`{{execute}}

5. We can also ignore a stage file:

   ```
   dvc run \
       -f stage.dvc \
       -o dir/data2 \
       'echo data2 > dir/data2'
   ```{{execute}}
   
   `dvc status`{{execute}}
   
   `echo stage.dvc > .dvcignore`{{execute}}
   
   `cat .dvcignore`{{execute}}
   
   `dvc status`{{execute}}
   
   We see that now DVC ignores (does not check) `stage.dvc`.
   
   `rm .dvcignore`{{execute}}
   
   `dvc status`{{execute}}
