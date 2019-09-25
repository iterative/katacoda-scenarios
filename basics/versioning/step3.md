# Using tags and branches

In a small git repo it may not be so difficult to go back to a certain
version by counting the commits, or by using commit id-s. But in a
normal git repo this becomes quickly unmanageable. The recommended way
for marking versions of interest is by using tags and branches.

1. Let's mark the versions of `file.txt.dvc` with tags `v1`, `v2`,
   `v3`:
   
   `git checkout master`{{execute}}
   
   `dvc checkout`{{execute}}

   `git tag v3`{{execute}}
   
   `git tag v2 HEAD~1`{{execute}}
   
   `git tag v1 HEAD~2`{{execute}}
   
   `git tag`{{execute}}
   
2. Let's use these tags to get a previous version of `file.txt`:
   
   `git checkout v1`{{execute}}
   
   `git status`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `cat file.txt`{{execute}}
   
3. Let's go back to the latest version:
   
   `git status`{{execute}}
   
   `git checkout master`{{execute}}
   
   `git status`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc checkout file.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `cat file.txt`{{execute}}

4. If you wish, try yourself to go to version `v2` of the file, and
   then back to the latest version.

5. If you run `dvc gc` now, it will leave only one copy of the data
   file on the cache, the one that corresponds with the current data
   file (which has the checksum stored on `file.txt.dvc`). The other
   two will be deleted. If we want to be careful and not delete the
   cached versions related to the tags and branches, we should use the
   options `-a, --all-branches` and `-T, --all-tags`:
   
   `tree -a -I .git`{{execute}}
   
   `dvc gc -a -T`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
   We told `dvc gc` to skip (not delete) any cached files that are
   marked by any tags or branches, so nothing was deleted.
   
   `dvc gc -T`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
   We told `dvc gc` to skip (not delete) any cached files that are
   marked by any tags, so again nothing was deleted.
   
   `dvc gc`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
   As you see, only one version of the file has remained in the cache,
   the one corresponding to the version that is present in the
   workspace, the others have been deleted.
