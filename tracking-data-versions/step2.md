# Tracking data versions with GIT

As we saw in the previous step, in order to keep track of different
versions of `file.txt` (which are stored on the cache), we have to
keep track of the different versions of `file.txt.dvc`. Each of these
versions of `file.txt.dvc` connects `file.txt` to one of its versions
that are stored on the cache (through the checksum of the cached
version, which is stored on `file.txt.dvc`).

The way that we used to keep track of the versions of `file.txt.dvc`
is kind of primitive, tedious, error-prone, and doesn't scale well.
Since `file.txt.dvc` is just a small text file, while not use GIT to
keep track of its versions? GIT offers a lot of simplicity, comfort
and flexibility

1. First let's initialize a git repository and a DVC workspace:

   `rm -rf .dvc *`{{execute}}
   
   `git init`{{execute}}

   `dvc init`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
   `cat .dvc/.gitignore`{{execute}}
   
   `git status`{{execute}}
   
   DVC notices the presence of the git repository and automatically
   integrates with it. The first step it takes is to make sure that
   the files that keep its internal state are not tracked by git, as
   well as the cache directory. This is done by listing them on
   `.dvc/.gitignore`. Then this file and `.dvc/config` are added to
   git. Let's commit them:
   
   `git commit -m "Initialize DVC"`{{execute}}
   
   `git status`{{execute}}
   
2. Create a file and add it to DVC:

   `echo 'test 1' > file.txt`{{execute}}
   
   `dvc add file.txt`{{execute}}
   
   `git status`{{execute}}
   
   `cat .gitignore`{{execute}}
   
   The file that we are tracking with DVC is supposed to be a big file
   that is not suitable for being tracked with GIT (that's why we are
   using DVC in the first place). So, we want to make sure that we
   don't ever add and commit it to GIT. That's why DVC adds it
   automatically to `.gitignore`. It also suggests (or reminds) us to
   track `file.txt.dvc` with GIT. Let's do it:
   
   `git add file.txt.dvc .gitignore`{{execute}}
   
   `git commit -m 'Add file.txt to project'`{{execute}}
   
   `git status`{{execute}}
   
   `dvc status`{{execute}}
   
   `tree -a -I .git`{{execute}}

3. Let's change `file.txt` and keep more versions:

   `echo 'test 2' > file.txt`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc commit file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `git status`{{execute}}
   
   `git diff file.txt.dvc`{{execute}}
   
   `git add file.txt.dvc`{{execute}}
   
   `git commit -m 'Change file.txt'`{{execute}}
   
   `git status`{{execute}}
   
   Do it once more:
   
   `echo 'test 3' > file.txt`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc commit file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `git status`{{execute}}
   
   `git add file.txt.dvc`{{execute}}
   
   `git commit -m 'Change file.txt again'`{{execute}}
   
   `git status`{{execute}}
   
   Currently we have three versions of `file.txt` on the DVC cache,
   and three versions of `file.txt.dvc` on GIT:
   
   `tree -a -I .git`{{execute}}
   
   `git log file.txt.dvc`{{execute}}
   
4. Let's get the first version the data file (which was before the
   last 2 commits):
   
   `git checkout HEAD~2`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `cat file.txt`{{execute}}
   
   After we get a previous version of `file.txt.dvc`, DVC is out of
   sync, because the checksum of `file.txt` does not match the one
   that is stored on `file.txt.dvc`. To fix this we ran `dvc checkout`,
   which restores from the cache the version of `file.txt` with the
   correct checksum.
   
   Let's go back to the last version:
   
   `git checkout master`{{execute}}
   
   `dvc checkout`{{execute}}
   
5. If you wish, try yourself to get the previous version of
   `file.txt`, and then go back to the last version.
   
6. In a small git repo it may not be so difficult to go back to a
   certain version by counting the commits, or by using commit
   id-s. But in a normal git repo this becomes quickly unmanageable.
   The recommended way (both by GIT and DVC) for marking versions of
   interest is by using tags and branches. Let's mark the versions of
   `file.txt.dvc` with tags `v1`, `v2`, `v3`, and let's use these tags
   to get a previous version of `file.txt`:
   
   `git tag v3`{{execute}}
   
   `git tag v2 HEAD~1`{{execute}}
   
   `git tag v1 HEAD~2`{{execute}}
   
   `git tag`{{execute}}
   
   `git checkout v1`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `cat file.txt`{{execute}}
   
   Back to the latest version:
   
   `git status`{{execute}}
   
   `git checkout master`{{execute}}
   
   `git status`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `cat file.txt`{{execute}}
 
7. If you run `dvc gc` now, it will leave only one copy of the data
   file on the cache, the one that corresponds with the current data
   file (which has the checksum stored on `file.txt.dvc`). The other
   two will be deleted. If we want to be careful and not delete the
   cached versions related to the tags and branches, we should use the
   options `-a, --all-branches` and `-T, --all-tags`:
   
   `tree -a -I .git`{{execute}}
   
   `dvc gc -a -T`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
   `dvc gc -T`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
   `dvc gc`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
