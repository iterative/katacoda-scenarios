# Using a script to build pipelines

In the previous steps we have used some long `dvc run` commands, with
lots of options, to define stages. Sometimes we also had to redefine
some stages in order to fix or improve something. Doing all this
manually is long and tedious and error-prone. The recommended Linux
practice in such cases is to record all the commands in a bash script,
which can then be used to build the whole pipeline at once.

Some of the benefits of this approach are these:
    - Typing mistakes while building the pipeline are avoided.
    - Modification of the pipeline becomes easier and consistent (for
      example using find/replace).
    - Building pipelines becomes flexible (for example bash variables
      can be used).
    - Pipelines become reusable (other projects can copy/paste and
      customize them)


1. Let's see an example script that contains the commands we have seen
   so far for building the pipeline:
   
   `less /usr/local/bin/build-pipeline.sh`{{execute}}
   
   ```
   cat /usr/local/bin/build-pipeline.sh \
     | highlight -S bash -O xterm256 \
     | less -r
   ```{{execute}}
   
2. Actually this script takes as parameter a word like `diff`, `zip`,
   etc. and builds a pipeline that finds the commands that contain
   that word. This pipeline is built in a directory with the same name
   as the given word. Let's try it.
   
   ```
   build-pipeline.sh zip 2>&1 \
     | highlight -S bash -O xterm256 \
     | less -r
   ```{{execute}}
   
   `ls`{{execute}}
   
   `ls zip/`{{execute}}
   
   `dvc status zip/*.dvc`{{execute}}
   
   `dvc repro zip/stage3.dvc`{{execute}}
   
   `dvc repro zip/stage3.dvc`{{execute}}

   `dvc status zip/*.dvc`{{execute}}

   `ls zip/`{{execute}}
   
   `cat zip/result.txt`{{execute}}
   
   `dvc metrics show -R zip/`{{execute}}
   
3. Build another pipeline for the word `diff` in the directory
   `diff/`:

   ```
   build-pipeline.sh diff 2>&1 \
     | highlight -S bash -O xterm256 \
     | less -r
   ```{{execute}}

   `ls`{{execute}}
   
   `ls diff/`{{execute}}
   
   `dvc status diff/*.dvc`{{execute}}
   
   `dvc repro diff/stage3.dvc`{{execute}}
   
   `dvc repro diff/stage3.dvc`{{execute}}

   `dvc status diff/*.dvc`{{execute}}
   
   `ls diff/`{{execute}}
   
   `cat diff/result.txt`{{execute}}
   
   `dvc metrics show -R diff/`{{execute}}

   `dvc metrics show`{{execute}}
   
   `dvc pipeline show zip/stage3.dvc --ascii`{{execute}}
