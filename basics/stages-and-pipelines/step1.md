# Build a simple pipeline

A pipeline is a series of processes, where the output from one process
goes as input to another process, until a final result is produced. As
an example, consider this Linux pipeline, which finds the commands
that contain 'diff' in their name:

`ls /bin /usr/bin | sort -u | grep diff`{{execute}}

`ls /bin /usr/bin | sort -u | grep diff | wc -l`{{execute}}

For the sake of simplicity, let's build a DVC pipeline that does the
same thing.

1. Initialize an example project:

   `mkdir proj1`{{execute}}
   
   `cd proj1/`{{execute}}
   
   `git init`{{execute}}
   
   `dvc init -q`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
   `git status`{{execute}}
   
   `git commit -m 'Initialize DVC'`{{execute}}

2. Create data files:

   `ls /bin > data1.txt`{{execute}}
   
   `head data1.txt`{{execute}}
   
   `less data1.txt`{{execute}}
   
   `ls /usr/bin > data2.txt`{{execute}}

   `dvc add data1.txt data2.txt`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
   `dvc status`{{execute}}
   
   `git status`{{execute}}

3. Create a stage (process) that concatenates these two data files
   into a single one:
   
   ```
   dvc run \
       -f stage1.dvc \
       -d data1.txt \
       -d data2.txt \
       -o joint-list.txt \
       'cat data1.txt data2.txt > joint-list.txt'
   ```{{execute}} 
   
   The command `dvc run` executes the command that is given to it (in
   this case `'cat data1.txt data2.txt > joint-list.txt'`).
   
   The option `-o joint-list.txt` tells it that the output of the
   command will be saved on the file `joint-list.txt`.
   
   After the command is finished and the output is generated, a copy
   of the output will be stored in the cache automatically.
   
   The options `-d data1.txt` and `-d data2.txt` tell it that these
   files are dependencies of this stage (inputs of the command). They
   have been already stored in cache with `dvc add`.
   
   The option `-f stage1.dvc` tells it to save all the information
   about running this stage (dependencies, outputs, command, etc.) on
   the file `stage1.dvc`. DVC will need this information when it has
   to rerun this stage in order to reproduce the results (outputs).
   
   `cat stage1.dvc`{{execute}}
   
   `cat data1.txt.dvc`{{execute}}
   
   As you see, the internal structure of a stage file (`stage1.dvc`)
   is very similar to that of a data-tracking file
   (`data1.txt.dvc`). They both have the field `outs:` that stores the
   output meta-data, but a stage file also has a field `deps:` that
   stores the meta-data of the dependencies, and a field `cmd:` that
   stores the command.
   
4. Create a stage that sorts the list:

   ```
   dvc run \
       -f stage2.dvc \
       -d joint-list.txt \
       -o sorted-list.txt \
       --no-commit \
       'sort joint-list.txt > sorted-list.txt'
   ```{{execute}}
   
   `dvc status`{{execute}}
   
   The option `--no-commit` tells the command not to store in cache
   the resulting output just yet. We can store it later with `dvc commit`.
   This may be useful for example in case that we are not sure that
   the command produces the right output, so we may have to try it
   several times until we get it right. Meanwhile we don't want to fill
   the cache with garbage (useless data).
   
   In our example, we have actually forgotten the option `-u, --unique`
   of `sort`, which outputs a single line if there are multiple identical
   ones. Let's fix it by recreating this stage:
   
   ```
   dvc run \
       -f stage2.dvc \
       -d joint-list.txt \
       -o sorted-list.txt \
       --no-commit \
       'sort --unique joint-list.txt > sorted-list.txt'
   ```{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc commit stage2.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
    Since we are using for the stage the same name (`stage2.dvc`) as
    an existing stage, it asks for confirmation before overwriting
    it. We can suppress this confirmation using the option
    `--overwrite-dvcfile`.

5. Create a stage that filters the lines that contain `diff` and saves
   them on `result.txt`:

   ```
   dvc run \
       -f stage3.dvc \
       -d sorted-list.txt \
       -O result.txt \
       --no-exec \
       'grep diff sorted-list.txt > result.txt'
   ```{{execute}}
   
   `cat stage3.dvc`{{execute}}
   
   `ls result.txt`{{execute}}
   
   `dvc status`{{execute}}

   The option `--no-exec` tells to `dvc run` to not execute the
   command just yet. We can execute it later with `dvc repro`.  So,
   only the stage file is created, but no command executed and no
   output generated. As a consequence, no checksums are saved on
   `stage3.dvc` (they will be generated automatically when the stage
   is reproduced).
   
   This option (`--no-exec`) may be useful in cases when we want to
   build a pipeline first, and then run all the stages at once.
   
   The option `-O, --outs-no-cache` denotes an output file, same as
   `-o`, but this output file is not to be cached (neither when the
   stage is created, nor when it is reproduced). This is marked by the
   field `cache: false` in the stage file `stage3.dvc`.
   
   Not caching outputs might be useful in cases when they are small
   and suitable to be tracked by GIT, or if they are unpredictable or
   temporary and not worth to be stored or shared with other people.
   
   Let's create the stage again:

   ```
   dvc run \
       -f stage3.dvc \
       -d sorted-list.txt \
       -o result.txt \
       -M count.txt \
       --overwrite-dvcfile \
       'grep diff sorted-list.txt > result.txt \
        && cat result.txt | wc -l > count.txt'
   ```{{execute}}
   
   This time we are allowing it to execute the command (no `--no-exec`
   option), and telling it to overwrite the existing stage file
   without asking for confirmation (`--overwrite-dvcfile`).
   
   Notice that this time the command generates `count.txt` as well
   (besides `result.txt`), and we have marked it as a _metrics_ output
   with the option `-M count.txt`.
   
   Metrics files are usually small and just contain some numbers about
   performance (in our example it just contains the number of the
   results found). So, usually they are better saved in Git (rather
   than in the DVC cache). The option `-M, --metrics-no-cache` does
   just that.  If we wanted to save in cache anyway, we could have
   used the option `-m, --metrics`.
   
   `cat stage3.dvc`{{execute}}
   
   Notice the fields `metric: true` and `cache: false` on the output
   `count.txt`.
   
   `cat result.txt | grep diff`{{execute}}
   
   `cat count.txt`{{execute}}
   
   `cat result.txt | wc -l`{{execute}}

6. Finally let's check the current state of the project and save it by
   committing everything to GIT:
   
   `ls -al`{{execute}}
   
   `ls *.txt`{{execute}}

   `ls *.dvc`{{execute}}
   
   `ls stage*.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `git status`{{execute}}
   
   `cat .gitignore`{{execute}}
   
   `git add .`{{execute}}
   
   `git status`{{execute}}
   
   `git commit -m 'First pipeline'`{{execute}}
   
   `git tag pipeline-1`{{execute}}
   
   `git tag`{{execute}}
   
   `dvc metrics show`{{execute}}
   
   `dvc pipeline show stage3.dvc`{{execute}}
   
