# Cloning a project

Let's assume that person **A** is working on `workspace-a` and person
**B** would like to collaborate with him, on the same project, but
working from `workspace-b`. How can they share their code and data?

1. Let's create first a simple project on `workspace-a`:

   `mkdir workspace-a`{{execute}}
   
   `cd workspace-a/`{{execute}}
   
   `DELAY=0.7 play init-git-repo.sh`{{execute}}
   
   `git status`{{execute}}
   
   `dvc status`{{execute}}
   
   `ls -al`{{execute}}
   
   `tree -a -I .git`{{execute}}

2. Since `workspace-a` is basically Git repository, we can clone it on
   `workspace-b` like this:
   
   `cd ..`{{execute}}
   
   `git clone workspace-a workspace-b`{{execute}}
   
   `cd workspace-b`{{execute}}
   
   `git status`{{execute}}
   
   Notice the message: `Your branch is up to date with
   'origin/master'.`
   
   `git remote -v`{{execute}}
   
   The origin is `workspace-a`. We can synchronize with it by pushing
   and pulling.
   
   `dvc status`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
3. There is a problem. Although we cloned the code, we don't have the
   data in the workspace. Let's fix this by adding the data cache of
   `workspace-a` as a remote data cache for `workspace-b`:
   
   `dvc remote list`{{execute}}
   
   ```
   dvc remote add --default \
       origin ../workspace-a/.dvc/cache
   ```{{execute}}
   
   `dvc remote list`{{execute}}
   
   `git status`{{execute}}
   
   `git diff .dvc/config`{{execute}}
   
   `cat .dvc/config`{{execute}}
   
   `git add .dvc/config`{{execute}}
   
   `git commit -m 'Add a default remote cache'`{{execute}}
   
   Note that the remote data caches of DVC are similar to the remote
   repositories of Git. But be careful because in Git it is the url
   (or path) of the remote repository that you add as a remote, in DVC
   it is the url (or path) of the *cache directory* of the remote
   repository. There are some other differences as well between them
   that we will notice along the way.

4. Let's check the status of the workspace:

   `dvc status`{{execute}}
   
   `dvc status --cloud`{{execute}}
   
   These two commands look very similar but don't be deceived by their
   appearance because they actually do very different things (which is
   obvious by the format of their outputs as well). The first one, as
   we have seen before, shows the state of the data on the workspace,
   compared to the data on the local cache. The second one however
   shows the state of the data on the local cache, compared to the
   data on the remote cache.
   
5. We can see that currently `file.txt` is missing on `workspace-b`,
   and it is not available on the local cache either (indicated by the
   status `deleted:` on the second command). Let's get this file from
   the remote cache:
   
   `dvc pull file.txt.dvc`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
   `dvc status file.txt.dvc`{{execute}}
   
   `dvc status --cloud file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `cat file.txt`{{execute}}
   
   The command `dvc pull` does two things: it downloads first the
   relevant data files from the remote cache to the local cache, then
   it copies them from the local cache to the workspace. Similar to
   Git, it is the same thing as doing a `dvc fetch` (first step),
   followed by a `dvc checkout` (second step).

6. We can also use `dvc push` to upload data from the local cache to
   the remote one:

   `echo 'test 4' > file.txt`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc commit file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status -c`{{execute}}
   
   `dvc push file.txt.dvc`{{execute}}
   
   `dvc status -c`{{execute}}
   
   Notice that `dvc push` is the oposite operation of `dvc fetch`, not
   the oposite of `dvc pull` (the same as in Git).
