# Check results and save

1. Show the pipeline:

   ```
   dvc pipeline show \
       evaluate.dvc --ascii
   ```{{execute}}

   ```
   dvc pipeline show \
       evaluate.dvc --ascii -c
   ```{{execute}}
   
   ```
   dvc pipeline show \
       evaluate.dvc --ascii -o
   ```{{execute}}

2. Check the metric:

   `dvc metrics show`{{execute}}
   
3. Save the pipeline:

   `git add .`{{execute}}
   
   `git status`{{execute}}
   
   `git commit -m 'Add tag prediction pipeline (6 stages)'`{{execute}}
   
   We are just saving a snapshot of the `.dvc` files that describe
   data, transformations (stages), and relationships between them.
   The data files themselves are stored in the cache:
   
   `tree .dvc/cache`{{execute}}
