# Simple pipeline example

A pipeline is a series of processes, where the output from one process
goes as input to another process, until a final result is produced. As
an example, consider this Linux pipeline, which finds the commands
that contain 'zip' in their name:

`ls /bin /usr/bin | sort -u | grep zip`{{execute}}

For the sake of simplicity, let's build a DVC pipeline that does the
same thing.

1. Initialize an example project:

   `mkdir pipe1`{{execute}}
   
   `cd pipe1/`{{execute}}
   
   `dvc init --no-scm -q`{{execute}}
      
   `ls /bin > ls1.txt`{{execute}}
   
   `ls /usr/bin > ls2.txt`{{execute}}
   
   `dvc add ls1.txt ls2.txt`{{execute}}
   
   `tree -a`{{execute}}

2. Create a stage (process) that concatenates these two lists into
   one:
   
   ```
   dvc run \
       -f cat.dvc \
       -d ls1.txt \
       -d ls2.txt \
       -o list.txt \
       'cat ls1.txt ls2.txt > list.txt'
   ```{{execute}}
   
   The command `dvc run` executes the command that is given to it (in
   the last line, in this case `'cat ls1.txt ls2.txt > list.txt'`).
   
   The option `-o list.txt` tells it that the output of the command
   will be saved on the file `list.txt`. After the command is finished
   and the output is generated, it will store a copy of the output in
   the cache.
   
   The options `-d ls1.txt` and `-d ls2.txt` tell it that these files
   are dependencies (inputs) of the stage (process). They have been
   already stored in cache with `dvc add`.
   
   The option `-f cat.dvc` tells it to save all the information about
   running this stage (dependencies, outputs, and command) on the file
   `cat.dvc`. DVC will need this information when it has to re-run
   this stage and to re-produce the results (outputs).
   
   `cat cat.dvc`{{execute}}
   
   You see the field `cmd:` that stores the command, the field `outs:`
   that stores the output meta-data, and the field `deps:` that stores
   the meta-data of the dependencies.
   
3. Create the other stages:

   ```
   dvc run \
       -f sort.dvc \
       -d list.txt \
       -o sorted.txt \
       'sort -u list.txt > sorted.txt'
   ```{{execute}}

   ```
   dvc run \
       -f grep.dvc \
       -d sorted.txt \
       -o result.txt \
       'grep zip sorted.txt > result.txt'
   ```{{execute}}

   `cat result.txt`{{execute}}
   
   `ls *.dvc`{{execute}}
   
   `cat sort.dvc`{{execute}}
   
   `cat grep.dvc`{{execute}}
   
   `ls *.txt`{{execute}}
   
   `tree -a`{{execute}}
   
   `dvc status`{{execute}}
   
   Note that besides running the given commands, DVC has created as
   well the stage files `sort.dvc` and `grep.dvc`. The outputs of the
   commands (`sorted.txt` and `result.txt`) have been stored in cache,
   so everything is up to date.

4. Let's visualize the pipeline that we have constructed:

   ```
   dvc pipeline \
       show grep.dvc --tree
   ```{{execute}}
   
   `pip3 install pydot`{{execute}}

   ```
   dvc pipeline \
       show grep.dvc --dot
   ```{{execute}}
   
   ```
   dvc pipeline \
       show grep.dvc --dot --commands
   ```{{execute}}
   
   ```
   dvc pipeline \
       show grep.dvc --dot --outs
   ```{{execute}}
   
   ```
   dvc pipeline \
       show grep.dvc --ascii
   ```{{execute}}
   
   (Press 'q' to quit.)
   
   ```
   dvc pipeline \
       show grep.dvc --ascii -c
   ```{{execute}}
   
   ```
   dvc pipeline \
       show grep.dvc --ascii -o
   ```{{execute}}
   
   ```
   dvc pipeline \
       show grep.dvc --ascii | less
   ```{{execute}}

5. With `dvc repro` we can run the stages (steps) of this pipeline
   again:
   
   `ls *.dvc`{{execute}}
   
   `dvc repro ls1.txt.dvc`{{execute}}
   
   `dvc repro cat.dvc`{{execute}}
   
   `dvc repro sort.dvc`{{execute}}
   
   `dvc repro grep.dvc`{{execute}}
   
   By default `dvc repro` tries to re-run all the previous stages as
   well, besides the given stage.
   
   However notice that all the steps are skipped. Since neither the
   dependencies, nor the command has changed, there is no point in
   running the command again, because the outputs would be the same,
   and we already have the outputs (and even we have stored them in
   cache). This is an important optimization when the stage takes a
   long time to run (as often is the case in DS/ML projects).
   
   But we can tell it to re-run the commands anyway, even if nothing
   has changed, using the option `-f, --force`:
   
   `dvc repro grep.dvc --dry`{{execute}}
   
   `dvc repro grep.dvc -f --dry`{{execute}}
   
   `dvc repro grep.dvc -f`{{execute}}
   
   `dvc repro grep.dvc -f -i`{{execute}}

   Notice that the option `--dry` shows what commands will run,
   without actually running them, and the option `-i, --interactive`
   makes it stop and ask for each stage.
   
   With the option `--downstream` we can run the following stages,
   instead of the previous ones, with the option `-s, --single-item`
   only the given stage, and with the option `-p, --pipeline` the
   whole pipeline where the given stage belongs:
   
   `dvc repro cat.dvc`{{execute}}
   
   `dvc repro cat.dvc --downstream`{{execute}}

   `dvc repro cat.dvc -s`{{execute}}

   `dvc repro cat.dvc -p`{{execute}}

