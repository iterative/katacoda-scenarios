# Automatic synchronization between DVC and GIT

In the previous steps we saw that whenever we make a `git checkout`,
we also need to make a `dvc checkout`, in order to get the correct
version of the data that corresponds to the current GIT version.

It is possible to automate this step by using GIT hooks. The command
`dvc install` installs such hooks. Let's give it a try.

1. First let's quickly create a workspace with several versions:

   ```
   rm -rf .dvc .git *
   git init
   dvc init -q
   git status
   git commit -m "Initialize DVC"
   ```{{execute}}
   
   ```
   echo 'test 1' > file.txt
   dvc add file.txt
   git add file.txt.dvc .gitignore
   git commit -m 'Add file.txt to project'
   ```{{execute}}
   
   `git tag v1`{{execute}}

   ```
   echo 'test 2' > file.txt
   dvc status
   dvc commit file.txt.dvc
   ```{{execute}}
   
   ```
   git status
   git add file.txt.dvc
   git commit -m 'Change file.txt'
   ```{{execute}}
   
   `git tag v2`{{execute}}

   ```
   echo 'test 3' > file.txt
   dvc status
   dvc commit file.txt.dvc
   ```{{execute}}
   
   ```
   git status
   git add file.txt.dvc
   git commit -m 'Change file.txt again'
   ```{{execute}}
   
   `git tag v3`{{execute}}
   
   Currently we have three versions of `file.txt` on the DVC cache,
   and three versions of `file.txt.dvc` on GIT, each of them marked
   with a tag:
   
   `tree -a -I .git`{{execute}}
   
   `git log file.txt.dvc`{{execute}}
   
   `git tag`{{execute}}
   
2. Now let's install the git hooks and try to switch to different
   versions:
   
   `dvc install`{{execute}}
   
   `cat file.txt`{{execute}}
   
   `git checkout v2`{{execute}}
   
   `cat file.txt`{{execute}}
   
   `git checkout v1`{{execute}}
   
   `cat file.txt`{{execute}}
   
   `git checkout master`{{execute}}
   
   `cat file.txt`{{execute}}
   
   As you see, now we don't have to remember to run `dvc checkout`
   each time that we make a `git checkout`.
   
