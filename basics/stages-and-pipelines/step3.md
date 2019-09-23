# Reproduce the pipeline

We can rerun the stages of a pipeline with `dvc repro`.

1. Normally it will try to reproduce recursively all the dependencies
   of the given stage as well:

   `dvc repro stage3.dvc`{{execute}}
   
   `dvc repro stage2.dvc`{{execute}}
   
   `dvc repro stage1.dvc`{{execute}}
   
   `dvc repro data1.txt.dvc`{{execute}}
   
   Notice that all the steps are skipped. Since neither the
   dependencies, nor the command has changed, there is no point in
   running the command again, because the outputs would be the same,
   and we already have the outputs (and even we have stored them in
   cache). This is an important optimization when the stage takes a
   long time to run (as often is the case in DS/ML projects).
   
   `dvc status`{{execute}}
   
   `dvc remove stage*.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro stage3.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc repro stage3.dvc`{{execute}}
   
2. We can tell `dvc repro` to re-execute the commands anyway, even if
   nothing has changed, using the option `-f, --force`:
   
   `dvc repro stage3.dvc --dry`{{execute}}
   
   `dvc repro stage3.dvc -f --dry`{{execute}}
   
   `dvc repro stage2.dvc -f --dry`{{execute}}
   
   `dvc repro stage1.dvc -f --dry`{{execute}}
   
   `dvc repro data1.txt.dvc -f --dry`{{execute}}
   
   `dvc repro stage3.dvc -f`{{execute}}
   
   The option `--dry` shows what commands will run, without actually
   running them.
   
3. The option `-i, --interactive` makes it stop and ask before running
   each stage:
   
   `dvc repro stage3.dvc -i --dry`{{execute}}

   `dvc repro stage3.dvc -fi --dry`{{execute}}

   `dvc repro stage3.dvc -fi`{{execute}}
   
   With the option `--downstream` we can run the following stages,
   instead of the previous ones, with the option `-s, --single-item`
   only the given stage, and with the option `-p, --pipeline` the
   whole pipeline where the given stage belongs:
   
   `dvc repro stage1.dvc`{{execute}}
   
   `dvc repro stage1.dvc --downstream`{{execute}}

   `dvc repro stage1.dvc -s`{{execute}}

   `dvc repro stage1.dvc -p`{{execute}}

4. If a stage is locked, its dependencies will not be reproduced
   (therefore the command of the stage will not be re-executed):

   `dvc repro stage3.dvc`{{execute}}
   
   `dvc lock stage1.dvc`{{execute}}
   
   `cat stage1.dvc`{{execute}}
   
   Notice the field `locked: true`.
   
   `dvc repro stage3.dvc`{{execute}}

   `dvc repro stage3.dvc -f --dry`{{execute}}

   `dvc repro stage3.dvc -f`{{execute}}

   Let's unlock it again:
   
   `dvc unlock stage1.dvc`{{execute}}
   
   `cat stage1.dvc`{{execute}}
   
   `dvc repro stage3.dvc`{{execute}}

5. A locked stage will not be checked by `dvc status`:
   
   `rm data2.txt`{{execute}}
   
   `dvc status stage1.dvc`{{execute}}
   
   `dvc lock stage1.dvc`{{execute}}
   
   `dvc status stage1.dvc`{{execute}}
   
   `dvc unlock stage1.dvc`{{execute}}
   
   `dvc status stage1.dvc`{{execute}}
   
   `dvc checkout data2.txt.dvc`{{execute}}
   
   `dvc status stage1.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `git status`{{execute}}
