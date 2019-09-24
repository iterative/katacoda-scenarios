# Show the pipeline

1. We can view the pipeline that we have constructed like this:

   `dvc pipeline show stage3.dvc`{{execute}}
   
   `dvc pipeline show stage2.dvc`{{execute}}

   `dvc pipeline show stage1.dvc`{{execute}}

   This command takes a stage file as argument and shows recursively
   all the dependencies of this stage.
   
   We can add the `--tree` option to display it in a structured way:
   
   `dvc pipeline show stage3.dvc --tree`{{execute}}
   
   `dvc pipeline show stage2.dvc --tree`{{execute}}

   `dvc pipeline show stage1.dvc --tree`{{execute}}

2. Instead of stages, it can show commands or outputs:

   ```
   dvc pipeline \
       show stage3.dvc --commands
   ```{{execute}}
   
   `dvc pipeline show stage2.dvc -c`{{execute}}

   `dvc pipeline show stage1.dvc -c`{{execute}}

   `dvc pipeline show stage3.dvc --outs`{{execute}}
   
   `dvc pipeline show stage2.dvc -o`{{execute}}
   
   `dvc pipeline show stage1.dvc -o`{{execute}}
   
3. With the option `--dot` it can output a 
   [DOT graph](https://en.wikipedia.org/wiki/DOT_(graph_description_language)).
   However the package `pydot` should be installed first:
   
   `pip3 install pydot`{{execute}}
   
   `dvc pipeline show stage3.dvc --dot`{{execute}}
   
   ```
   dvc pipeline show \
       stage3.dvc --dot --commands
   ```{{execute}}
   
   ```
   dvc pipeline show \
       stage3.dvc --dot --outs
   ```{{execute}}
   
4. Finally, with the option `--ascii` the graph will be displayed in
   ascii format:
   
   ```
   dvc pipeline show \
       stage3.dvc --ascii
   ```{{execute}}
   
   (Press 'q' to quit.)
   
   ```
   dvc pipeline show \
       stage3.dvc --ascii --commands
   ```{{execute}}
   
   ```
   dvc pipeline show \
       stage3.dvc --ascii --outs
   ```{{execute}}
   
   ```
   dvc pipeline show \
       stage3.dvc --ascii -o | less
   ```{{execute}}
