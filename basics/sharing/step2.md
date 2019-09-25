# Using a central data storage

In the last example we saw that from `workspace-b` it is possible to
pull/push data from/to `workspace-a`, but we cannot do the same from
`workspace-a`. Actually, on `workspace-a` we can add the cache of
`workspace-b` as a remote storage, and then we would be able to
synchronize data from both sides.

However this is not the best way of collaborating and synchronizing
data. Imagine that we have to create another workspace, say
`workspace-c` and want to synchronize data among the three of
them. Then on `workspace-c` we would have to add remote storage links
for both `workspace-a` and `workspace-b`, and on `workspace-a` and
`workspace-b` would have to add remote links for `workspace-c`. As the
number of collaborating workspaces increases, this becomes quickly
very complex.

<img src="/dvc/courses/basics/sharing-data/assets/mesh-network.png" width="300"/>

Even with GIT we don't use this _mesh_ topology. Instead we use a
_star_ topology, with a central _bare_ repository used as a
synchronization node for all the other repositories.

<img src="/dvc/courses/basics/sharing-data/assets/star-network.png" width="300"/>

We can do the same in DVC, with a central data storage that is used as
a synchronization node for the caches of all the collaborating
workspaces.

1. Let's make a _bare_ central git repository:

   `cd`{{execute}}
   
   `mkdir central-repo.git`{{execute}}
   
   `cd central-repo.git`{{execute}}
   
   `git init --bare`{{execute}}
   
2. Now let's push all the content from `workspace-a` to
   `central-repo.git`:
   
   `cd ../workspace-a/`{{execute}}
   
   `git remote -v`{{execute}}
   
   ```
   git remote add \
       origin ../central-repo.git
   ```{{execute}}
   
   `git remote -v`{{execute}}
   
   `git push origin --mirror`{{execute}}
   
   ```
   git branch \
       --set-upstream-to=origin/master
   ```{{execute}}
   
   `git status`{{execute}}
   
   `cd ../central-repo.git/`{{execute}}
   
   `git tag`{{execute}}
   
   `git log`{{execute}}
   
3. Let's clone as well `central-repo.git` to `workspace-b`:
   
   `cd`{{execute}}
   
   `rm -rf workspace-b/`{{execute}}
   
   ```
   git clone \
       central-repo.git workspace-b
   ```{{execute}}
   
   `cd workspace-b/`{{execute}}

   `git remote -v`{{execute}}

4. Let's make a central DVC storage:

   `cd`{{execute}}
   
   `mkdir central-cache.dvc`{{execute}}
   
5. Let's push all the data from `workspace-a` to
   `central-cache.dvc`:
   
   `cd workspace-a/`{{execute}}
   
   `dvc remote list`{{execute}}
   
   ```
   dvc remote add --default \
       data-storage ../central-cache.dvc
   ```{{execute}}
   
   `dvc remote list`{{execute}}
   
   ```
   dvc status --cloud \
       --all-branches --all-tags
   ```{{execute}}
   
   `dvc push --all-branches --all-tags`{{execute}}
   
   `dvc status -c -a -T`{{execute}}
   
   `tree ../central-cache.dvc/`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   
6. Now let's connect `workspace-b` to the central data storage:
 
   `cd`{{execute}}
   
   `cd workspace-a/`{{execute}}
   
   `git status`{{execute}}
   
   `git diff .dvc/config`{{execute}}
   
   `git add .dvc/config`{{execute}}
   
   `git commit -m 'Connect to the central storage'`{{execute}}
   
   `git status`{{execute}}
   
   `git push`{{execute}}
   
   `cd ../workspace-b/`{{execute}}
   
   `git pull`{{execute}}
   
   `cat .dvc/config`{{execute}}
   
   `dvc remote list`{{execute}}
   
   `dvc status`{{execute}}
   
   `dvc status --cloud`{{execute}}
   
   `dvc pull`{{execute}}
   
   `dvc status --cloud`{{execute}}
   
   `dvc status`{{execute}}
   
   `tree .dvc/cache/`{{execute}}
   

Notice that:

1. We used GIT to synchronize the configuration file `.dvc/config`
   between `workspace-a` and `workspace-b`, so the remote storage that
   we added on `workspace-a` became available automatically on
   `workspace-b`. This way we ensure that both workspaces use the same
   remote storage.

2. The commands `dvc push` and `dvc pull` (as well as `dvc fetch`) are
   conservative. By default they copy only the minimum amount of data
   that satisfies the requirements of the current state of the
   workspace. To increase the range of the copied data, we can use the
   options `-a, --all-branches` and `-T, --all-tags`.
   
3. The command `dvc status --cloud` as well can use the options
   `-a, --all-branches` and `-T, --all-tags` when comparing the local
   cache with the remote cache.
